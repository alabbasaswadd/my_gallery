import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/occasions/data/models/occasion_models.dart';
import 'package:my_gallery/features/occasions/domain/occasions_cubit.dart';
import 'package:my_gallery/shared/widgets/app_shimmer.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';
import 'package:my_gallery/shared/widgets/theme_toggle_button.dart';

class OccasionsScreen extends StatefulWidget {
  const OccasionsScreen({super.key});

  @override
  State<OccasionsScreen> createState() => _OccasionsScreenState();
}

class _OccasionsScreenState extends State<OccasionsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OccasionsCubit>().load();
  }

  Future<void> _openCreate() async {
    await context.push('/occasions/create');
    if (mounted) context.read<OccasionsCubit>().refresh();
  }

  Future<void> _openEdit(int id) async {
    await context.push('/occasions/$id/edit');
    if (mounted) context.read<OccasionsCubit>().refresh();
  }

  bool _canManage(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      final role = authState.user.role;
      return role == 'Owner' || role == 'Manager';
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final canManage = _canManage(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('المناسبات'),
        actions: [
          const ThemeToggleButton(),
          if (canManage)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _openCreate,
            ),
        ],
      ),
      body: BlocConsumer<OccasionsCubit, OccasionsState>(
        listener: (context, state) {
          if (state is OccasionsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return switch (state) {
            OccasionsLoading() => _buildShimmer(),
            OccasionsLoaded(:final occasions) => occasions.isEmpty
                ? EmptyState(
                    message: 'لا توجد مناسبات',
                    icon: Icons.celebration_outlined,
                    actionLabel: canManage ? 'إضافة مناسبة' : null,
                    onAction: canManage ? _openCreate : null,
                  )
                : RefreshIndicator(
                    onRefresh: () => context.read<OccasionsCubit>().refresh(),
                    child: ReorderableListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      onReorder: canManage
                          ? (oldIndex, newIndex) {
                              final list =
                                  List<OccasionListItem>.from(occasions);
                              if (newIndex > oldIndex) newIndex--;
                              final item = list.removeAt(oldIndex);
                              list.insert(newIndex, item);
                              context.read<OccasionsCubit>().reorder(list);
                            }
                          : (_, __) {},
                      itemCount: occasions.length,
                      itemBuilder: (context, i) {
                        final occasion = occasions[i];
                        return _OccasionTile(
                          key: ValueKey(occasion.id),
                          occasion: occasion,
                          index: i,
                          canManage: canManage,
                          onToggleActive: () => context
                              .read<OccasionsCubit>()
                              .toggleActive(occasion.id, occasion.isActive),
                          onEdit: () => _openEdit(occasion.id),
                          onDelete: () => _confirmDelete(context, occasion),
                        );
                      },
                    ),
                  ),
            OccasionsError(:final message) => ErrorState(
                message: message,
                onRetry: () => context.read<OccasionsCubit>().load(),
              ),
            _ => const SizedBox.shrink(),
          };
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

  void _confirmDelete(BuildContext context, OccasionListItem occasion) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('حذف المناسبة'),
        content: Text('هل تريد حذف "${occasion.name}"؟'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<OccasionsCubit>().delete(occasion.id);
            },
            child: Text('حذف',
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        ],
      ),
    );
  }
}

class _OccasionTile extends StatelessWidget {
  final OccasionListItem occasion;
  final int index;
  final bool canManage;
  final VoidCallback onToggleActive;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _OccasionTile({
    super.key,
    required this.occasion,
    required this.index,
    required this.canManage,
    required this.onToggleActive,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AppNetworkImage(
              imagePath: occasion.imageUrl,
              width: 52,
              height: 52,
            ),
          ),
          title: Text(occasion.name, style: theme.textTheme.titleMedium),
          subtitle: Text('${occasion.productCount} منتج',
              style: theme.textTheme.bodySmall),
          trailing: canManage
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Switch.adaptive(
                      value: occasion.isActive,
                      onChanged: (_) => onToggleActive(),
                      activeColor: theme.colorScheme.primary,
                    ),
                    PopupMenuButton<String>(
                      onSelected: (v) {
                        if (v == 'edit') onEdit();
                        if (v == 'delete') onDelete();
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'edit', child: Text('تعديل')),
                        PopupMenuItem(
                            value: 'delete',
                            child: Text('حذف',
                                style: TextStyle(color: Colors.red))),
                      ],
                    ),
                  ],
                )
              : null,
        ),
      ).animate().fadeIn(delay: (index * 40).ms, duration: 250.ms),
    );
  }
}
