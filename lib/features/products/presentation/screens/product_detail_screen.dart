import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/core/constants/colors.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/occasions/data/models/occasion_models.dart';
import 'package:my_gallery/features/occasions/data/occasions_service.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';
import 'package:my_gallery/features/products/domain/product_detail_cubit.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductDetailCubit>().load(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailCubit, ProductDetailState>(
      listener: (context, state) {
        switch (state) {
          case ProductDetailActionSuccess(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          case ProductDetailError(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          default:
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('تفاصيل المنتج'),
            actions: [
              if (state is ProductDetailLoaded)
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => context.push(
                    '/products/${widget.productId}/edit',
                    extra: state.product,
                  ),
                ),
            ],
          ),
          body: switch (state) {
            ProductDetailLoading() => const Center(child: CircularProgressIndicator()),
            ProductDetailLoaded(:final product) => _buildContent(context, product),
            ProductDetailActionSuccess(:final product) => _buildContent(context, product),
            ProductDetailError(:final message) => ErrorState(
                message: message,
                onRetry: () => context.read<ProductDetailCubit>().load(widget.productId),
              ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, ProductDetail product) {
    final theme = Theme.of(context);
    final authState = context.watch<AuthCubit>().state;
    final isOwner = authState is AuthAuthenticated &&
        authState.user.role == 'Owner';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageCarousel(product),
          const SizedBox(height: 16),
          _buildQuickActions(context, product, isOwner),
          const SizedBox(height: 20),
          Text(product.name, style: theme.textTheme.headlineMedium)
              .animate().fadeIn(duration: 300.ms),
          const SizedBox(height: 8),
          _buildPriceRow(context, product),
          if (product.shortDescription != null) ...[
            const SizedBox(height: 12),
            Text(product.shortDescription!, style: theme.textTheme.bodyMedium),
          ],
          const Divider(height: 32),
          _buildDetailGrid(context, product),
          if (product.description != null && product.description!.isNotEmpty) ...[
            const Divider(height: 32),
            Text('الوصف', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(product.description!, style: theme.textTheme.bodyMedium),
          ],
          if (product.occasionIds.isNotEmpty) ...[
            const Divider(height: 32),
            _SuitableFor(occasionIds: product.occasionIds),
          ],
          if (isOwner) ...[
            const Divider(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _confirmDelete(context, product),
                icon: Icon(Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error),
                label: Text('حذف المنتج',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.error),
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _replaceImage(BuildContext context, int imageId) async {
    final picked =
        await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 90);
    if (picked == null || !mounted) return;
    await context.read<ProductDetailCubit>().replaceImage(imageId, File(picked.path));
  }

  Widget _buildImageCarousel(ProductDetail product) {
    if (product.images.isEmpty) {
      return Hero(
        tag: 'product-image-${product.id}',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AppNetworkImage(imagePath: null, height: 240, width: double.infinity),
        ),
      );
    }
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 260,
            viewportFraction: 1,
            onPageChanged: (i, _) => setState(() => _currentImageIndex = i),
          ),
          items: product.images.map((img) {
            final isCover = img.isCover;
            return Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: isCover ? 'product-image-${product.id}' : 'img-${img.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AppNetworkImage(
                      imagePath: img.url,
                      height: 260,
                      width: double.infinity,
                    ),
                  ),
                ),
                if (isCover)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('غلاف',
                          style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                  ),
                // Per-image management menu (set cover / replace / delete).
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: AppColors.imageScrim,
                    borderRadius: BorderRadius.circular(20),
                    child: PopupMenuButton<String>(
                      tooltip: 'خيارات الصورة',
                      icon: const Icon(Icons.more_vert,
                          color: Colors.white, size: 20),
                      onSelected: (v) {
                        switch (v) {
                          case 'cover':
                            context.read<ProductDetailCubit>().setCover(img.id);
                          case 'replace':
                            _replaceImage(context, img.id);
                          case 'delete':
                            _confirmDeleteImage(context, img.id);
                        }
                      },
                      itemBuilder: (_) => [
                        if (!isCover)
                          const PopupMenuItem(
                              value: 'cover', child: Text('تعيين كغلاف')),
                        const PopupMenuItem(
                            value: 'replace', child: Text('استبدال الصورة')),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('حذف الصورة',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.error)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(product.images.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentImageIndex == i ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentImageIndex == i
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildQuickActions(
      BuildContext context, ProductDetail product, bool isOwner) {
    final cubit = context.read<ProductDetailCubit>();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FilledButton.tonal(
          onPressed: () => cubit.toggleActive(),
          child: Text(product.isActive ? 'إلغاء التفعيل' : 'تفعيل'),
        ),
        FilledButton.tonal(
          onPressed: () => _showEditStock(context, product),
          child: const Text('المخزون'),
        ),
        FilledButton.tonal(
          onPressed: () => _showEditPrice(context, product),
          child: const Text('السعر'),
        ),
        FilledButton.tonal(
          onPressed: () => _showEditDiscount(context, product),
          child: const Text('الخصم'),
        ),
        FilledButton.tonal(
          onPressed: () => cubit.duplicate(),
          child: const Text('نسخ'),
        ),
        FilledButton.tonal(
          onPressed: () => _addImages(context),
          child: const Text('إضافة صور'),
        ),
      ],
    );
  }

  Future<void> _addImages(BuildContext context) async {
    final picked = await ImagePicker().pickMultiImage(imageQuality: 90);
    if (picked.isEmpty || !mounted) return;
    final files = picked.map((x) => File(x.path)).toList();
    await context.read<ProductDetailCubit>().uploadImages(files);
  }

  void _confirmDeleteImage(BuildContext context, int imageId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('حذف الصورة'),
        content: const Text('هل تريد حذف هذه الصورة؟'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProductDetailCubit>().deleteImage(imageId);
            },
            child: Text('حذف',
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, ProductDetail product) {
    final theme = Theme.of(context);
    final hasDiscount = product.discountPrice != null;
    return Row(
      children: [
        Text(
          '${(hasDiscount ? product.discountPrice! : product.price).toStringAsFixed(0)} س.ل',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (hasDiscount) ...[
          const SizedBox(width: 8),
          Text(
            '${product.price.toStringAsFixed(0)} س.ل',
            style: theme.textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDetailGrid(BuildContext context, ProductDetail product) {
    final theme = Theme.of(context);
    final items = [
      ('المخزون', '${product.stockQuantity}'),
      ('الحالة', product.isActive ? 'نشط' : 'غير نشط'),
      if (product.sku != null) ('رمز SKU', product.sku!),
      if (product.barcode != null) ('الباركود', product.barcode!),
      ('مميز', product.isFeatured ? 'نعم' : 'لا'),
      ('جديد', product.isNew ? 'نعم' : 'لا'),
      ('متاح', product.isAvailable ? 'نعم' : 'لا'),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.$1, style: theme.textTheme.bodySmall),
              const SizedBox(height: 2),
              Text(item.$2, style: theme.textTheme.titleMedium),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _showEditStock(BuildContext context, ProductDetail product) {
    final ctrl = TextEditingController(text: product.stockQuantity.toString());
    _showEditSheet(
      context,
      title: 'تعديل المخزون',
      controller: ctrl,
      keyboardType: TextInputType.number,
      label: 'الكمية',
      onSave: () {
        final val = int.tryParse(ctrl.text);
        if (val != null) context.read<ProductDetailCubit>().updateStock(val);
      },
    );
  }

  void _showEditPrice(BuildContext context, ProductDetail product) {
    final ctrl = TextEditingController(text: product.price.toStringAsFixed(0));
    _showEditSheet(
      context,
      title: 'تعديل السعر',
      controller: ctrl,
      keyboardType: TextInputType.number,
      label: 'السعر (س.ل)',
      onSave: () {
        final val = double.tryParse(ctrl.text);
        if (val != null) context.read<ProductDetailCubit>().updatePrice(val);
      },
    );
  }

  void _showEditDiscount(BuildContext context, ProductDetail product) {
    final ctrl = TextEditingController(
        text: product.discountPrice?.toStringAsFixed(0) ?? '');
    _showEditSheet(
      context,
      title: 'تعديل الخصم',
      controller: ctrl,
      keyboardType: TextInputType.number,
      label: 'سعر الخصم (س.ل) — اتركه فارغاً لإلغائه',
      onSave: () {
        final val = ctrl.text.isEmpty ? null : double.tryParse(ctrl.text);
        context.read<ProductDetailCubit>().updateDiscount(val);
      },
    );
  }

  void _showEditSheet(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String label,
    required VoidCallback onSave,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: keyboardType,
              autofocus: true,
              decoration: InputDecoration(labelText: label),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onSave();
                Navigator.pop(context);
              },
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, ProductDetail product) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('حذف المنتج'),
        content: Text('هل تريد حذف "${product.name}" نهائياً؟'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await context.read<ProductDetailCubit>().delete();
              if (context.mounted) context.pop();
            },
            child: Text('حذف', style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        ],
      ),
    );
  }
}

/// "مناسب لـ" — resolves the product's occasion ids to names and shows them as chips.
class _SuitableFor extends StatefulWidget {
  final List<int> occasionIds;
  const _SuitableFor({required this.occasionIds});

  @override
  State<_SuitableFor> createState() => _SuitableForState();
}

class _SuitableForState extends State<_SuitableFor> {
  List<OccasionListItem> _matched = const [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final all = await OccasionsService().getOccasions();
      final ids = widget.occasionIds.toSet();
      if (mounted) {
        setState(() {
          _matched = all.where((o) => ids.contains(o.id)).toList();
          _loaded = true;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loaded = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded || _matched.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('مناسب لـ', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final o in _matched)
              Chip(
                label: Text(o.name),
                avatar: Icon(Icons.celebration_outlined,
                    size: 16, color: theme.colorScheme.primary),
              ),
          ],
        ),
      ],
    );
  }
}
