import 'package:dio/dio.dart';
import 'package:my_gallery/core/network/api_client.dart';
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
      return AuthResult.fromJson(resp.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<CurrentUser> getMe() async {
    try {
      final resp = await _dio.get('/auth/me');
      return CurrentUser.fromJson(resp.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } catch (_) {}
    await SecureStorage.clearAll();
  }
}
