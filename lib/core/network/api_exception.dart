import 'package:dio/dio.dart';

enum ApiErrorKind {
  network,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  validation,

  /// A business rule blocked a well-formed request (backend code `business`, 422).
  /// Distinct from [validation]: the input was fine, a domain rule refused it.
  business,
  conflict,
  rateLimited,
  server,

  /// The backend reached but temporarily unavailable (code `service_unavailable`,
  /// 503 / 502 / maintenance). Drives the reassuring "try again shortly" UI.
  serviceUnavailable,
  unknown,
}

class ApiException implements Exception {
  final ApiErrorKind kind;
  final String message;
  final int? statusCode;
  final String? traceId;
  final List<String> errors;

  const ApiException({
    this.kind = ApiErrorKind.unknown,
    required this.message,
    this.statusCode,
    this.traceId,
    this.errors = const [],
  });

  factory ApiException.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const ApiException(
          kind: ApiErrorKind.timeout,
          message: 'انتهت مهلة الاتصال، يرجى المحاولة مجددًا',
        );
      case DioExceptionType.connectionError:
        return const ApiException(
          kind: ApiErrorKind.network,
          message: 'تعذّر الاتصال بالإنترنت',
        );
      default:
        break;
    }

    final response = e.response;
    if (response == null) {
      return const ApiException(
        kind: ApiErrorKind.network,
        message: 'تعذّر الاتصال بالإنترنت',
      );
    }

    final status = response.statusCode ?? 0;
    final data = response.data;
    // Two failure shapes flow from the API:
    //  1. ApiResponse envelope: { success, code, message, errors: [..], traceId }
    //  2. RFC-7807 problem+json (model-binding / 5xx): { title, code, errors, traceId }
    final serverMessage = data is Map
        ? (data['message'] as String?) ?? (data['title'] as String?)
        : null;
    final traceId = data is Map
        ? (data['traceId'] as String?) ??
            ((data['extensions'] is Map
                ? (data['extensions'] as Map)['traceId']
                : null) as String?)
        : null;
    var rawErrors = <String>[];
    if (data is Map && data['errors'] is List) {
      rawErrors = (data['errors'] as List).whereType<String>().toList();
    } else if (data is Map && data['errors'] is Map) {
      // problem+json: errors is a map of field -> list of messages.
      rawErrors = (data['errors'] as Map)
          .values
          .expand((v) => v is List
              ? v.map((e) => e.toString())
              : <String>[v.toString()])
          .toList();
    }

    // The stable, machine-readable code is authoritative: branch on it, and only
    // fall back to the HTTP status when the server didn't send a code. NEVER parse
    // the (localized) message text to decide the error type.
    final code = data is Map ? data['code'] as String? : null;
    final kind = _kindFromCode(code) ?? _kindFromStatus(status);

    return ApiException(
      kind: kind,
      message: _messageFor(kind, serverMessage, rawErrors),
      statusCode: status,
      traceId: traceId,
      errors: rawErrors,
    );
  }

  /// Maps the backend's stable `code` string to a kind, or null for an unknown/absent code.
  static ApiErrorKind? _kindFromCode(String? code) => switch (code) {
        'validation' => ApiErrorKind.validation,
        'business' => ApiErrorKind.business,
        'not_found' => ApiErrorKind.notFound,
        'conflict' => ApiErrorKind.conflict,
        'unauthorized' => ApiErrorKind.unauthorized,
        'forbidden' => ApiErrorKind.forbidden,
        'rate_limited' => ApiErrorKind.rateLimited,
        'service_unavailable' => ApiErrorKind.serviceUnavailable,
        'server' => ApiErrorKind.server,
        _ => null,
      };

  /// Safety fallback when no `code` is present (older server / proxy error page).
  static ApiErrorKind _kindFromStatus(int status) => switch (status) {
        400 => ApiErrorKind.validation,
        401 => ApiErrorKind.unauthorized,
        403 => ApiErrorKind.forbidden,
        404 => ApiErrorKind.notFound,
        409 => ApiErrorKind.conflict,
        422 => ApiErrorKind.business,
        429 => ApiErrorKind.rateLimited,
        502 || 503 || 504 => ApiErrorKind.serviceUnavailable,
        _ when status >= 500 => ApiErrorKind.server,
        _ => ApiErrorKind.unknown,
      };

  static String _messageFor(
      ApiErrorKind kind, String? serverMessage, List<String> rawErrors) {
    // Validation & business messages come from the server and are safe/useful to show.
    if (serverMessage != null && serverMessage.trim().isNotEmpty) return serverMessage;
    return switch (kind) {
      ApiErrorKind.validation =>
        rawErrors.isNotEmpty ? rawErrors.join('، ') : 'بيانات غير صالحة',
      ApiErrorKind.business => 'تعذّر إتمام العملية',
      ApiErrorKind.unauthorized => 'انتهت الجلسة، يرجى تسجيل الدخول مجدداً',
      ApiErrorKind.forbidden => 'ليس لديك صلاحية للوصول',
      ApiErrorKind.notFound => 'المورد غير موجود',
      ApiErrorKind.conflict => 'تعارض في البيانات',
      ApiErrorKind.rateLimited => 'الرجاء الانتظار قبل المحاولة مجددًا',
      ApiErrorKind.serviceUnavailable => 'الخدمة غير متاحة مؤقتاً، حاول بعد قليل',
      ApiErrorKind.server => 'خطأ في الخادم، يرجى المحاولة لاحقاً',
      ApiErrorKind.timeout => 'انتهت مهلة الاتصال، يرجى المحاولة مجددًا',
      ApiErrorKind.network => 'تعذّر الاتصال بالخادم',
      ApiErrorKind.unknown => 'حدث خطأ غير متوقع',
    };
  }

  @override
  String toString() => 'ApiException($kind, $statusCode): $message'
      '${traceId != null ? " [trace: $traceId]" : ""}';
}

/// Normalizes any caught error into an [ApiException] so every Cubit maps failures
/// the same way — the single Flutter-side stage of the pipeline
/// `Backend code → ApiException → ErrorState/localizer → user-friendly message`.
///
/// Services already throw a mapped [ApiException] (via `exceptionFromDio`), so this
/// mainly guards the rare non-ApiException case with a feature-specific [fallback].
///
/// ```dart
/// } catch (e) {
///   final ex = toApiException(e, fallback: 'فشل تحميل المنتجات');
///   emit(State.error(ex.message, ex.kind));
/// }
/// ```
ApiException toApiException(Object error, {String? fallback}) =>
    error is ApiException
        ? error
        : ApiException(message: fallback ?? 'حدث خطأ غير متوقع');
