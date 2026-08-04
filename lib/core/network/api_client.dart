import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_gallery/core/config/app_config.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/storage/secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  static Dio? _dio;
  static bool _isRefreshing = false;

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

    dio.interceptors.add(_AuthInterceptor(dio));
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
}

class _AuthInterceptor extends Interceptor {
  final Dio _dio;

  _AuthInterceptor(this._dio);

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

    if (status == 401) {
      final retried = await _handleUnauthorized(response.requestOptions);
      if (retried != null) {
        handler.resolve(retried);
        return;
      }
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
      );
      return;
    }

    _mapResponseError(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message =
        _extractMessage(err.response?.data) ?? 'خطأ في الاتصال بالخادم';
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: ApiException(
          message: message,
          statusCode: err.response?.statusCode,
        ),
        type: err.type,
        response: err.response,
      ),
    );
  }

  void _mapResponseError(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final status = response.statusCode ?? 0;
    if (status >= 200 && status < 300) {
      handler.next(response);
      return;
    }

    final message = _extractMessage(response.data) ?? 'حدث خطأ غير متوقع';
    final traceId = _extractTraceId(response.data);

    handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: ApiException(
          message: message,
          statusCode: status,
          traceId: traceId,
        ),
        type: DioExceptionType.badResponse,
      ),
    );
  }

  Future<Response?> _handleUnauthorized(RequestOptions options) async {
    if (ApiClient._isRefreshing) {
      return null;
    }
    ApiClient._isRefreshing = true;
    try {
      final refreshToken = await SecureStorage.getRefreshToken();
      if (refreshToken == null) return null;

      final refreshDio = Dio(
        BaseOptions(
          baseUrl: AppConfig.apiBaseUrl,
          validateStatus: (_) => true,
        ),
      );

      final resp = await refreshDio.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (resp.statusCode != 200) {
        await SecureStorage.clearAll();
        return null;
      }

      final data = resp.data['data'];
      await SecureStorage.saveTokens(
        accessToken: data['accessToken'],
        refreshToken: data['refreshToken'],
        expiresAt: data['expiresAt'],
      );

      options.headers['Authorization'] = 'Bearer ${data['accessToken']}';
      final retryResp = await _dio.fetch(options);
      return retryResp;
    } catch (_) {
      await SecureStorage.clearAll();
      return null;
    } finally {
      ApiClient._isRefreshing = false;
    }
  }

  String? _extractMessage(dynamic data) {
    if (data == null) return null;
    if (data is Map) {
      return data['message'] as String? ??
          data['title'] as String? ??
          (data['errors'] is List
              ? (data['errors'] as List).firstOrNull as String?
              : null);
    }
    return null;
  }

  String? _extractTraceId(dynamic data) {
    if (data is Map) return data['traceId'] as String?;
    return null;
  }
}

ApiException exceptionFromDio(DioException e) {
  if (e.error is ApiException) return e.error as ApiException;
  return ApiException(
    message: 'خطأ في الاتصال بالخادم',
    statusCode: e.response?.statusCode,
  );
}
