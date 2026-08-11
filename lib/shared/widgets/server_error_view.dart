import 'package:flutter/material.dart';
import 'package:my_gallery/l10n/app_localizations.dart';
import 'package:my_gallery/shared/widgets/status_message_view.dart';

/// Reusable, user-safe "server error" (HTTP 5xx) state with an optional retry.
///
/// Deliberately hides every technical detail (status code, traceId, stack, DB
/// errors). The traceId, when present, stays on the [ApiException] for internal
/// logging only. Localized, RTL-safe, light/dark aware.
class ServerErrorView extends StatelessWidget {
  const ServerErrorView({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    return StatusMessageView(
      icon: Icons.cloud_off_rounded,
      iconColor: cs.error,
      title: l10n?.serverErrorTitle ?? 'حدث خطأ أثناء معالجة الطلب',
      description: l10n?.serverErrorDescription ??
          'الفريق التقني يقوم بمتابعة الخطأ، يرجى المحاولة مرة أخرى لاحقًا.',
      actionLabel: onRetry == null ? null : (l10n?.retry ?? 'إعادة المحاولة'),
      onAction: onRetry,
    );
  }
}
