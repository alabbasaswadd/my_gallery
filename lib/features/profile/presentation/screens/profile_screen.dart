import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/core/utils/store_links.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/shared/widgets/qr_export_screen.dart';
import 'package:my_gallery/shared/widgets/theme_toggle_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final user = authState is AuthAuthenticated ? authState.user : null;
    final settings = context.watch<SettingsCubit>().currentOrDefault;
    final website = settings.website;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        actions: const [ThemeToggleButton()],
      ),
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
                if (website.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.public_rounded, color: cs.primary),
                      title: const Text('زيارة الموقع الرسمي'),
                      trailing: const Icon(Icons.open_in_new_rounded),
                      onTap: () => _launchWebsite(context, website),
                    ),
                  ).animate().fadeIn(delay: 320.ms, duration: 250.ms),
                ],
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.qr_code_2_rounded, color: cs.primary),
                    title: const Text('رمز QR للمتجر'),
                    subtitle: const Text('لمشاركة رابط المتجر بسهولة'),
                    trailing: const Icon(Icons.chevron_left),
                    onTap: () => _openStoreQr(context, settings),
                  ),
                ).animate().fadeIn(delay: 330.ms, duration: 250.ms),
                if (user.role == 'Owner' || user.role == 'Manager') ...[
                  const SizedBox(height: 16),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.palette_outlined, color: cs.primary),
                      title: const Text('تخصيص المظهر والهوية'),
                      subtitle: const Text('الشعار، الألوان، الخط، السلايدر'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/settings/appearance'),
                    ),
                  ).animate().fadeIn(delay: 340.ms, duration: 250.ms),
                  const SizedBox(height: 16),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.celebration_outlined,
                        color: cs.primary,
                      ),
                      title: const Text('إدارة المناسبات'),
                      subtitle: const Text('الزفاف، عيد الميلاد، التخرّج…'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/occasions'),
                    ),
                  ).animate().fadeIn(delay: 360.ms, duration: 250.ms),
                  const SizedBox(height: 16),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.share_outlined, color: cs.primary),
                      title: const Text('روابط التواصل الاجتماعي'),
                      subtitle: const Text('إنستغرام، فيسبوك، واتساب'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/settings/social'),
                    ),
                  ).animate().fadeIn(delay: 400.ms, duration: 250.ms),
                ],
                const SizedBox(height: 32),
                OutlinedButton.icon(
                  onPressed: () => _confirmLogout(context),
                  icon: Icon(Icons.logout, color: cs.error),
                  label: Text(
                    'تسجيل الخروج',
                    style: TextStyle(color: cs.error),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: cs.error),
                    minimumSize: const Size.fromHeight(52),
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 300.ms),
              ],
            ),
    );
  }

  Widget _buildAvatar(BuildContext context, String fullName) {
    final cs = Theme.of(context).colorScheme;
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
                backgroundColor: cs.primary,
                child: Text(
                  initials,
                  style: TextStyle(
                    color: cs.onPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms)
              .scale(begin: const Offset(0.8, 0.8)),
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
                leading: Icon(
                  item.$1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  item.$2,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                subtitle: Text(
                  item.$3,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ).animate().fadeIn(delay: (i * 60 + 150).ms, duration: 250.ms),
              if (i < items.length - 1) const Divider(height: 1, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRoleBadge(BuildContext context, String role) {
    final cs = Theme.of(context).colorScheme;
    final (color, label) = switch (role) {
      'Owner' => (cs.primary, 'المالك'),
      'Manager' => (cs.tertiary, 'المدير'),
      'Employee' => (cs.secondary, 'الموظف'),
      _ => (cs.outline, role),
    };

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

  void _openStoreQr(BuildContext context, StorefrontSettings settings) {
    final url = StoreLinks.storeUrl(settings);
    if (url == null) {
      AppSnackbar.showInfo(context, 'أضف رابط الموقع من إعدادات المظهر أولاً');
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => QrExportScreen(
          appBarTitle: 'رمز QR للمتجر',
          url: url,
          storeName: settings.brandName,
          logoUrl: settings.logo,
          fileBaseName: 'store_qr',
        ),
      ),
    );
  }

  Future<void> _launchWebsite(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      AppSnackbar.showError(context, 'تعذّر فتح الموقع');
    }
  }

  void _confirmLogout(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل تريد تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().logout();
            },
            child: Text('خروج', style: TextStyle(color: cs.error)),
          ),
        ],
      ),
    );
  }
}
