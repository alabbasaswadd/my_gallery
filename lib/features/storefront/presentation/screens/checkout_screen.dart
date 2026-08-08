import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/features/cart/domain/cart_cubit.dart';
import 'package:my_gallery/features/storefront/domain/checkout_cubit.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _whatsApp = TextEditingController();
  final _name = TextEditingController();
  final _notes = TextEditingController();

  @override
  void dispose() {
    _whatsApp.dispose();
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final cartItems = context.read<CartCubit>().items;
    if (cartItems.isEmpty) {
      AppSnackbar.showInfo(context, 'السلة فارغة');
      return;
    }
    context.read<CheckoutCubit>().placeOrder(
          whatsApp: _whatsApp.text.trim(),
          name: _name.text.trim().isEmpty ? null : _name.text.trim(),
          notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
          items: cartItems,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        switch (state) {
          case CheckoutSuccess(:final result):
            context.read<CartCubit>().clear();
            context.go('/storefront/success', extra: result);
          case CheckoutError(:final message):
            AppSnackbar.showError(context, message);
          default:
            break;
        }
      },
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          final isLoading = state is CheckoutLoading;
          final cartState = context.watch<CartCubit>().state;
          final total = cartState.items
              .fold(0.0, (s, i) => s + i.unitPrice * i.quantity);

          return Scaffold(
            appBar: AppBar(title: const Text('تأكيد الطلب')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ملخص الطلب',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    ...cartState.items.map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                      '${item.name} × ${item.quantity}')),
                              Text(
                                  '${(item.unitPrice * item.quantity).toStringAsFixed(0)} س.ل'),
                            ],
                          ),
                        )),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('الإجمالي',
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          '${total.toStringAsFixed(0)} س.ل',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Text('بيانات التواصل',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _whatsApp,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'رقم واتساب *',
                        hintText: '+963 9xx xxx xxxx',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'رقم الواتساب مطلوب'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: 'الاسم — اختياري',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notes,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'ملاحظات — اختياري',
                        prefixIcon: Icon(Icons.notes_outlined),
                      ),
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('إرسال الطلب'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
