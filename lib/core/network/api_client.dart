import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_gallery/core/config/app_config.dart';
import 'package:my_gallery/core/logging/error_logger.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/network/retry_policy.dart';
import 'package:my_gallery/core/network/session_notifier.dart';
import 'package:my_gallery/core/session/session_manager.dart';
import 'package:my_gallery/core/storage/secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  static Dio? _dio;

  static Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        // Do NOT set contentType globally. On web, adding Content-Type to GET
        // requests makes them non-simple CORS requests and triggers an OPTIONS
        // preflight. Content-Type is set per-request in _AuthInterceptor only
        // for methods that carry a body (POST / PUT / PATCH).
        validateStatus: (_) => true,
      ),
    );

    // Order matters: the retry/connectivity interceptor runs FIRST so its
    // onError sees genuine transport failures before the auth interceptor maps
    // and rejects them, allowing a clean re-dispatch.
    dio.interceptors.add(NetworkRetryInterceptor(dio));
    dio.interceptors.add(_AuthInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
        ),
      );
    }
    return dio;
  }

  /// Marks a request as safe to auto-retry on transient network failures (see
  /// [NetworkRetryInterceptor]). Use ONLY for idempotent reads (GET/HEAD);
  /// never for create/update/delete/upload, to avoid duplicate side effects.
  ///
  /// ```dart
  /// _dio.get('/products', options: ApiClient.retryable());
  /// ```
  static Options retryable([Options? base]) {
    final options = base ?? Options();
    final extra = Map<String, dynamic>.from(options.extra ?? const {});
    extra[kRetryableExtra] = true;
    return options.copyWith(extra: extra);
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    // Set Content-Type only for requests that carry a JSON body.
    // GET / HEAD / DELETE have no body, so omitting Content-Type keeps them as
    // CORS "simple requests" on web and avoids unnecessary OPTIONS preflights.
    final method = options.method.toUpperCase();
    if (method == 'POST' || method == 'PUT' || method == 'PATCH') {
      options.contentType = 'application/json';
    }
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final status = response.statusCode ?? 0;
    if (status >= 200 && status < 300) {
      handler.next(response);
      return;
    }

    // A 401 on a request that carried our auth token means the token has
    // expired. Tear the session down so GoRouter redirects to login.
    // sessionExpiredPending tells the login screen to show a banner.
    // Unauthenticated public requests returning 401 are excluded (no header).
    if (status == 401 &&
        response.requestOptions.headers.containsKey('Authorization')) {
      SessionNotifier.instance.sessionExpiredPending = true;
      await SessionManager.instance.invalidate(reason: 'unauthorized (401)');
    }

    final exception = ApiException.fromDio(DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    ));

    // Log all non-2xx API errors at the single centralized point so individual
    // cubits never need to call the logger themselves.
    ErrorLogger.instance.logApiException(
      exception,
      requestOptions: response.requestOptions,
    );

    handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: exception,
        type: DioExceptionType.badResponse,
      ),
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception =
        err.error is ApiException ? err.error as ApiException : ApiException.fromDio(err);

    // Log transport-level errors (timeout, connection refused, etc.).
    if (err.error is! ApiException) {
      ErrorLogger.instance.logApiException(
        exception,
        requestOptions: err.requestOptions,
      );
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        response: err.response,
      ),
    );
  }
}

/// Unwraps an [ApiException] from a [DioException], or maps it from the raw error.
ApiException exceptionFromDio(DioException e) {
  if (e.error is ApiException) return e.error as ApiException;
  return ApiException.fromDio(e);
}
