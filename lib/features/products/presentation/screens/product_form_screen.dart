import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';
import 'package:my_gallery/features/categories/domain/categories_cubit.dart';
import 'package:my_gallery/features/products/data/image_rules.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';
import 'package:my_gallery/features/products/domain/product_form_cubit.dart';

class ProductFormScreen extends StatefulWidget {
  final ProductDetail? existing;

  const ProductFormScreen({super.key, this.existing});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _price;
  late final TextEditingController _shortDesc;
  late final TextEditingController _desc;
  late final TextEditingController _sku;
  late final TextEditingController _stock;
  late final TextEditingController _discount;
  int? _categoryId;
  bool _isFeatured = false;
  bool _isNew = false;
  bool _isAvailable = true;
  bool _isActive = true;

  // Image state
  final List<File> _newImages = [];
  final Map<int, File> _replacements = {};
  final Set<int> _removeIds = {};
  int? _coverId;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final p = widget.existing;
    _name = TextEditingController(text: p?.name ?? '');
    _price = TextEditingController(text: p?.price.toStringAsFixed(0) ?? '');
    _shortDesc = TextEditingController(text: p?.shortDescription ?? '');
    _desc = TextEditingController(text: p?.description ?? '');
    _sku = TextEditingController(text: p?.sku ?? '');
    _stock = TextEditingController(text: p?.stockQuantity.toString() ?? '0');
    _discount =
        TextEditingController(text: p?.discountPrice?.toStringAsFixed(0) ?? '');
    _categoryId = p?.categoryId;
    _isFeatured = p?.isFeatured ?? false;
    _isNew = p?.isNew ?? false;
    _isAvailable = p?.isAvailable ?? true;
    _isActive = p?.isActive ?? true;
    _coverId = p?.images.where((i) => i.isCover).firstOrNull?.id;
    context.read<CategoriesCubit>().load();
  }

  @override
  void dispose() {
    for (final c in [_name, _price, _shortDesc, _desc, _sku, _stock, _discount]) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    // Fallback guard: the dropdown validator covers the loaded state; this also
    // covers the brief window where categories are still loading/failed.
    if (_categoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار الفئة')),
      );
      return;
    }
    final request = ProductRequest(
      name: _name.text.trim(),
      categoryId: _categoryId!,
      price: double.tryParse(_price.text.trim()) ?? 0,
      shortDescription:
          _shortDesc.text.trim().isEmpty ? null : _shortDesc.text.trim(),
      description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
      sku: _sku.text.trim().isEmpty ? null : _sku.text.trim(),
      stockQuantity: int.tryParse(_stock.text) ?? 0,
      discountPrice:
          _discount.text.isEmpty ? null : double.tryParse(_discount.text),
      isFeatured: _isFeatured,
      isNew: _isNew,
      isAvailable: _isAvailable,
      isActive: _isActive,
      removeImageIds: _removeIds.toList(),
      coverImageId: _isEditing ? _coverId : null,
    );
    context.read<ProductFormCubit>().submit(
          request: request,
          existingId: _isEditing ? widget.existing!.id : null,
          newImages: _newImages,
          replacements: _replacements,
        );
  }

  Future<void> _pickNewImages() async {
    final picked = await ImagePicker().pickMultiImage();
    if (!mounted || picked.isEmpty) return;

    bool warnedType = false;
    bool warnedSize = false;
    final valid = <File>[];

    for (final x in picked) {
      final file = File(x.path);
      final ext = file.path.split('.').last.toLowerCase();
      if (!allowedImageExts.contains(ext)) {
        warnedType = true;
        continue;
      }
      final size = await file.length();
      if (size > maxImageBytes) {
        warnedSize = true;
        continue;
      }
      valid.add(file);
    }

    if (!mounted) return;
    if (warnedType) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تجاهل بعض الملفات: نوع الملف غير مدعوم')),
      );
    }
    if (warnedSize) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('تم تجاهل بعض الملفات: الحجم يتجاوز 5 ميجابايت')),
      );
    }
    if (valid.isNotEmpty) setState(() => _newImages.addAll(valid));
  }

  Future<void> _pickReplacementFor(int imageId) async {
    final picked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null || !mounted) return;
    final file = File(picked.path);
    final ext = file.path.split('.').last.toLowerCase();
    if (!allowedImageExts.contains(ext)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'نوع الملف غير مدعوم. يُسمح فقط بـ: jpeg، png، webp، gif')),
      );
      return;
    }
    final size = await file.length();
    if (!mounted) return;
    if (size > maxImageBytes) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حجم الملف يتجاوز 5 ميجابايت')),
      );
      return;
    }
    setState(() => _replacements[imageId] = file);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductFormCubit, ProductFormState>(
      listener: (context, state) {
        switch (state) {
          case ProductFormSuccess():
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text(_isEditing ? 'تم التحديث بنجاح' : 'تم إنشاء المنتج بنجاح'),
            ));
            context.pop();
          case ProductFormError(:final message):
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
          default:
            break;
        }
      },
      builder: (context, state) {
        final isLoading = state is ProductFormLoading;
        return Scaffold(
          appBar: AppBar(
            title: Text(_isEditing ? 'تعديل المنتج' : 'منتج جديد'),
            actions: [
              TextButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('حفظ'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _field(_name, 'اسم المنتج *', required: true),
                  const SizedBox(height: 12),
                  _buildCategoryPicker(context),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _price,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'السعر (س.ل) *'),
                    validator: (v) {
                      final t = v?.trim() ?? '';
                      if (t.isEmpty) return 'هذا الحقل مطلوب';
                      final n = double.tryParse(t);
                      if (n == null) return 'أدخل رقماً صحيحاً';
                      if (n <= 0) return 'السعر يجب أن يكون أكبر من صفر';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _field(_stock, 'الكمية في المخزون',
                      type: TextInputType.number),
                  const SizedBox(height: 12),
                  _field(_discount, 'سعر الخصم (س.ل)  — اختياري',
                      type: TextInputType.number),
                  const SizedBox(height: 12),
                  _field(_sku, 'رمز SKU — اختياري'),
                  const SizedBox(height: 12),
                  _field(_shortDesc, 'وصف مختصر — اختياري'),
                  const SizedBox(height: 12),
                  _field(_desc, 'وصف تفصيلي — اختياري', maxLines: 4),
                  const SizedBox(height: 20),
                  _buildImagesSection(context),
                  const SizedBox(height: 20),
                  Text('الخيارات',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  _switch('مميز', _isFeatured,
                      (v) => setState(() => _isFeatured = v)),
                  _switch(
                      'جديد', _isNew, (v) => setState(() => _isNew = v)),
                  _switch('متاح', _isAvailable,
                      (v) => setState(() => _isAvailable = v)),
                  _switch('نشط', _isActive,
                      (v) => setState(() => _isActive = v)),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryPicker(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoaded) {
          final categories = state.categories;
          final ids = categories.map((c) => c.id).toSet();
          final value = ids.contains(_categoryId) ? _categoryId : null;
          return DropdownButtonFormField<int>(
            initialValue: value,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'الفئة *'),
            hint: const Text('اختر الفئة'),
            items: [
              for (final CategoryListItem c in categories)
                DropdownMenuItem(value: c.id, child: Text(c.name)),
            ],
            onChanged: (v) => setState(() => _categoryId = v),
            validator: (v) => v == null ? 'يرجى اختيار الفئة' : null,
          );
        }
        if (state is CategoriesError) {
          return InputDecorator(
            decoration: const InputDecoration(labelText: 'الفئة *'),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    state.message,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
                TextButton(
                  onPressed: () => context.read<CategoriesCubit>().load(),
                  child: const Text('إعادة'),
                ),
              ],
            ),
          );
        }
        return const InputDecorator(
          decoration: InputDecoration(labelText: 'الفئة *'),
          child: Row(
            children: [
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 12),
              Text('جارٍ تحميل الفئات...'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImagesSection(BuildContext context) {
    final existingImages = widget.existing?.images ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('الصور', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final img in existingImages) _buildExistingTile(context, img),
            for (int i = 0; i < _newImages.length; i++)
              _buildNewImageTile(context, i),
            _buildAddTile(context),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'الأنواع المسموحة: JPG, PNG, WebP, GIF — الحد الأقصى 5 ميجابايت للصورة.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.55),
              ),
        ),
      ],
    );
  }

  Widget _buildExistingTile(BuildContext context, ProductImage img) {
    final isDeleted = _removeIds.contains(img.id);
    final isCover = img.id == _coverId;
    final replacement = _replacements[img.id];

    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: replacement != null
                ? Image.file(replacement, fit: BoxFit.cover)
                : Image.network(img.url, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          child: const Icon(Icons.broken_image_outlined),
                        )),
          ),
          if (isDeleted)
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          if (isCover && !isDeleted)
            Positioned(
              top: 4,
              right: 4,
              child: _coverBadge(context),
            ),
          if (isDeleted)
            Center(
              child: IconButton(
                tooltip: 'تراجع',
                icon: const Icon(Icons.undo_rounded, color: Colors.white),
                onPressed: () => setState(() => _removeIds.remove(img.id)),
              ),
            )
          else
            Positioned(
              bottom: 4,
              left: 4,
              child: _buildImageMenu(context, img),
            ),
        ],
      ),
    );
  }

  Widget _coverBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'الغلاف',
        style: TextStyle(
            color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildImageMenu(BuildContext context, ProductImage img) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      tooltip: 'خيارات الصورة',
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.more_horiz, color: Colors.white, size: 16),
      ),
      onSelected: (value) {
        if (value == 'cover') {
          setState(() => _coverId = img.id);
        } else if (value == 'replace') {
          _pickReplacementFor(img.id);
        } else if (value == 'delete') {
          setState(() {
            _removeIds.add(img.id);
            if (_coverId == img.id) _coverId = null;
          });
        }
      },
      itemBuilder: (menuCtx) => [
        PopupMenuItem(
          value: 'cover',
          child: Row(children: [
            Icon(
              img.id == _coverId
                  ? Icons.star_rounded
                  : Icons.star_outline_rounded,
              size: 18,
              color: Theme.of(menuCtx).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text('تعيين كغلاف'),
          ]),
        ),
        const PopupMenuItem(
          value: 'replace',
          child: Row(children: [
            Icon(Icons.swap_horiz_rounded, size: 18),
            SizedBox(width: 8),
            Text('استبدال الصورة'),
          ]),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(children: [
            Icon(Icons.delete_outline_rounded,
                size: 18, color: Theme.of(menuCtx).colorScheme.error),
            const SizedBox(width: 8),
            Text('حذف',
                style:
                    TextStyle(color: Theme.of(menuCtx).colorScheme.error)),
          ]),
        ),
      ],
    );
  }

  Widget _buildNewImageTile(BuildContext context, int index) {
    final isFirstInCreate = !_isEditing && index == 0;
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(_newImages[index], fit: BoxFit.cover),
          ),
          if (isFirstInCreate)
            Positioned(top: 4, right: 4, child: _coverBadge(context)),
          Positioned(
            top: 4,
            left: 4,
            child: GestureDetector(
              onTap: () => setState(() => _newImages.removeAt(index)),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddTile(BuildContext context) {
    return GestureDetector(
      onTap: _pickNewImages,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
          color:
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_photo_alternate_outlined,
                color: Theme.of(context).colorScheme.primary, size: 28),
            const SizedBox(height: 4),
            Text(
              'إضافة صور',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController ctrl,
    String label, {
    TextInputType type = TextInputType.text,
    bool required = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: type,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label),
      validator: required
          ? (v) => v == null || v.trim().isEmpty ? 'هذا الحقل مطلوب' : null
          : null,
    );
  }

  Widget _switch(String label, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }
}
