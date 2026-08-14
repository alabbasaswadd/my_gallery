import 'package:flutter/material.dart';
import 'package:my_gallery/l10n/app_localizations.dart';
import 'package:my_gallery/shared/widgets/status_message_view.dart';

/// Reassuring "the service is temporarily unavailable" state, shown when the app
/// reaches the server but it can't answer right now (5xx / 502 / 503) — or when a
/// silent token refresh couldn't complete because the backend was unreachable.
///
/// It never exposes a status code or any technical detail: the user only sees a
/// calm message and a retry button. Localized, RTL-safe and theme-aware; the
/// literal strings are the Arabic-first source of truth (the app is Arabic).
class ServiceUnavailableView extends StatelessWidget {
  const ServiceUnavailableView({super.key, this.onRetry, this.isRetrying = false});

  final VoidCallback? onRetry;

  /// When true the action shows a spinner and is disabled — used while a retry
  /// request is in flight so the user gets immediate feedback.
  final bool isRetrying;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return StatusMessageView(
      icon: Icons.cloud_off_rounded,
      title: 'الخدمة غير متاحة مؤقتاً',
      description: 'لا داعي للقلق، يبدو أن هناك مشكلة مؤقتة في الاتصال. '
          'سنحاول إعادة الاتصال، ويمكنك المحاولة مرة أخرى بعد قليل.',
      actionLabel: onRetry == null ? null : (l10n?.retry ?? 'إعادة المحاولة'),
      onAction: onRetry,
      isBusy: isRetrying,
      pulse: true,
    );
  }
}
