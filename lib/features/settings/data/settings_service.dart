import 'package:dio/dio.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';

class SettingsService {
  final Dio _dio;

  SettingsService({Dio? dio}) : _dio = dio ?? ApiClient.dio;

  Future<StorefrontSettings> getSettings(int shopId) async {
    try {
      final resp = await _dio.get('/storefront/$shopId/settings');
      return StorefrontSettings.fromJson(
          resp.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<SocialLinks> getSocial() async {
    try {
      final resp = await _dio.get('/settings');
      _assertOk(resp);
      final social =
          (resp.data['data']?['social'] ?? <String, dynamic>{}) as Map<String, dynamic>;
      return SocialLinks.fromJson(social);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> updateSocial(SocialLinks links) async {
    try {
      final resp = await _dio.patch('/settings/social', data: {
        'instagram': links.instagram.trim(),
        'facebook': links.facebook.trim(),
        'whatsApp': links.whatsApp.trim(),
      });
      _assertOk(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  void _assertOk(Response<dynamic> resp) {
    final ok = resp.data?['success'] as bool? ?? false;
    if (!ok) {
      final msg = resp.data?['message'] as String? ?? 'حدث خطأ غير متوقع';
      throw ApiException(
        kind: ApiErrorKind.server,
        message: msg,
        statusCode: resp.statusCode,
      );
    }
  }
}
