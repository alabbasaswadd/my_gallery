import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';
import 'package:my_gallery/features/categories/domain/category_form_cubit.dart';
import 'package:my_gallery/features/products/data/image_rules.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';

class CategoryFormScreen extends StatefulWidget {
  final int? editId;

  const CategoryFormScreen({super.key, this.editId});

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _order = TextEditingController(text: '0');
  bool _isActive = true;
  int? _parentId;
  File? _imageFile;

  String? _existingImageUrl;
  bool _removeExistingImage = false;

  bool _loadingDetail = false;
  String? _loadError;

  bool get _isEditing => widget.editId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) _loadDetail();
  }

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    _order.dispose();
    super.dispose();
  }

  Future<void> _loadDetail() async {
    setState(() {
      _loadingDetail = true;
      _loadError = null;
    });
    try {
      final c = await context.read<CategoryFormCubit>().loadDetail(widget.editId!);
      if (!mounted) return;
      _name.text = c.name;
      _desc.text = c.description ?? '';
      _order.text = c.displayOrder.toString();
      _isActive = c.isActive;
      _parentId = c.parentId;
      _existingImageUrl = c.imageUrl;
    } on ApiException catch (e) {
      _loadError = e.message;
    } catch (_) {
      _loadError = 'فشل تحميل بيانات الفئة';
    } finally {
      if (mounted) setState(() => _loadingDetail = false);
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null || !mounted) return;

    final file = File(picked.path);
    final ext = file.path.split('.').last.toLowerCase();
    if (!allowedImageExts.contains(ext)) {
      if (mounted) {
        AppSnackbar.showWarning(
          context,
          'نوع الملف غير مدعوم. يُسمح فقط بـ: jpeg، png، webp، gif',
        );
      }
      return;
    }
    final size = await file.length();
    if (!mounted) return;
    if (size > maxImageBytes) {
      AppSnackbar.showWarning(context, 'حجم الملف يتجاوز 5 ميجابايت');
      return;
    }
    setState(() {
      _imageFile = file;
      _removeExistingImage = false;
    });
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
      _removeExistingImage = true;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final request = CategoryRequest(
      name: _name.text.trim(),
      description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
      parentId: _parentId,
      displayOrder: int.tryParse(_order.text) ?? 0,
      isActive: _isActive,
      removeImage: _isEditing && _removeExistingImage && _imageFile == null,
    );
    final cubit = context.read<CategoryFormCubit>();
    if (_isEditing) {
      cubit.update(widget.editId!, request, image: _imageFile);
    } else {
      cubit.create(request, image: _imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryFormCubit, CategoryFormState>(
      listener: (context, state) {
        switch (state) {
          case CategoryFormSuccess():
            AppSnackbar.showSuccess(
              context,
              _isEditing ? 'تم تحديث الفئة' : 'تم إنشاء الفئة',
            );
            context.pop();
          case CategoryFormSuccessWithImageWarning():
            AppSnackbar.showError(
              context,
              _isEditing
                  ? 'تم تحديث الفئة، لكن فشل رفع الصورة. يمكنك المحاولة لاحقاً.'
                  : 'تم إنشاء الفئة، لكن فشل رفع الصورة. يمكنك المحاولة لاحقاً.',
            );
            context.pop();
          case CategoryFormError(:final message):
            AppSnackbar.showError(context, message);
          default:
            break;
        }
      },
      builder: (context, state) {
        final isSaving = state is CategoryFormLoading;
        return Scaffold(
          appBar: AppBar(
            title: Text(_isEditing ? 'تعديل الفئة' : 'فئة جديدة'),
            actions: [
              if (!_loadingDetail && _loadError == null)
                TextButton(
                  onPressed: isSaving ? null : _submit,
                  child: isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('حفظ'),
                ),
            ],
          ),
          body: _buildBody(context),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loadingDetail) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_loadError != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded,
                size: 56,
                color: Theme.of(context).colorScheme.error.withValues(alpha: 0.6)),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(_loadError!, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _loadDetail,
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'اسم الفئة *'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'الاسم مطلوب' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _desc,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'الوصف — اختياري'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _order,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'ترتيب العرض'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                return int.tryParse(v.trim()) == null ? 'أدخل رقماً صحيحاً' : null;
              },
            ),
            const SizedBox(height: 8),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: const Text('نشطة'),
              value: _isActive,
              onChanged: (v) => setState(() => _isActive = v),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            _buildImagePicker(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final bool hasNewFile = _imageFile != null;
    final bool hasExisting =
        !hasNewFile && !_removeExistingImage && (_existingImageUrl?.isNotEmpty ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('صورة الفئة', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        if (hasNewFile) ...[
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _imageFile!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: GestureDetector(
                  onTap: () => setState(() => _imageFile = null),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.swap_horiz_rounded),
            label: const Text('تغيير الصورة'),
          ),
        ] else if (hasExisting) ...[
          Stack(
            children: [
              AppNetworkImage(
                imagePath: _existingImageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(12),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: GestureDetector(
                  onTap: _removeImage,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.swap_horiz_rounded),
            label: const Text('تغيير الصورة'),
          ),
        ] else
          InkWell(
            onTap: _pickImage,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: cs.outlineVariant,
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 36,
                    color: cs.primary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'اضغط لاختيار صورة',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 6),
        Text(
          'اختياري — JPG، PNG، WebP، GIF — الحد الأقصى 5 ميجابايت',
          style: theme.textTheme.bodySmall?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
