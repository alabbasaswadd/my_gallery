import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/features/cart/domain/cart_cubit.dart';
import 'package:my_gallery/features/occasions/data/models/occasion_models.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/features/storefront/data/models/storefront_models.dart';
import 'package:my_gallery/features/storefront/data/storefront_service.dart';
import 'package:my_gallery/features/storefront/domain/storefront_cubit.dart';
import 'package:my_gallery/shared/widgets/app_shimmer.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';

class StorefrontScreen extends StatefulWidget {
  const StorefrontScreen({super.key});

  @override
  State<StorefrontScreen> createState() => _StorefrontScreenState();
}

class _StorefrontScreenState extends State<StorefrontScreen> {
  final _searchCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<StorefrontCubit>().load();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels >=
          _scrollCtrl.position.maxScrollExtent - 200) {
        context.read<StorefrontCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المعرض'),
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              final count = cartState.items.fold(0, (s, i) => s + i.quantity);
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () => context.push('/storefront/cart'),
                  ),
                  if (count > 0)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: () => context.push('/storefront/cart'),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                            .animate(key: ValueKey(count))
                            .scale(
                                begin: const Offset(0.5, 0.5),
                                duration: 200.ms,
                                curve: Curves.elasticOut),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<StorefrontCubit, StorefrontState>(
        builder: (context, state) {
          return switch (state) {
            StorefrontLoading() => _buildShimmer(),
            StorefrontLoaded(
              :final products,
              :final categories,
              :final selectedCategoryId,
              :final pagination,
              :final categoriesError,
            ) =>
              Column(
                children: [
                  _buildHero(context),
                  const _PopularOccasions(),
                  _buildSearch(context),
                  if (categoriesError != null)
                    _buildCategoriesError(context, categoriesError)
                  else
                    _buildCategories(context, categories, selectedCategoryId),
                  Expanded(
                    child: products.isEmpty
                        ? const EmptyState(
                            message: 'لا توجد منتجات',
                            icon: Icons.inbox_outlined,
                          )
                        : RefreshIndicator(
                            onRefresh: () =>
                                context.read<StorefrontCubit>().refresh(),
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
                              itemCount: products.length +
                                  (pagination.hasNext ? 2 : 0),
                              itemBuilder: (_, i) {
                                if (i >= products.length) {
                                  return const ProductCardShimmer();
                                }
                                return _ProductCard(
                                  product: products[i],
                                  index: i,
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            StorefrontError(:final message) => ErrorState(
                message: message,
                onRetry: () => context.read<StorefrontCubit>().load(),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final slides = context
        .watch<SettingsCubit>()
        .currentOrDefault
        .heroSlides
        .where((s) => s.imageUrl.isNotEmpty)
        .toList();
    if (slides.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 160,
          viewportFraction: 1,
          autoPlay: slides.length > 1,
          autoPlayInterval: const Duration(seconds: 5),
        ),
        items: slides.map((s) => _buildHeroSlide(context, s)).toList(),
      ),
    );
  }

  Widget _buildHeroSlide(BuildContext context, HeroSlide slide) {
    final title = slide.title ?? '';
    final subtitle = slide.subtitle ?? '';
    final ctaText = slide.ctaText ?? '';
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppNetworkImage(
            imagePath: slide.imageUrl,
            height: 160,
            width: double.infinity,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.55),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            left: 16,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title.isNotEmpty)
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
                if (ctaText.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      ctaText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: TextField(
        controller: _searchCtrl,
        textInputAction: TextInputAction.search,
        onSubmitted: (q) =>
            context.read<StorefrontCubit>().filter(search: q.trim()),
        decoration: InputDecoration(
          hintText: 'بحث في المنتجات...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchCtrl.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchCtrl.clear();
                    context.read<StorefrontCubit>().filter();
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildCategoriesError(BuildContext context, String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_outlined, size: 16, color: Colors.orange),
          const SizedBox(width: 6),
          Expanded(
            child: Text(error,
                style: Theme.of(context).textTheme.bodySmall),
          ),
          TextButton(
            onPressed: () => context.read<StorefrontCubit>().retryCategories(),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(
    BuildContext context,
    List<StorefrontCategory> categories,
    int? selectedId,
  ) {
    if (categories.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          if (i == 0) {
            return FilterChip(
              label: const Text('الكل'),
              selected: selectedId == null,
              onSelected: (_) => context.read<StorefrontCubit>().filter(),
            );
          }
          final cat = categories[i - 1];
          return FilterChip(
            label: Text(cat.name),
            selected: selectedId == cat.id,
            onSelected: (_) =>
                context.read<StorefrontCubit>().filter(categoryId: cat.id),
          );
        },
      ),
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

class _ProductCard extends StatelessWidget {
  final StorefrontProduct product;
  final int index;

  const _ProductCard({required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasDiscount =
        product.discountPrice != null && product.discountPrice! < product.price;
    final effectivePrice = hasDiscount ? product.discountPrice! : product.price;

    return GestureDetector(
      onTap: () => context.push('/storefront/products/${product.id}'),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'sf-product-${product.id}',
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: AppNetworkImage(
                  imagePath: product.imageUrl,
                  height: 150,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '${effectivePrice.toStringAsFixed(0)} س.ل',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (hasDiscount) ...[
                        const SizedBox(width: 6),
                        Text(
                          product.price.toStringAsFixed(0),
                          style: theme.textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(delay: (index * 40).ms, duration: 300.ms)
          .slideY(begin: 0.08, end: 0),
    );
  }
}

/// Horizontal "Popular Occasions" strip on the storefront home.
class _PopularOccasions extends StatefulWidget {
  const _PopularOccasions();

  @override
  State<_PopularOccasions> createState() => _PopularOccasionsState();
}

class _PopularOccasionsState extends State<_PopularOccasions> {
  final _service = StorefrontService();
  List<OccasionListItem> _occasions = const [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final occasions = await _service.getOccasions();
      if (mounted) {
        setState(() {
          _occasions = occasions;
          _loaded = true;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loaded = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded || _occasions.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text('مناسبات مميّزة', style: theme.textTheme.titleMedium),
        ),
        SizedBox(
          height: 108,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _occasions.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) {
              final o = _occasions[i];
              return GestureDetector(
                onTap: () => context.push('/storefront/occasions/${o.id}',
                    extra: o.name),
                child: SizedBox(
                  width: 84,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AppNetworkImage(
                          imagePath: o.imageUrl,
                          width: 72,
                          height: 72,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        o.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: (i * 50).ms, duration: 250.ms);
            },
          ),
        ),
      ],
    );
  }
}
