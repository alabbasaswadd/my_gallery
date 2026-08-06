import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';
import 'package:my_gallery/features/categories/domain/category_form_cubit.dart';

class CategoryFormScreen extends StatefulWidget {
  /// When non-null the screen is in edit mode and loads the category by id.
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
  int? _parentId; // preserved across edit so an update never re-roots the tree

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
    } on ApiException catch (e) {
      _loadError = e.message;
    } catch (_) {
      _loadError = 'فشل تحميل بيانات الفئة';
    } finally {
      if (mounted) setState(() => _loadingDetail = false);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final request = CategoryRequest(
      name: _name.text.trim(),
      description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
      parentId: _parentId,
      displayOrder: int.tryParse(_order.text) ?? 0,
      isActive: _isActive,
    );
    final cubit = context.read<CategoryFormCubit>();
    if (_isEditing) {
      cubit.update(widget.editId!, request);
    } else {
      cubit.create(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryFormCubit, CategoryFormState>(
      listener: (context, state) {
        switch (state) {
          case CategoryFormSuccess():
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(_isEditing ? 'تم تحديث الفئة' : 'تم إنشاء الفئة'),
            ));
            context.pop();
          case CategoryFormError(:final message):
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
