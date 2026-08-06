import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/core/constants/colors.dart';
import 'package:my_gallery/features/orders/data/models/order_models.dart';
import 'package:my_gallery/features/orders/domain/order_detail_cubit.dart';
import 'package:my_gallery/features/orders/domain/orders_list_cubit.dart';
import 'package:my_gallery/features/orders/presentation/widgets/order_status_pill.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderDetailCubit>().load(widget.orderId);
  }

  static const _statuses = [
    'New',
    'Reviewed',
    'Confirmed',
    'Completed',
    'Cancelled',
  ];

  static const _statusLabels = {
    'New': 'جديد',
    'Reviewed': 'مراجعة',
    'Confirmed': 'مؤكد',
    'Completed': 'مكتمل',
    'Cancelled': 'ملغي',
  };

  void _openWhatsApp(String number) async {
    final cleaned = number.replaceAll(RegExp(r'[\s+]'), '');
    final url = Uri.parse('https://wa.me/$cleaned');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderDetailCubit, OrderDetailState>(
      listener: (context, state) {
        if (state is OrderDetailError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        if (state is OrderDetailLoaded) {
          // Sync status back to the orders list if it exists in context
          try {
            context
                .read<OrdersListCubit>()
                .updateOrderStatus(state.order.id, state.order.status);
          } catch (_) {}
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('تفاصيل الطلب')),
          body: switch (state) {
            OrderDetailLoading() =>
              const Center(child: CircularProgressIndicator()),
            OrderDetailLoaded(:final order) => _buildContent(context, order),
            OrderDetailError(:final message) => ErrorState(
                message: message,
                onRetry: () =>
                    context.read<OrderDetailCubit>().load(widget.orderId),
              ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, OrderDetail order) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order number + status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.orderNumber,
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
              OrderStatusPill(status: order.status),
            ],
          ),
          const SizedBox(height: 20),

          // Customer info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('بيانات العميل', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  if (order.customerName != null)
                    _InfoRow(
                        icon: Icons.person_outline,
                        label: order.customerName!),
                  if (order.customerWhatsApp != null)
                    Row(
                      children: [
                        Expanded(
                          child: _InfoRow(
                              icon: Icons.phone_outlined,
                              label: order.customerWhatsApp!),
                        ),
                        TextButton.icon(
                          onPressed: () =>
                              _openWhatsApp(order.customerWhatsApp!),
                          icon: const Icon(Icons.chat,
                              color: AppColors.whatsApp),
                          label: const Text('واتساب',
                              style: TextStyle(color: AppColors.whatsApp)),
                        ),
                      ],
                    ),
                  if (order.notes != null && order.notes!.isNotEmpty)
                    _InfoRow(icon: Icons.notes, label: order.notes!),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Items
          Text('المنتجات', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          ...order.items.map((item) => Card(
                child: ListTile(
                  title: Text(item.productName),
                  subtitle: Text(
                    '${item.unitPrice.toStringAsFixed(0)} س.ل × ${item.quantity}',
                  ),
                  trailing: Text(
                    '${item.lineTotal.toStringAsFixed(0)} س.ل',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الإجمالي', style: theme.textTheme.titleLarge),
              Text(
                '${order.totalAmount.toStringAsFixed(0)} س.ل',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Status change
          Text('تغيير الحالة', style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: _statuses.map((s) {
              return ChoiceChip(
                label: Text(_statusLabels[s] ?? s),
                selected: order.status == s,
                onSelected: order.status == s
                    ? null
                    : (_) =>
                        context.read<OrderDetailCubit>().updateStatus(s),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}
