import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final user = authState is AuthAuthenticated ? authState.user : null;

    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildAvatar(context, user.fullName),
                const SizedBox(height: 24),
                _buildInfoCard(
                  context,
                  items: [
                    (Icons.person_outline, 'الاسم', user.fullName),
                    (Icons.email_outlined, 'البريد الإلكتروني', user.email),
                    (Icons.storefront_outlined, 'المتجر', user.shopName),
                    (Icons.badge_outlined, 'الدور', _roleLabel(user.role)),
                  ],
                ),
                const SizedBox(height: 16),
                _buildRoleBadge(context, user.role),
                const SizedBox(height: 32),
                OutlinedButton.icon(
                  onPressed: () => _confirmLogout(context),
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text('تسجيل الخروج',
                      style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    minimumSize: const Size.fromHeight(52),
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 300.ms),
              ],
            ),
    );
  }

  Widget _buildAvatar(BuildContext context, String fullName) {
    final initials = fullName
        .split(' ')
        .take(2)
        .map((n) => n.isNotEmpty ? n[0] : '')
        .join();
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.8, 0.8)),
          const SizedBox(height: 12),
          Text(
            fullName,
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn(delay: 100.ms, duration: 300.ms),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required List<(IconData, String, String)> items,
  }) {
    return Card(
      child: Column(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return Column(
            children: [
              ListTile(
                leading: Icon(item.$1,
                    color: Theme.of(context).colorScheme.primary),
                title: Text(item.$2,
                    style: Theme.of(context).textTheme.bodySmall),
                subtitle: Text(item.$3,
                    style: Theme.of(context).textTheme.titleMedium),
              ).animate().fadeIn(delay: (i * 60 + 150).ms, duration: 250.ms),
              if (i < items.length - 1)
                const Divider(height: 1, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRoleBadge(BuildContext context, String role) {
    final colors = {
      'Owner': (const Color(0xFFC0446A), 'المالك'),
      'Manager': (const Color(0xFFD4A02A), 'المدير'),
      'Employee': (const Color(0xFF3C2A34), 'الموظف'),
    };
    final (color, label) = colors[role] ?? (Colors.grey, role);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ).animate().fadeIn(delay: 300.ms, duration: 300.ms),
    );
  }

  String _roleLabel(String role) => switch (role) {
        'Owner' => 'مالك',
        'Manager' => 'مدير',
        'Employee' => 'موظف',
        _ => role,
      };

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل تريد تسجيل الخروج؟'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().logout();
            },
            child:
                const Text('خروج', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
