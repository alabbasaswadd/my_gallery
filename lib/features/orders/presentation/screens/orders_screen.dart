import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/features/orders/data/models/order_models.dart';
import 'package:my_gallery/features/orders/domain/orders_list_cubit.dart';
import 'package:my_gallery/features/orders/presentation/widgets/order_status_pill.dart';
import 'package:my_gallery/shared/widgets/app_shimmer.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';
import 'package:my_gallery/shared/widgets/theme_toggle_button.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _scrollCtrl = ScrollController();

  static const _statuses = [
    ('All', 'الكل'),
    ('New', 'جديد'),
    ('Reviewed', 'مراجعة'),
    ('Confirmed', 'مؤكد'),
    ('Completed', 'مكتمل'),
    ('Cancelled', 'ملغي'),
  ];

  @override
  void initState() {
    super.initState();
    context.read<OrdersListCubit>().load();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels >=
          _scrollCtrl.position.maxScrollExtent - 200) {
        context.read<OrdersListCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلبات'),
        actions: const [ThemeToggleButton()],
      ),
      body: BlocConsumer<OrdersListCubit, OrdersListState>(
        listener: (context, state) {
          if (state is OrdersListError) {
            AppSnackbar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final currentStatus =
              state is OrdersListLoaded ? state.statusFilter : 'All';

          return Column(
            children: [
              _buildStatusChips(context, currentStatus),
              Expanded(
                child: switch (state) {
                  OrdersListLoading() => _buildShimmer(),
                  OrdersListLoaded(:final orders, :final pagination) =>
                    orders.isEmpty
                        ? const EmptyState(
                            message: 'لا توجد طلبات',
                            icon: Icons.receipt_long_outlined,
                          )
                        : RefreshIndicator(
                            onRefresh: () =>
                                context.read<OrdersListCubit>().refresh(),
                            child: ListView.builder(
                              controller: _scrollCtrl,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8),
                              itemCount: orders.length +
                                  (pagination.hasNext ? 1 : 0),
                              itemBuilder: (_, i) {
                                if (i >= orders.length) {
                                  return const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }
                                return _OrderTile(
                                  order: orders[i],
                                  index: i,
                                );
                              },
                            ),
                          ),
                  _ => const SizedBox.shrink(),
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusChips(BuildContext context, String current) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        scrollDirection: Axis.horizontal,
        itemCount: _statuses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final (value, label) = _statuses[i];
          return FilterChip(
            label: Text(label),
            selected: current == value,
            onSelected: (_) =>
                context.read<OrdersListCubit>().filterByStatus(value),
          );
        },
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 6,
      itemBuilder: (_, __) => const ListTileShimmer(),
    );
  }
}

class _OrderTile extends StatelessWidget {
  final OrderListItem order;
  final int index;

  const _OrderTile({required this.order, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          onTap: () => context.push('/orders/${order.id}'),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.orderNumber, style: theme.textTheme.titleMedium),
              OrderStatusPill(status: order.status),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              if (order.customerName != null)
                Text(order.customerName!, style: theme.textTheme.bodySmall),
              Text(
                '${order.totalAmount.toStringAsFixed(0)} س.ل · ${order.itemsCount} منتج',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          trailing: const Icon(Icons.chevron_left),
        ),
      )
          .animate()
          .fadeIn(delay: (index * 30).ms, duration: 250.ms)
          .slideX(begin: 0.05, end: 0),
    );
  }
}

