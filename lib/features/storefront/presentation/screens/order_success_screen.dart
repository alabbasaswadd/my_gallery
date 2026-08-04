import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/features/storefront/data/models/storefront_models.dart';

class OrderSuccessScreen extends StatelessWidget {
  final PlaceOrderResult result;
  const OrderSuccessScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle_rounded,
                      color: Colors.green, size: 64),
                )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .scale(
                        begin: const Offset(0.5, 0.5),
                        curve: Curves.elasticOut),
                const SizedBox(height: 28),
                Text(
                  'تم استلام طلبك!',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                const SizedBox(height: 12),
                Text(
                  'رقم الطلب',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 300.ms),
                const SizedBox(height: 6),
                Text(
                  result.orderNumber,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ).animate().fadeIn(delay: 450.ms, duration: 300.ms),
                const SizedBox(height: 8),
                Text(
                  'المجموع: ${result.totalAmount.toStringAsFixed(0)} س.ل',
                  style: theme.textTheme.titleMedium,
                ).animate().fadeIn(delay: 500.ms, duration: 300.ms),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => context.go('/storefront'),
                  child: const Text('العودة للتسوق'),
                ).animate().fadeIn(delay: 600.ms, duration: 300.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
