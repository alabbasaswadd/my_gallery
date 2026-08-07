import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/core/constants/colors.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/categories/data/categories_service.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';
import 'package:my_gallery/features/occasions/data/models/occasion_models.dart';
import 'package:my_gallery/features/occasions/data/occasions_service.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';
import 'package:my_gallery/features/products/domain/product_detail_cubit.dart';
import 'package:my_gallery/features/products/presentation/widgets/product_share_sheet.dart';
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
              SnackBar(
                content: Text(message),
                behavior: SnackBarBehavior.floating,
              ),
            );
          case ProductDetailError(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          default:
            break;
        }
      },
      builder: (context, state) {
        final product = switch (state) {
          ProductDetailLoaded(:final product) => product,
          ProductDetailActionSuccess(:final product) => product,
          _ => null,
        };
        return Scaffold(
          appBar: AppBar(
            title: const Text('تفاصيل المنتج'),
            actions: [
              if (product != null) ...[
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  tooltip: 'مشاركة',
                  onPressed: () => showProductShareSheet(
                    context,
                    productId: product.id,
                    productName: product.name,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'تعديل',
                  onPressed: () => context.push(
                    '/products/${widget.productId}/edit',
                    extra: product,
                  ),
                ),
              ],
            ],
          ),
          body: switch (state) {
            ProductDetailLoading() => const _LoadingSkeleton(),
            ProductDetailLoaded(:final product) => _buildContent(
              context,
              product,
            ),
            ProductDetailActionSuccess(:final product) => _buildContent(
              context,
              product,
            ),
            ProductDetailError(:final message) => ErrorState(
              message: message,
              onRetry: () =>
                  context.read<ProductDetailCubit>().load(widget.productId),
            ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, ProductDetail product) {
    final authState = context.watch<AuthCubit>().state;
    final isOwner =
        authState is AuthAuthenticated && authState.user.role == 'Owner';

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        _buildImageCarousel(
          product,
        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.04, end: 0),
        const SizedBox(height: 16),
        _HeaderCard(
          product: product,
        ).animate().fadeIn(delay: 80.ms, duration: 300.ms),
        const SizedBox(height: 12),
        _ManagementCard(
          product: product,
          onStock: () => _showEditStock(context, product),
          onPrice: () => _showEditPrice(context, product),
          onDiscount: () => _showEditDiscount(context, product),
          onAddImages: () => _addImages(context),
        ).animate().fadeIn(delay: 140.ms, duration: 300.ms),
        const SizedBox(height: 12),
        _InfoCard(
          product: product,
        ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
        if (product.categoryId != null || product.occasionIds.isNotEmpty) ...[
          const SizedBox(height: 12),
          _TaxonomyCard(
            categoryId: product.categoryId,
            occasionIds: product.occasionIds,
          ).animate().fadeIn(delay: 260.ms, duration: 300.ms),
        ],
        if (product.description != null && product.description!.isNotEmpty) ...[
          const SizedBox(height: 12),
          _DescriptionCard(
            description: product.description!,
          ).animate().fadeIn(delay: 320.ms, duration: 300.ms),
        ],
        if (isOwner) ...[
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _confirmDelete(context, product),
              icon: Icon(
                Icons.delete_outline,
                color: Theme.of(context).colorScheme.error,
              ),
              label: Text(
                'حذف المنتج',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                side: BorderSide(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ── Image gallery ──────────────────────────────────────────────────────
  Widget _buildImageCarousel(ProductDetail product) {
    final radius = BorderRadius.circular(20);
    if (product.images.isEmpty) {
      return Hero(
        tag: 'product-image-${product.id}',
        child: ClipRRect(
          borderRadius: radius,
          child: AppNetworkImage(
            imagePath: null,
            height: 280,
            width: double.infinity,
          ),
        ),
      );
    }
    return Column(
      children: [
        ClipRRect(
          borderRadius: radius,
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1,
                  onPageChanged: (i, _) =>
                      setState(() => _currentImageIndex = i),
                ),
                items: product.images.map((img) {
                  final isCover = img.isCover;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: isCover
                            ? 'product-image-${product.id}'
                            : 'img-${img.id}',
                        child: AppNetworkImage(
                          imagePath: img.url,
                          height: 300,
                          width: double.infinity,
                        ),
                      ),
                      if (isCover)
                        PositionedDirectional(
                          top: 10,
                          start: 10,
                          child: _Badge(
                            label: 'الغلاف',
                            icon: Icons.star_rounded,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      PositionedDirectional(
                        top: 6,
                        end: 6,
                        child: Material(
                          color: AppColors.imageScrim,
                          borderRadius: BorderRadius.circular(20),
                          child: PopupMenuButton<String>(
                            tooltip: 'خيارات الصورة',
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 20,
                            ),
                            onSelected: (v) {
                              switch (v) {
                                case 'cover':
                                  context.read<ProductDetailCubit>().setCover(
                                    img.id,
                                  );
                                case 'replace':
                                  _replaceImage(context, img.id);
                                case 'delete':
                                  _confirmDeleteImage(context, img.id);
                              }
                            },
                            itemBuilder: (_) => [
                              if (!isCover)
                                const PopupMenuItem(
                                  value: 'cover',
                                  child: Text('تعيين كغلاف'),
                                ),
                              const PopupMenuItem(
                                value: 'replace',
                                child: Text('استبدال الصورة'),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text(
                                  'حذف الصورة',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (product.images.length > 1)
                        PositionedDirectional(
                          bottom: 10,
                          end: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.imageScrim,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_currentImageIndex + 1}/${product.images.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        if (product.images.length > 1) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(product.images.length, (i) {
              final active = _currentImageIndex == i;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: active ? 20 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: active
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }

  Future<void> _replaceImage(BuildContext context, int imageId) async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (picked == null || !mounted) return;
    await context.read<ProductDetailCubit>().replaceImage(
      imageId,
      File(picked.path),
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
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProductDetailCubit>().deleteImage(imageId);
            },
            child: Text(
              'حذف',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  // ── Edit sheets ────────────────────────────────────────────────────────
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
      text: product.discountPrice?.toStringAsFixed(0) ?? '',
    );
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
      showDragHandle: true,
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          0,
          20,
          20 + MediaQuery.of(context).viewInsets.bottom,
        ),
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
            FilledButton(
              onPressed: () {
                onSave();
                Navigator.pop(context);
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
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
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await context.read<ProductDetailCubit>().delete();
              if (context.mounted) context.pop();
            },
            child: Text(
              'حذف',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════
// Header: name, badges, price, stock
// ════════════════════════════════════════════════════════════════════════
class _HeaderCard extends StatelessWidget {
  final ProductDetail product;
  const _HeaderCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final hasDiscount =
        product.discountPrice != null && product.discountPrice! < product.price;
    final percent = hasDiscount
        ? (((product.price - product.discountPrice!) / product.price) * 100)
              .round()
        : 0;

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatusChip(
                label: product.isActive ? 'نشط' : 'غير نشط',
                color: product.isActive ? AppColors.statusActive : cs.outline,
                filled: product.isActive,
              ),
              if (product.isNew)
                _StatusChip(label: 'جديد', color: AppColors.statusNew),
              if (product.isFeatured)
                _StatusChip(label: 'مميّز', color: cs.tertiary),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            product.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
          ),
          if (product.shortDescription != null &&
              product.shortDescription!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              product.shortDescription!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _price(hasDiscount ? product.discountPrice! : product.price),
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (hasDiscount) ...[
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    _price(product.price),
                    style: theme.textTheme.titleMedium?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: cs.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: cs.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'خصم $percent٪',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: cs.onErrorContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          _StockPill(quantity: product.stockQuantity),
        ],
      ),
    );
  }

  String _price(double v) => '${v.toStringAsFixed(0)} س.ل';
}

class _StockPill extends StatelessWidget {
  final int quantity;
  const _StockPill({required this.quantity});

  @override
  Widget build(BuildContext context) {
    final (color, icon, label) = switch (quantity) {
      <= 0 => (
        Theme.of(context).colorScheme.error,
        Icons.remove_shopping_cart_outlined,
        'غير متوفر',
      ),
      <= 5 => (
        AppColors.statusNew,
        Icons.inventory_2_outlined,
        'كمية محدودة ($quantity)',
      ),
      _ => (
        AppColors.statusActive,
        Icons.check_circle_outline_rounded,
        'متوفر ($quantity)',
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════
// Management quick actions
// ════════════════════════════════════════════════════════════════════════
class _ManagementCard extends StatelessWidget {
  final ProductDetail product;
  final VoidCallback onStock;
  final VoidCallback onPrice;
  final VoidCallback onDiscount;
  final VoidCallback onAddImages;

  const _ManagementCard({
    required this.product,
    required this.onStock,
    required this.onPrice,
    required this.onDiscount,
    required this.onAddImages,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailCubit>();
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: Icons.tune_rounded, title: 'إجراءات سريعة'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.tonalIcon(
                onPressed: () => cubit.toggleActive(),
                icon: Icon(
                  product.isActive
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                label: Text(product.isActive ? 'إلغاء التفعيل' : 'تفعيل'),
              ),
              FilledButton.tonalIcon(
                onPressed: onStock,
                icon: const Icon(Icons.inventory_2_outlined),
                label: const Text('المخزون'),
              ),
              FilledButton.tonalIcon(
                onPressed: onPrice,
                icon: const Icon(Icons.sell_outlined),
                label: const Text('السعر'),
              ),
              FilledButton.tonalIcon(
                onPressed: onDiscount,
                icon: const Icon(Icons.percent_rounded),
                label: const Text('الخصم'),
              ),
              FilledButton.tonalIcon(
                onPressed: () => cubit.duplicate(),
                icon: const Icon(Icons.copy_all_outlined),
                label: const Text('نسخ'),
              ),
              FilledButton.tonalIcon(
                onPressed: onAddImages,
                icon: const Icon(Icons.add_photo_alternate_outlined),
                label: const Text('إضافة صور'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════
// Product information grid
// ════════════════════════════════════════════════════════════════════════
class _InfoCard extends StatelessWidget {
  final ProductDetail product;
  const _InfoCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final rows = <(IconData, String, String)>[
      (
        Icons.confirmation_number_outlined,
        'المخزون',
        '${product.stockQuantity}',
      ),
      (
        Icons.check_circle_outline,
        'الحالة',
        product.isActive ? 'نشط' : 'غير نشط',
      ),
      (
        Icons.store_mall_directory_outlined,
        'متاح للبيع',
        product.isAvailable ? 'نعم' : 'لا',
      ),
      if (product.sku != null && product.sku!.isNotEmpty)
        (Icons.qr_code_rounded, 'رمز SKU', product.sku!),
      if (product.barcode != null && product.barcode!.isNotEmpty)
        (Icons.barcode_reader, 'الباركود', product.barcode!),
      if (product.weight != null)
        (Icons.scale_outlined, 'الوزن', '${product.weight} غ'),
      if (product.width != null ||
          product.height != null ||
          product.length != null)
        (
          Icons.straighten_outlined,
          'الأبعاد',
          '${_n(product.length)}×${_n(product.width)}×${_n(product.height)} سم',
        ),
    ];

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: Icons.info_outline_rounded, title: 'معلومات المنتج'),
          const SizedBox(height: 4),
          for (var i = 0; i < rows.length; i++) ...[
            _InfoRow(icon: rows[i].$1, label: rows[i].$2, value: rows[i].$3),
            if (i < rows.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }

  String _n(double? v) => v == null ? '—' : v.toStringAsFixed(0);
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: cs.primary),
          const SizedBox(width: 12),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════
// Category + occasions
// ════════════════════════════════════════════════════════════════════════
class _TaxonomyCard extends StatefulWidget {
  final int? categoryId;
  final List<int> occasionIds;
  const _TaxonomyCard({required this.categoryId, required this.occasionIds});

  @override
  State<_TaxonomyCard> createState() => _TaxonomyCardState();
}

class _TaxonomyCardState extends State<_TaxonomyCard> {
  String? _categoryName;
  List<OccasionListItem> _occasions = const [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      if (widget.categoryId != null) {
        final cats = await CategoriesService().getCategories();
        CategoryListItem? match;
        for (final c in cats) {
          if (c.id == widget.categoryId) {
            match = c;
            break;
          }
        }
        _categoryName = match?.name;
      }
      if (widget.occasionIds.isNotEmpty) {
        final all = await OccasionsService().getOccasions();
        final ids = widget.occasionIds.toSet();
        _occasions = all.where((o) => ids.contains(o.id)).toList();
      }
    } catch (_) {
      // Best-effort: leave whatever resolved.
    } finally {
      if (mounted) setState(() => _loaded = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final hasCategory = _categoryName != null && _categoryName!.isNotEmpty;
    final hasOccasions = _occasions.isNotEmpty;

    if (_loaded && !hasCategory && !hasOccasions) {
      return const SizedBox.shrink();
    }

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            icon: Icons.category_outlined,
            title: 'التصنيف والمناسبات',
          ),
          const SizedBox(height: 12),
          if (!_loaded)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: LinearProgressIndicator(),
            )
          else ...[
            if (hasCategory) ...[
              Text(
                'الفئة',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                children: [
                  Chip(
                    avatar: Icon(
                      Icons.folder_outlined,
                      size: 18,
                      color: cs.primary,
                    ),
                    label: Text(_categoryName!),
                  ),
                ],
              ),
            ],
            if (hasCategory && hasOccasions) const SizedBox(height: 12),
            if (hasOccasions) ...[
              Text(
                'مناسب لـ',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final o in _occasions)
                    Chip(
                      avatar: Icon(
                        Icons.celebration_outlined,
                        size: 18,
                        color: cs.primary,
                      ),
                      label: Text(o.name),
                    ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════
// Description
// ════════════════════════════════════════════════════════════════════════
class _DescriptionCard extends StatelessWidget {
  final String description;
  const _DescriptionCard({required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: Icons.description_outlined, title: 'الوصف'),
          const SizedBox(height: 10),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════
// Shared building blocks
// ════════════════════════════════════════════════════════════════════════
class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: child,
    );
  }
}

class _CardTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const _CardTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _Badge({required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool filled;
  const _StatusChip({
    required this.label,
    required this.color,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: filled ? color : color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: filled ? 1 : 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: filled ? Colors.white : color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════
// Loading skeleton
// ════════════════════════════════════════════════════════════════════════
class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Widget box(double h, {double? w, double r = 16}) => Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(r),
      ),
    );
    return ListView(
      padding: const EdgeInsets.all(16),
      children:
          [
                box(280, r: 20),
                const SizedBox(height: 20),
                box(18, w: 200),
                const SizedBox(height: 12),
                box(32, w: 140),
                const SizedBox(height: 24),
                box(120),
                const SizedBox(height: 12),
                box(160),
              ]
              .animate(onPlay: (c) => c.repeat())
              .fadeIn(duration: 600.ms)
              .then()
              .fadeOut(duration: 600.ms),
    );
  }
}
