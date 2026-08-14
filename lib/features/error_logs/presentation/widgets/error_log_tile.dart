import 'package:flutter/material.dart';
import 'package:my_gallery/core/logging/error_log_entry.dart';
import 'package:my_gallery/features/error_logs/presentation/widgets/error_category_chip.dart';

class ErrorLogTile extends StatelessWidget {
  final ErrorLogEntry entry;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ErrorLogTile({
    super.key,
    required this.entry,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CategoryIcon(category: entry.category),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ErrorCategoryChip(category: entry.category),
                        ),
                        if (entry.statusCode != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              'HTTP ${entry.statusCode}',
                              style: tt.labelSmall?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      entry.message,
                      style: tt.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: cs.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatTime(entry.timestamp),
                          style: tt.labelSmall?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        if (entry.endpoint != null) ...[
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${entry.httpMethod ?? ''} ${entry.endpoint!}'
                                  .trim(),
                              style: tt.labelSmall?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline_rounded,
                    size: 18, color: cs.error),
                onPressed: onDelete,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                visualDensity: VisualDensity.compact,
                tooltip: 'حذف',
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatTime(DateTime dt) {
    final d = dt.toLocal();
    String pad(int n) => n.toString().padLeft(2, '0');
    return '${d.day}/${pad(d.month)}/${d.year} ${pad(d.hour)}:${pad(d.minute)}';
  }
}

class _CategoryIcon extends StatelessWidget {
  final String category;
  const _CategoryIcon({required this.category});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (icon, color) = _iconFor(category, cs);
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }

  static (IconData, Color) _iconFor(String category, ColorScheme cs) =>
      switch (category) {
        'network' => (Icons.wifi_off_rounded, cs.error),
        'timeout' => (Icons.timer_off_rounded, cs.error),
        'unauthorized' => (Icons.lock_outline_rounded, cs.secondary),
        'forbidden' => (Icons.block_rounded, cs.secondary),
        'notFound' => (Icons.search_off_rounded, cs.tertiary),
        'validation' => (Icons.rule_rounded, cs.tertiary),
        'conflict' => (Icons.sync_problem_rounded, cs.secondary),
        'rateLimited' => (Icons.hourglass_empty_rounded, cs.tertiary),
        'server' => (Icons.dns_rounded, cs.error),
        'flutter' => (Icons.bug_report_rounded, cs.error),
        'platform' => (Icons.phone_android_rounded, cs.error),
        _ => (Icons.error_outline_rounded, cs.outline),
      };
}
