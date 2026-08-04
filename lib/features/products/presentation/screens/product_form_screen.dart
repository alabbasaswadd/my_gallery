import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
    _discount = TextEditingController(
        text: p?.discountPrice?.toStringAsFixed(0) ?? '');
    _categoryId = p?.categoryId;
    _isFeatured = p?.isFeatured ?? false;
    _isNew = p?.isNew ?? false;
    _isAvailable = p?.isAvailable ?? true;
    _isActive = p?.isActive ?? true;
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
    if (_categoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار الفئة')),
      );
      return;
    }
    final request = ProductRequest(
      name: _name.text.trim(),
      categoryId: _categoryId!,
      price: double.parse(_price.text),
      shortDescription: _shortDesc.text.trim().isEmpty ? null : _shortDesc.text.trim(),
      description: _desc.text.trim().isEmpty ? null : _desc.text.trim(),
      sku: _sku.text.trim().isEmpty ? null : _sku.text.trim(),
      stockQuantity: int.tryParse(_stock.text) ?? 0,
      discountPrice: _discount.text.isEmpty ? null : double.tryParse(_discount.text),
      isFeatured: _isFeatured,
      isNew: _isNew,
      isAvailable: _isAvailable,
      isActive: _isActive,
    );

    final cubit = context.read<ProductFormCubit>();
    if (_isEditing) {
      cubit.update(widget.existing!.id, request);
    } else {
      cubit.create(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductFormCubit, ProductFormState>(
      listener: (context, state) {
        switch (state) {
          case ProductFormSuccess():
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(_isEditing ? 'تم التحديث بنجاح' : 'تم إنشاء المنتج بنجاح'),
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
                  _field(_price, 'السعر (س.ل) *',
                      type: TextInputType.number, required: true),
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
