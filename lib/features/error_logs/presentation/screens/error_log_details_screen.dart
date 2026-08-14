import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_gallery/core/logging/error_log_entry.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/features/error_logs/presentation/widgets/error_category_chip.dart';
import 'package:my_gallery/shared/widgets/theme_toggle_button.dart';

class ErrorLogDetailsScreen extends StatelessWidget {
  final ErrorLogEntry entry;
  const ErrorLogDetailsScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الخطأ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_rounded),
            onPressed: () => _copyDetails(context),
            tooltip: 'نسخ التفاصيل',
          ),
          const ThemeToggleButton(),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'المعلومات الأساسية',
            icon: Icons.info_outline_rounded,
            children: [
              _DetailRow(label: 'التاريخ والوقت', value: _formatTime(entry.timestamp)),
              _DetailRow(label: 'التصنيف', value: _categoryLabel(entry.category)),
              _DetailRow(
                label: 'النوع',
                valueWidget: ErrorCategoryChip(category: entry.category),
              ),
              if (entry.featureName != null)
                _DetailRow(label: 'الميزة', value: entry.featureName!),
              _DetailRow(
                label: 'الحالة',
                value: entry.isHandled ? 'معالج' : 'غير معالج',
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (entry.endpoint != null ||
              entry.httpMethod != null ||
              entry.statusCode != null ||
              entry.traceId != null)
            _SectionCard(
              title: 'معلومات الطلب',
              icon: Icons.http_rounded,
              children: [
                if (entry.httpMethod != null)
                  _DetailRow(label: 'الطريقة', value: entry.httpMethod!),
                if (entry.endpoint != null)
                  _DetailRow(label: 'المسار', value: entry.endpoint!),
                if (entry.statusCode != null)
                  _DetailRow(
                    label: 'كود الحالة',
                    value: 'HTTP ${entry.statusCode}',
                  ),
                if (entry.traceId != null)
                  _DetailRow(label: 'Trace ID', value: entry.traceId!),
              ],
            ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'الرسالة',
            icon: Icons.message_outlined,
            children: [
              _CopyableText(text: entry.message),
            ],
          ),
          if (entry.technicalMessage != null &&
              entry.technicalMessage != entry.message) ...[
            const SizedBox(height: 12),
            _SectionCard(
              title: 'التفاصيل التقنية',
              icon: Icons.code_rounded,
              children: [
                _MonospaceText(text: entry.technicalMessage!),
              ],
            ),
          ],
          if (entry.stackTrace != null) ...[
            const SizedBox(height: 12),
            _SectionCard(
              title: 'Stack Trace',
              icon: Icons.layers_outlined,
              children: [
                _MonospaceText(text: entry.stackTrace!),
              ],
            ),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _categoryLabel(String category) => switch (category) {
        'network' => 'خطأ في الشبكة',
        'timeout' => 'انتهاء المهلة',
        'unauthorized' => 'غير مصرّح',
        'forbidden' => 'محظور',
        'notFound' => 'غير موجود',
        'validation' => 'خطأ في التحقق',
        'conflict' => 'تعارض',
        'rateLimited' => 'تجاوز حد الطلبات',
        'server' => 'خطأ في الخادم',
        'flutter' => 'خطأ Flutter',
        'platform' => 'خطأ في المنصة',
        _ => 'غير معروف',
      };

  static String _formatTime(DateTime dt) {
    final d = dt.toLocal();
    String pad(int n) => n.toString().padLeft(2, '0');
    return '${d.day}/${pad(d.month)}/${d.year} ${pad(d.hour)}:${pad(d.minute)}:${pad(d.second)}';
  }

  void _copyDetails(BuildContext context) {
    final buffer = StringBuffer();
    buffer.writeln('## ERROR LOG');
    buffer.writeln();
    buffer.writeln('Date: ${_formatTime(entry.timestamp)}');
    buffer.writeln('Category: ${_categoryLabel(entry.category)}');
    buffer.writeln('Type: ${entry.category}');
    if (entry.featureName != null) buffer.writeln('Feature: ${entry.featureName}');
    buffer.writeln('Handled: ${entry.isHandled}');
    buffer.writeln();
    if (entry.httpMethod != null) buffer.writeln('HTTP Method: ${entry.httpMethod}');
    if (entry.endpoint != null) buffer.writeln('URL: ${entry.endpoint}');
    if (entry.statusCode != null) buffer.writeln('Status Code: ${entry.statusCode}');
    if (entry.traceId != null) buffer.writeln('Trace ID: ${entry.traceId}');
    buffer.writeln();
    buffer.writeln('Message:');
    buffer.writeln(entry.message);
    if (entry.technicalMessage != null &&
        entry.technicalMessage != entry.message) {
      buffer.writeln();
      buffer.writeln('Technical Exception:');
      buffer.writeln(entry.technicalMessage);
    }
    if (entry.stackTrace != null) {
      buffer.writeln();
      buffer.writeln('Stack Trace:');
      buffer.writeln(entry.stackTrace);
    }

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    AppSnackbar.showSuccess(context, 'تم النسخ إلى الحافظة');
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: cs.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: tt.titleSmall?.copyWith(color: cs.primary),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? valueWidget;

  const _DetailRow({required this.label, this.value, this.valueWidget})
      : assert(value != null || valueWidget != null);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: valueWidget ??
                Text(value!, style: tt.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _CopyableText extends StatelessWidget {
  final String text;
  const _CopyableText({required this.text});

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class _MonospaceText extends StatelessWidget {
  final String text;
  const _MonospaceText({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        text,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          height: 1.5,
        ),
      ),
    );
  }
}
