import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_log_entry.freezed.dart';
part 'error_log_entry.g.dart';

/// Category strings used for non-API errors.
/// API errors use [ApiErrorKind.name] directly (e.g. "network", "server").
const String kErrorCategoryFlutter = 'flutter';
const String kErrorCategoryPlatform = 'platform';

@freezed
sealed class ErrorLogEntry with _$ErrorLogEntry {
  const factory ErrorLogEntry({
    required String id,
    required DateTime timestamp,
    /// Error category — for API errors this is [ApiErrorKind.name];
    /// for Flutter/platform errors use [kErrorCategoryFlutter] / [kErrorCategoryPlatform].
    required String category,
    /// User-readable error message.
    required String message,
    /// Raw technical exception text.
    String? technicalMessage,
    /// First [ErrorLogger.stackTraceMaxLines] lines of the stack trace.
    String? stackTrace,
    int? statusCode,
    /// [ApiErrorKind.name] for API errors, null for others.
    String? apiErrorKind,
    String? traceId,
    String? endpoint,
    String? httpMethod,
    String? featureName,
    @Default(true) bool isHandled,
  }) = _ErrorLogEntry;

  factory ErrorLogEntry.fromJson(Map<String, dynamic> json) =>
      _$ErrorLogEntryFromJson(json);
}
