import 'package:dio/dio.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/storage/secure_storage.dart';
import 'package:my_gallery/features/auth/data/models/auth_models.dart';

class AuthService {
  final Dio _dio;

  AuthService({Dio? dio}) : _dio = dio ?? ApiClient.dio;

  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final resp = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      if (resp.statusCode == 200 && resp.data['success'] == true) {
        return AuthResult.fromJson(resp.data['data'] as Map<String, dynamic>);
      }
      throw ApiException(
        message: resp.data['message'] as String? ?? 'فشل تسجيل الدخول',
        statusCode: resp.statusCode,
      );
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<CurrentUser> getMe() async {
    try {
      final resp = await _dio.get('/auth/me');
      if (resp.statusCode == 200 && resp.data['success'] == true) {
        return CurrentUser.fromJson(resp.data['data'] as Map<String, dynamic>);
      }
      throw ApiException(
        message: resp.data['message'] as String? ?? 'فشل التحقق من الجلسة',
        statusCode: resp.statusCode,
      );
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> logout() async {
    final refreshToken = await SecureStorage.getRefreshToken();
    if (refreshToken != null) {
      try {
        await _dio.post(
          '/auth/logout',
          data: {'refreshToken': refreshToken},
        );
      } catch (_) {}
    }
    await SecureStorage.clearAll();
  }
}
