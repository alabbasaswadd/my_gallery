import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/cart/data/models/cart_item.dart';
import 'package:my_gallery/features/cart/domain/cart_cubit.dart';
import 'package:my_gallery/features/storefront/data/models/storefront_models.dart';
import 'package:my_gallery/features/storefront/data/storefront_service.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';

class StorefrontProductDetailScreen extends StatefulWidget {
  final int productId;
  const StorefrontProductDetailScreen({super.key, required this.productId});

  @override
  State<StorefrontProductDetailScreen> createState() =>
      _StorefrontProductDetailScreenState();
}

class _StorefrontProductDetailScreenState
    extends State<StorefrontProductDetailScreen> {
  StorefrontProductDetail? _product;
  bool _loading = true;
  String? _error;
  int _carousel = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final product =
          await context.read<StorefrontService>().getProduct(widget.productId);
      if (mounted) {
        setState(() {
          _product = product;
          _loading = false;
        });
      }
    } on ApiException catch (e) {
      if (mounted) {
        setState(() {
          _error = e.message;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _error = 'تعذّر تحميل المنتج';
          _loading = false;
        });
      }
    }
  }

  void _addToCart(StorefrontProductDetail p) {
    final effectivePrice = p.discountPrice ?? p.price;
    final coverImage = p.images.firstWhere(
      (i) => i.isCover,
      orElse: () => p.images.isNotEmpty
          ? p.images.first
          : const StorefrontImage(id: 0, url: ''),
    );
    context.read<CartCubit>().add(CartItem(
          productId: p.id,
          name: p.name,
          unitPrice: effectivePrice,
          imageUrl: coverImage.url.isNotEmpty ? coverImage.url : null,
        ));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تمت الإضافة إلى السلة: ${p.name}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null || _product == null) {
      return Scaffold(
        appBar: AppBar(),
        body: ErrorState(message: _error ?? 'خطأ', onRetry: _load),
      );
    }
    final p = _product!;
    final hasDiscount = p.discountPrice != null && p.discountPrice! < p.price;
    final effectivePrice = hasDiscount ? p.discountPrice! : p.price;

    return Scaffold(
      appBar: AppBar(
        title: Text(p.name),
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (_, cartState) {
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
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFC0446A),
                          shape: BoxShape.circle,
                        ),
                        child: Text('$count',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10)),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (p.images.isNotEmpty) ...[
              CarouselSlider(
                options: CarouselOptions(
                  height: 280,
                  viewportFraction: 1,
                  onPageChanged: (i, _) => setState(() => _carousel = i),
                ),
                items: p.images.map((img) {
                  return Hero(
                    tag: img.isCover
                        ? 'sf-product-${p.id}'
                        : 'sf-img-${img.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AppNetworkImage(
                        imagePath: img.url,
                        height: 280,
                        width: double.infinity,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(p.images.length, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _carousel == i ? 16 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _carousel == i
                          ? theme.colorScheme.primary
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ] else
              Hero(
                tag: 'sf-product-${p.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: const AppNetworkImage(
                    imagePath: null,
                    height: 240,
                    width: double.infinity,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Text(p.name, style: theme.textTheme.headlineMedium)
                .animate()
                .fadeIn(duration: 250.ms),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${effectivePrice.toStringAsFixed(0)} س.ل',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (hasDiscount) ...[
                  const SizedBox(width: 10),
                  Text(
                    '${p.price.toStringAsFixed(0)} س.ل',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ],
            ),
            if (p.shortDescription != null) ...[
              const SizedBox(height: 12),
              Text(p.shortDescription!, style: theme.textTheme.bodyMedium),
            ],
            if (p.description != null && p.description!.isNotEmpty) ...[
              const Divider(height: 28),
              Text('التفاصيل', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(p.description!, style: theme.textTheme.bodyMedium),
            ],
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: ElevatedButton.icon(
            onPressed: () => _addToCart(p),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('أضف إلى السلة'),
          ),
        ),
      ),
    );
  }
}
