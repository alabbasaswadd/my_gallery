import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';
import 'package:my_gallery/features/categories/domain/categories_cubit.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';
import 'package:my_gallery/features/products/domain/products_list_cubit.dart';
import 'package:my_gallery/features/products/presentation/widgets/product_card.dart';
import 'package:my_gallery/features/products/presentation/widgets/products_filter_sheet.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/shared/widgets/app_shimmer.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';
import 'package:my_gallery/shared/widgets/theme_toggle_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _searchCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<ProductsListCubit>().load();
    _scrollCtrl.addListener(_onScroll);
    _searchCtrl.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _scrollCtrl.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() => setState(() {});

  void _onScroll() {
    if (_scrollCtrl.position.pixels >=
        _scrollCtrl.position.maxScrollExtent - 200) {
      context.read<ProductsListCubit>().loadMore();
    }
  }

  void _onSearch(String query) {
    final cubit = context.read<ProductsListCubit>();
    final trimmed = query.trim();
    final current = cubit.currentFilter;
    cubit.applyFilter(ProductFilter(
      search: trimmed.isEmpty ? null : trimmed,
      categoryId: current.categoryId,
      minPrice: current.minPrice,
      maxPrice: current.maxPrice,
      isActive: current.isActive,
      sort: current.sort,
      page: 1,
      pageSize: current.pageSize,
    ));
  }

  void _clearSearch() {
    _searchCtrl.clear();
    _searchFocus.unfocus();
    _onSearch('');
  }

  Future<void> _openCreate() async {
    await context.push('/products/create');
    if (mounted) context.read<ProductsListCubit>().refresh();
  }

  Future<void> _openProduct(int id) async {
    await context.push('/products/$id');
    if (mounted) context.read<ProductsListCubit>().refresh();
  }

  void _showFilter(BuildContext context, ProductFilter current) {
    final catState = context.read<CategoriesCubit>().state;
    final categories = catState is CategoriesLoaded
        ? catState.categories
        : const <CategoryListItem>[];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ProductsFilterSheet(
        currentFilter: current,
        categories: categories,
        onApply: (f) {
          // Sync search field text with filter
          _searchCtrl.text = f.search ?? '';
          context.read<ProductsListCubit>().applyFilter(f);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsCubit>().currentOrDefault;
    final authState = context.watch<AuthCubit>().state;
    final shopName = authState is AuthAuthenticated
        ? authState.user.shopName
        : settings.brandName;
    final role = authState is AuthAuthenticated ? authState.user.role : '';
    final website = settings.website;

    final canManage =
        role == 'Owner' || role == 'Manager' || role == 'Employee';

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(shopName),
            if (role.isNotEmpty)
              Text(
                _roleLabel(role),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.8),
                ),
              ),
          ],
        ),
        actions: [
          const ThemeToggleButton(),
          if (website.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.public_rounded),
              tooltip: 'زيارة الموقع',
              onPressed: () => _launchWebsite(context, website),
            ),
          if (canManage)
            IconButton(icon: const Icon(Icons.add), onPressed: _openCreate),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            _buildSearchBar(context),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: BlocBuilder<ProductsListCubit, ProductsListState>(
        builder: (context, state) {
          final filter = state is ProductsListLoaded
              ? state.filter
              : const ProductFilter();
          return Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  focusNode: _searchFocus,
                  onSubmitted: _onSearch,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'بحث عن منتج...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: _clearSearch,
                            tooltip: 'مسح البحث',
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: () => _showFilter(context, filter),
                icon: const Icon(Icons.tune),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ProductsListCubit, ProductsListState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () => context.read<ProductsListCubit>().refresh(),
          child: switch (state) {
            ProductsListLoading() => _buildShimmer(),
            ProductsListLoaded(:final items, :final pagination) =>
              items.isEmpty
                  ? CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverFillRemaining(
                          child: EmptyState(
                            message: 'لا توجد منتجات',
                            icon: Icons.inventory_2_outlined,
                            actionLabel: 'إضافة منتج',
                            onAction: _openCreate,
                          ),
                        ),
                      ],
                    )
                  : GridView.builder(
                      controller: _scrollCtrl,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.72,
                          ),
                      itemCount: items.length + (pagination.hasNext ? 2 : 0),
                      itemBuilder: (context, i) {
                        if (i >= items.length) {
                          return const ProductCardShimmer();
                        }
                        final product = items[i];
                        return ProductCard(
                          product: product,
                          index: i,
                          onTap: () => _openProduct(product.id),
                        );
                      },
                    ),
            ProductsListError(:final message, :final kind) => ErrorState(
              message: message,
              kind: kind,
              onRetry: () => context.read<ProductsListCubit>().load(),
            ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }

  Widget _buildShimmer() {
    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: 6,
      itemBuilder: (_, __) => const ProductCardShimmer(),
    );
  }

  String _roleLabel(String role) => switch (role) {
    'Owner' => 'مالك',
    'Manager' => 'مدير',
    'Employee' => 'موظف',
    _ => role,
  };

  Future<void> _launchWebsite(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      AppSnackbar.showError(context, 'تعذّر فتح الموقع');
    }
  }
}
