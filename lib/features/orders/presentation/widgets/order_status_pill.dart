import 'package:flutter/material.dart';
import 'package:my_gallery/core/constants/colors.dart';

class OrderStatusPill extends StatelessWidget {
  final String status;
  const OrderStatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = _resolve(context, status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: color, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  static (Color, String) _resolve(BuildContext context, String status) {
    final cs = Theme.of(context).colorScheme;
    return switch (status) {
      'New' => (AppColors.statusNew, 'جديد'),
      'Reviewed' => (AppColors.statusReviewed, 'مراجعة'),
      'Confirmed' => (AppColors.statusConfirmed, 'مؤكد'),
      'Completed' => (AppColors.statusCompleted, 'مكتمل'),
      'Cancelled' => (cs.error, 'ملغي'),
      _ => (cs.onSurfaceVariant, status),
    };
  }
}
