import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/utils/store_links.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/shared/services/share_service.dart';
import 'package:my_gallery/shared/widgets/qr_export_screen.dart';

/// Opens the modern "share product" bottom sheet.
Future<void> showProductShareSheet(
  BuildContext context, {
  required int productId,
  required String productName,
}) {
  final settings = context.read<SettingsCubit>().currentOrDefault;
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _ProductShareSheet(
      productId: productId,
      productName: productName,
      settings: settings,
    ),
  );
}

class _ProductShareSheet extends StatelessWidget {
  final int productId;
  final String productName;
  final StorefrontSettings settings;

  const _ProductShareSheet({
    required this.productId,
    required this.productName,
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final url = StoreLinks.productUrl(settings, productId);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.share_rounded, color: cs.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('مشاركة المنتج', style: theme.textTheme.titleLarge),
                      Text(
                        productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (url == null)
              _NoWebsiteNotice()
            else ...[
              _ActionTile(
                icon: Icons.copy_rounded,
                label: 'نسخ الرابط',
                subtitle: StoreLinks.pretty(url),
                onTap: () {
                  Navigator.pop(context);
                  ShareService.copyText(context, url);
                },
              ),
              _ActionTile(
                icon: Icons.ios_share_rounded,
                label: 'مشاركة الرابط',
                onTap: () {
                  Navigator.pop(context);
                  ShareService.shareText(url, subject: productName);
                },
              ),
              _ActionTile(
                icon: Icons.qr_code_2_rounded,
                label: 'رمز QR',
                subtitle: 'إنشاء وحفظ ومشاركة رمز المنتج',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QrExportScreen(
                        appBarTitle: 'رمز QR للمنتج',
                        url: url,
                        storeName: settings.brandName,
                        logoUrl: settings.logo,
                        productName: productName,
                        fileBaseName: 'product_${productId}_qr',
                      ),
                    ),
                  );
                },
              ),
              _ActionTile(
                icon: Icons.open_in_new_rounded,
                label: 'فتح في المتصفح',
                onTap: () {
                  Navigator.pop(context);
                  ShareService.openUrl(context, url);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cs.primaryContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: cs.primary, size: 22),
      ),
      title: Text(label, style: Theme.of(context).textTheme.titleMedium),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Icon(Icons.chevron_left, color: cs.onSurfaceVariant),
      onTap: onTap,
    );
  }
}

class _NoWebsiteNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'لم يتم ضبط رابط الموقع الرسمي بعد',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'لمشاركة المنتجات وإنشاء رموز QR، أضف رابط الموقع من إعدادات المظهر والهوية.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: FilledButton.tonalIcon(
              onPressed: () {
                Navigator.pop(context);
                context.push('/settings/appearance');
              },
              icon: const Icon(Icons.palette_outlined, size: 18),
              label: const Text('فتح إعدادات المظهر'),
            ),
          ),
        ],
      ),
    );
  }
}
