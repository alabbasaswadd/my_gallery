import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/features/error_logs/domain/error_logs_cubit.dart';
import 'package:my_gallery/features/error_logs/presentation/widgets/error_log_tile.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';
import 'package:my_gallery/shared/widgets/theme_toggle_button.dart';

class ErrorLogsScreen extends StatefulWidget {
  const ErrorLogsScreen({super.key});

  @override
  State<ErrorLogsScreen> createState() => _ErrorLogsScreenState();
}

class _ErrorLogsScreenState extends State<ErrorLogsScreen> {
  final _searchController = TextEditingController();
  bool _showSearch = false;

  @override
  void initState() {
    super.initState();
    context.read<ErrorLogsCubit>().load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: _showSearch
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'بحث في السجلات...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: cs.onSurface.withValues(alpha: 0.5)),
                ),
                onChanged: (q) => context.read<ErrorLogsCubit>().search(q),
              )
            : const Text('سجل الأخطاء'),
        actions: [
          if (!_showSearch)
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () => setState(() => _showSearch = true),
              tooltip: 'بحث',
            ),
          if (_showSearch)
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () {
                setState(() => _showSearch = false);
                _searchController.clear();
                context.read<ErrorLogsCubit>().search('');
              },
            ),
          BlocBuilder<ErrorLogsCubit, ErrorLogsState>(
            builder: (context, state) {
              if (state is! ErrorLogsLoaded || state.logs.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.delete_sweep_rounded),
                onPressed: () => _confirmClearAll(context),
                tooltip: 'مسح الكل',
              );
            },
          ),
          const ThemeToggleButton(),
        ],
      ),
      body: BlocBuilder<ErrorLogsCubit, ErrorLogsState>(
        builder: (context, state) {
          return switch (state) {
            ErrorLogsInitial() || ErrorLogsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ErrorLogsError(:final message) => Center(
                child: Text(message),
              ),
            ErrorLogsLoaded(
              :final filtered,
              :final logs,
              :final filterCategory,
            ) =>
              Column(
                children: [
                  _buildHeader(context, logs.length, filterCategory),
                  Expanded(
                    child: filtered.isEmpty
                        ? const EmptyState(
                            message: 'لا توجد أخطاء مسجّلة',
                            icon: Icons.check_circle_outline_rounded,
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 16),
                            itemCount: filtered.length,
                            itemBuilder: (context, i) {
                              final entry = filtered[i];
                              return ErrorLogTile(
                                entry: entry,
                                onTap: () => context.push(
                                  '/error-logs/${entry.id}',
                                  extra: entry,
                                ),
                                onDelete: () => _deleteLog(context, entry.id),
                              );
                            },
                          ),
                  ),
                ],
              ),
          };
        },
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    int total,
    String filterCategory,
  ) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final categories = [
      ('', 'الكل'),
      ('server', 'خادم'),
      ('network', 'شبكة'),
      ('timeout', 'مهلة'),
      ('unauthorized', 'مصادقة'),
      ('validation', 'تحقق'),
      ('flutter', 'Flutter'),
      ('platform', 'منصة'),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: total > 0
                      ? cs.errorContainer
                      : cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$total خطأ',
                  style: tt.labelMedium?.copyWith(
                    color: total > 0 ? cs.onErrorContainer : cs.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final (value, label) = categories[i];
              final selected = filterCategory == value;
              return FilterChip(
                label: Text(label),
                selected: selected,
                onSelected: (_) =>
                    context.read<ErrorLogsCubit>().filterByCategory(value),
                showCheckmark: false,
                visualDensity: VisualDensity.compact,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _deleteLog(BuildContext context, String id) {
    context.read<ErrorLogsCubit>().deleteLog(id);
    AppSnackbar.showSuccess(context, 'تم حذف السجل');
  }

  void _confirmClearAll(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('مسح جميع السجلات'),
        content: const Text('هل تريد حذف جميع الأخطاء المسجّلة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ErrorLogsCubit>().clearAll();
              AppSnackbar.showSuccess(context, 'تم مسح جميع السجلات');
            },
            child: Text('مسح الكل', style: TextStyle(color: cs.error)),
          ),
        ],
      ),
    );
  }
}
