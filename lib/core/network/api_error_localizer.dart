import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/l10n/app_localizations.dart';

/// Maps an [ApiException] to a safe, localized, user-facing message.
///
/// This is the single place that turns an error *kind* into words shown to the
/// user. It never exposes status codes, traceIds, stack traces, or any server
/// technical detail — those remain available on [ApiException] for internal
/// logging only.
extension ApiErrorLocalization on ApiException {
  String localizedMessage(AppLocalizations l10n) {
    switch (kind) {
      case ApiErrorKind.network:
        return l10n.error_network;
      case ApiErrorKind.timeout:
        return l10n.requestTimeoutMessage;
      case ApiErrorKind.unauthorized:
        return l10n.error_unauthorized;
      case ApiErrorKind.forbidden:
        return l10n.error_forbidden;
      case ApiErrorKind.notFound:
        return l10n.error_not_found;
      case ApiErrorKind.validation:
        // Validation text is produced by the server field validators and is
        // safe/useful to show; fall back to a generic label if empty.
        return message.trim().isNotEmpty ? message : l10n.error_validation;
      case ApiErrorKind.business:
        // A business-rule refusal — the server's message explains exactly what
        // and is safe to show; fall back to a neutral label.
        return message.trim().isNotEmpty ? message : 'تعذّر إتمام العملية';
      case ApiErrorKind.conflict:
        return l10n.error_conflict;
      case ApiErrorKind.rateLimited:
        return l10n.error_rate_limited;
      case ApiErrorKind.serviceUnavailable:
        return 'الخدمة غير متاحة مؤقتاً، يرجى المحاولة بعد قليل';
      case ApiErrorKind.server:
        return l10n.serverErrorTitle;
      case ApiErrorKind.unknown:
        return l10n.error_unknown;
    }
  }
}
