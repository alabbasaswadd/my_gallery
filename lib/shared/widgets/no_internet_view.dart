import 'package:flutter/material.dart';
import 'package:my_gallery/l10n/app_localizations.dart';
import 'package:my_gallery/shared/widgets/status_message_view.dart';

/// Reusable, elegant "no internet connection" state with an optional retry.
///
/// Drop it into any screen body when a request fails with a connectivity error.
/// Localized, RTL-safe, responsive, and light/dark aware. Shows no technical
/// detail. The literal fallbacks are only used if localization is unavailable
/// (e.g. a bare widget test) — the app always renders the localized strings.
class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return StatusMessageView(
      icon: Icons.wifi_off_rounded,
      title: l10n?.noInternet ?? 'لا يوجد اتصال بالإنترنت',
      description: l10n?.noInternetDescription ??
          'تحقق من اتصال هاتفك بالإنترنت ثم حاول مرة أخرى.',
      actionLabel: onRetry == null ? null : (l10n?.retry ?? 'إعادة المحاولة'),
      onAction: onRetry,
      pulse: true,
    );
  }
}
