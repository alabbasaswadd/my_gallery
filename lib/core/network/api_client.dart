import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_gallery/core/config/app_config.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/network/retry_policy.dart';
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
        contentType: 'application/json',
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

    // Non-2xx responses are mapped to ApiException and rejected.
    // Session management (logout, redirect) is handled only by explicit
    // user action — never triggered automatically by the network layer.
    final exception = ApiException.fromDio(DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    ));

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
