import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/occasions/data/models/occasion_models.dart';
import 'package:my_gallery/features/occasions/domain/occasion_form_cubit.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';

class OccasionFormScreen extends StatefulWidget {
  /// When non-null the screen is in edit mode and loads the occasion by id.
  final int? editId;

  const OccasionFormScreen({super.key, this.editId});

  @override
  State<OccasionFormScreen> createState() => _OccasionFormScreenState();
}

class _OccasionFormScreenState extends State<OccasionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _slug = TextEditingController();
  final _desc = TextEditingController();
  final _icon = TextEditingController();
  final _order = TextEditingController(text: '0');
  bool _isActive = true;

  File? _pickedImage;
  String? _existingImageUrl;

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
    _slug.dispose();
    _desc.dispose();
    _icon.dispose();
    _order.dispose();
    super.dispose();
  }

  Future<void> _loadDetail() async {
    setState(() {
      _loadingDetail = true;
      _loadError = null;
    });
    try {
      final o = await context.read<OccasionFormCubit>().loadDetail(widget.editId!);
      if (!mounted) return;
      _name.text = o.name;
      _slug.text = o.slug ?? '';
      _desc.text = o.description ?? '';
      _icon.text = o.icon ?? '';
      _order.text = o.displayOrder.toString();
      _isActive = o.isActive;
      _existingImageUrl = o.imageUrl;
    } on ApiException catch (e) {
      _loadError = e.message;
    } catch (_) {
      _loadError = 'فشل تحميل بيانات المناسبة';
    } finally {
      if (mounted) setState(() => _loadingDetail = false);
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 90);
    if (picked == null || !mounted) return;
    setState(() => _pickedImage = File(picked.path));
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final request = OccasionRequest(
      name: _name.text.trim(),
      slug: _slug.text.trim().isEmpty ? null : _slug.text.trim(),
      description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
      icon: _icon.text.trim().isEmpty ? null : _icon.text.trim(),
      displayOrder: int.tryParse(_order.text) ?? 0,
      isActive: _isActive,
    );
    final cubit = context.read<OccasionFormCubit>();
    if (_isEditing) {
      cubit.update(widget.editId!, request, image: _pickedImage);
    } else {
      cubit.create(request, image: _pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OccasionFormCubit, OccasionFormState>(
      listener: (context, state) {
        switch (state) {
          case OccasionFormSuccess():
            AppSnackbar.showSuccess(
              context,
              _isEditing ? 'تم تحديث المناسبة' : 'تم إنشاء المناسبة',
            );
            context.pop();
          case OccasionFormError(:final message):
            AppSnackbar.showError(context, message);
          default:
            break;
        }
      },
      builder: (context, state) {
        final isSaving = state is OccasionFormLoading;
        return Scaffold(
          appBar: AppBar(
            title: Text(_isEditing ? 'تعديل المناسبة' : 'مناسبة جديدة'),
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
                color:
                    Theme.of(context).colorScheme.error.withValues(alpha: 0.6)),
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
            _buildImagePicker(context),
            const SizedBox(height: 16),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'اسم المناسبة *'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'الاسم مطلوب' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _slug,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(
                labelText: 'المُعرّف (slug) — اختياري',
                hintText: 'wedding',
                helperText: 'يُولّد تلقائياً من الاسم إذا تُرك فارغاً',
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _desc,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'الوصف — اختياري'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _icon,
              decoration: const InputDecoration(labelText: 'الأيقونة — اختياري'),
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Widget preview;
    if (_pickedImage != null) {
      preview = Image.file(_pickedImage!, fit: BoxFit.cover);
    } else if (_existingImageUrl != null && _existingImageUrl!.isNotEmpty) {
      preview = AppNetworkImage(
          imagePath: _existingImageUrl, width: double.infinity, height: 160);
    } else {
      preview = Icon(Icons.add_photo_alternate_outlined,
          size: 40, color: cs.onSurfaceVariant);
    }

    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 160,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Center(child: preview),
      ),
    );
  }
}
