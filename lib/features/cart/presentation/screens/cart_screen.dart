import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/features/cart/domain/cart_cubit.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سلة الشراء')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final items = state.items;
          if (items.isEmpty) {
            return const EmptyState(
              message: 'سلتك فارغة',
              icon: Icons.shopping_cart_outlined,
            );
          }
          final total =
              items.fold(0.0, (s, i) => s + i.unitPrice * i.quantity);
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final item = items[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AppNetworkImage(
                                imagePath: item.imageUrl,
                                width: 60,
                                height: 60,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.unitPrice.toStringAsFixed(0)} س.ل',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => context
                                      .read<CartCubit>()
                                      .setQuantity(
                                          item.productId, item.quantity - 1),
                                  icon: const Icon(Icons.remove_circle_outline),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text('${item.quantity}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                IconButton(
                                  onPressed: () => context
                                      .read<CartCubit>()
                                      .setQuantity(
                                          item.productId, item.quantity + 1),
                                  icon: const Icon(Icons.add_circle_outline),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, -4)),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('المجموع',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
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
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context.push('/storefront/checkout'),
                        child: const Text('تأكيد الطلب'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
