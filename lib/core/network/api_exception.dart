import 'package:dio/dio.dart';

enum ApiErrorKind {
  network,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  validation,
  conflict,
  rateLimited,
  server,
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
    final serverMessage = data is Map ? data['message'] as String? : null;
    final traceId = data is Map ? data['traceId'] as String? : null;
    final rawErrors = data is Map && data['errors'] is List
        ? (data['errors'] as List).whereType<String>().toList()
        : <String>[];

    return switch (status) {
      400 || 422 => ApiException(
          kind: ApiErrorKind.validation,
          message: serverMessage ??
              (rawErrors.isNotEmpty ? rawErrors.join('، ') : 'بيانات غير صالحة'),
          statusCode: status,
          traceId: traceId,
          errors: rawErrors,
        ),
      401 => ApiException(
          kind: ApiErrorKind.unauthorized,
          message: serverMessage ?? 'انتهت الجلسة، يرجى تسجيل الدخول مجدداً',
          statusCode: 401,
          traceId: traceId,
        ),
      403 => ApiException(
          kind: ApiErrorKind.forbidden,
          message: serverMessage ?? 'ليس لديك صلاحية للوصول',
          statusCode: 403,
          traceId: traceId,
        ),
      404 => ApiException(
          kind: ApiErrorKind.notFound,
          message: serverMessage ?? 'المورد غير موجود',
          statusCode: 404,
          traceId: traceId,
        ),
      409 => ApiException(
          kind: ApiErrorKind.conflict,
          message: serverMessage ?? 'تعارض في البيانات',
          statusCode: 409,
          traceId: traceId,
        ),
      429 => ApiException(
          kind: ApiErrorKind.rateLimited,
          message: 'الرجاء الانتظار قبل المحاولة مجددًا',
          statusCode: 429,
          traceId: traceId,
        ),
      _ when status >= 500 => ApiException(
          kind: ApiErrorKind.server,
          message: serverMessage ?? 'خطأ في الخادم، يرجى المحاولة لاحقاً',
          statusCode: status,
          traceId: traceId,
        ),
      _ => ApiException(
          kind: ApiErrorKind.unknown,
          message: serverMessage ?? 'حدث خطأ غير متوقع',
          statusCode: status,
          traceId: traceId,
        ),
    };
  }

  @override
  String toString() => 'ApiException($kind, $statusCode): $message'
      '${traceId != null ? " [trace: $traceId]" : ""}';
}
