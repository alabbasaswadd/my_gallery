import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';

class ProductCard extends StatelessWidget {
  final ProductListItem product;
  final VoidCallback? onTap;
  final int index;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasDiscount =
        product.discountPrice != null && product.discountPrice! < product.price;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildImage(context)),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (product.categoryName != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      product.categoryName!,
                      style: theme.textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  _buildPrice(context, hasDiscount),
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

  Widget _buildImage(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: 'product-image-${product.id}',
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AppNetworkImage(
              imagePath: product.imageUrl,
              width: double.infinity,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: product.isActive
                  ? Colors.green.withValues(alpha: 0.9)
                  : Colors.grey.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              product.isActive ? 'نشط' : 'غير نشط',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrice(BuildContext context, bool hasDiscount) {
    final theme = Theme.of(context);
    if (!hasDiscount) {
      return Text(
        '${product.price.toStringAsFixed(0)} س.ل',
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      );
    }
    return Row(
      children: [
        Text(
          '${product.discountPrice!.toStringAsFixed(0)} س.ل',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '${product.price.toStringAsFixed(0)} س.ل',
          style: theme.textTheme.bodySmall?.copyWith(
            decoration: TextDecoration.lineThrough,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }
}
