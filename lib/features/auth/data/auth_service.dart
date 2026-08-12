import 'package:dio/dio.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/api_host.dart';
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
      // Credentials always go to the central API — the shop domain isn't known yet.
      ApiHost.instance.useDefault();
      final resp = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final data = resp.data['data'] as Map<String, dynamic>;
      // Adopt the shop's own domain for every subsequent authenticated call.
      final domain =
          (data['user'] as Map<String, dynamic>?)?['primaryDomain'] as String?;
      await ApiHost.instance.setFromDomain(domain);
      return AuthResult.fromJson(data);
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
    // Return the client to the central API for the next (possibly different) user.
    await ApiHost.instance.reset();
  }
}
