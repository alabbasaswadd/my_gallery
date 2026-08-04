import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';
import 'package:my_gallery/features/categories/domain/category_form_cubit.dart';

class CategoryFormScreen extends StatefulWidget {
  final CategoryDetail? existing;

  const CategoryFormScreen({super.key, this.existing});

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _desc;
  late final TextEditingController _order;
  bool _isActive = true;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final c = widget.existing;
    _name = TextEditingController(text: c?.name ?? '');
    _desc = TextEditingController(text: c?.description ?? '');
    _order = TextEditingController(text: c?.displayOrder.toString() ?? '0');
    _isActive = c?.isActive ?? true;
  }

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    _order.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final request = CategoryRequest(
      name: _name.text.trim(),
      description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
      displayOrder: int.tryParse(_order.text) ?? 0,
      isActive: _isActive,
    );
    final cubit = context.read<CategoryFormCubit>();
    if (_isEditing) {
      cubit.update(widget.existing!.id, request);
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
        final isLoading = state is CategoryFormLoading;
        return Scaffold(
          appBar: AppBar(
            title: Text(_isEditing ? 'تعديل الفئة' : 'فئة جديدة'),
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
                    decoration: const InputDecoration(
                        labelText: 'الوصف — اختياري'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _order,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'ترتيب العرض'),
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
          ),
        );
      },
    );
  }
}
