import 'package:flutter/material.dart';

class ErrorCategoryChip extends StatelessWidget {
  final String category;
  const ErrorCategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = _colorFor(category, cs);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        _labelFor(category),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static String _labelFor(String category) => switch (category) {
        'network' => 'شبكة',
        'timeout' => 'انتهت المهلة',
        'unauthorized' => 'غير مصرّح',
        'forbidden' => 'محظور',
        'notFound' => 'غير موجود',
        'validation' => 'تحقق',
        'conflict' => 'تعارض',
        'rateLimited' => 'حد الطلبات',
        'server' => 'خادم',
        'flutter' => 'Flutter',
        'platform' => 'منصة',
        _ => 'غير معروف',
      };

  static Color _colorFor(String category, ColorScheme cs) => switch (category) {
        'network' || 'timeout' || 'server' || 'flutter' || 'platform' => cs.error,
        'unauthorized' || 'forbidden' || 'conflict' => cs.secondary,
        'notFound' || 'validation' || 'rateLimited' => cs.tertiary,
        _ => cs.outline,
      };
}
