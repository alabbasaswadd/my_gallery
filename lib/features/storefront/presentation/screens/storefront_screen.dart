import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/features/cart/domain/cart_cubit.dart';
import 'package:my_gallery/features/storefront/data/models/storefront_models.dart';
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
                          decoration: const BoxDecoration(
                            color: Color(0xFFC0446A),
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
            ) =>
              Column(
                children: [
                  _buildSearch(context),
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
