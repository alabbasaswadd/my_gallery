import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';
import 'package:my_gallery/features/categories/domain/categories_cubit.dart';
import 'package:my_gallery/shared/widgets/app_shimmer.dart';
import 'package:my_gallery/shared/widgets/empty_state.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';
import 'package:my_gallery/shared/widgets/theme_toggle_button.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().load();
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
        title: const Text('الفئات'),
        actions: [
          const ThemeToggleButton(),
          if (canManage)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.push('/categories/create'),
            ),
        ],
      ),
      body: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesError) {
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
            CategoriesLoading() => _buildShimmer(),
            CategoriesLoaded(:final categories) => categories.isEmpty
                ? EmptyState(
                    message: 'لا توجد فئات',
                    icon: Icons.category_outlined,
                    actionLabel: canManage ? 'إضافة فئة' : null,
                    onAction: canManage
                        ? () => context.push('/categories/create')
                        : null,
                  )
                : RefreshIndicator(
                    onRefresh: () => context.read<CategoriesCubit>().refresh(),
                    child: ReorderableListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      onReorder: canManage
                          ? (oldIndex, newIndex) {
                              final list = List<CategoryListItem>.from(categories);
                              if (newIndex > oldIndex) newIndex--;
                              final item = list.removeAt(oldIndex);
                              list.insert(newIndex, item);
                              context.read<CategoriesCubit>().reorder(list);
                            }
                          : (_, __) {},
                      itemCount: categories.length,
                      itemBuilder: (context, i) {
                        final cat = categories[i];
                        return _CategoryTile(
                          key: ValueKey(cat.id),
                          category: cat,
                          index: i,
                          canManage: canManage,
                          onToggleActive: () => context
                              .read<CategoriesCubit>()
                              .toggleActive(cat.id, cat.isActive),
                          onEdit: () => context.push(
                            '/categories/${cat.id}/edit',
                          ),
                          onDelete: () => _confirmDelete(context, cat),
                        );
                      },
                    ),
                  ),
            CategoriesError(:final message) => ErrorState(
                message: message,
                onRetry: () => context.read<CategoriesCubit>().load(),
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

  void _confirmDelete(BuildContext context, CategoryListItem cat) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('حذف الفئة'),
        content: Text('هل تريد حذف "${cat.name}"؟'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<CategoriesCubit>().delete(cat.id);
            },
            child: Text('حذف', style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final CategoryListItem category;
  final int index;
  final bool canManage;
  final VoidCallback onToggleActive;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CategoryTile({
    super.key,
    required this.category,
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AppNetworkImage(
              imagePath: category.imageUrl,
              width: 52,
              height: 52,
            ),
          ),
          title: Text(category.name, style: theme.textTheme.titleMedium),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (category.parentName != null)
                Text('ضمن: ${category.parentName}',
                    style: theme.textTheme.bodySmall),
              Text('${category.productCount} منتج',
                  style: theme.textTheme.bodySmall),
            ],
          ),
          trailing: canManage
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: Switch.adaptive(
                        value: category.isActive,
                        onChanged: (_) => onToggleActive(),
                        activeColor: theme.colorScheme.primary,
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (v) {
                        if (v == 'edit') onEdit();
                        if (v == 'delete') onDelete();
                      },
                      itemBuilder: (_) => [
                        const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                        const PopupMenuItem(
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
