import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';
import 'package:my_gallery/features/products/domain/products_list_cubit.dart';
import 'package:my_gallery/features/products/presentation/widgets/product_card.dart';
import 'package:my_gallery/features/products/presentation/widgets/products_filter_sheet.dart';
import 'package:my_gallery/shared/widgets/app_shimmer.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _searchCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ProductsListCubit>().load();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollCtrl.position.pixels >=
        _scrollCtrl.position.maxScrollExtent - 200) {
      context.read<ProductsListCubit>().loadMore();
    }
  }

  void _onSearch(String query) {
    final cubit = context.read<ProductsListCubit>();
    cubit.applyFilter(cubit.currentFilter.copyWith(search: query, page: 1));
  }

  void _showFilter(BuildContext context, ProductFilter current) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ProductsFilterSheet(
        currentFilter: current,
        onApply: (f) => context.read<ProductsListCubit>().applyFilter(f),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المنتجات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/products/create'),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(context),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: BlocBuilder<ProductsListCubit, ProductsListState>(
        builder: (context, state) {
          final filter =
              state is ProductsListLoaded ? state.filter : const ProductFilter();
          return Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  onSubmitted: _onSearch,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    hintText: 'بحث عن منتج...',
                    prefixIcon: Icon(Icons.search),
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
        return switch (state) {
          ProductsListLoading() => _buildShimmer(),
          ProductsListLoaded(:final items, :final pagination) =>
            items.isEmpty
                ? EmptyState(
                    message: 'لا توجد منتجات',
                    icon: Icons.inventory_2_outlined,
                    actionLabel: 'إضافة منتج',
                    onAction: () => context.push('/products/create'),
                  )
                : RefreshIndicator(
                    onRefresh: () =>
                        context.read<ProductsListCubit>().refresh(),
                    child: GridView.builder(
                      controller: _scrollCtrl,
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
                          onTap: () =>
                              context.push('/products/${product.id}'),
                        );
                      },
                    ),
                  ),
          ProductsListError(:final message) => ErrorState(
              message: message,
              onRetry: () => context.read<ProductsListCubit>().load(),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildShimmer() {
    return GridView.builder(
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
}
