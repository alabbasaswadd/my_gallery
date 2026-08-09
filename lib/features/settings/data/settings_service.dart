import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/products/data/image_rules.dart';
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

  /// Authenticated fetch for editing (shop comes from the token). Returns the
  /// full identity, including colors/radius/font, for the customization editor.
  Future<StorefrontSettings> getEditableSettings() async {
    try {
      final resp = await _dio.get('/settings');
      _assertOk(resp);
      return StorefrontSettings.fromJson(
          resp.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  /// Uploads one image (logo / favicon / hero) and returns the stored web path
  /// (e.g. `/uploads/ab12….png`) to save into settings. Validates client-side
  /// first (jpeg/png/webp/gif, ≤ 5 MB) to mirror the server.
  Future<String> uploadImage(File file) async {
    await assertValidImages([file]);
    final filename = file.uri.pathSegments.last;
    final ext = filename.split('.').last.toLowerCase();
    final mimeType = _imageMimeType(ext);
    if (kDebugMode) {
      debugPrint('[SettingsImage] → POST /settings/images  field=file  filename=$filename  mime=$mimeType');
    }
    try {
      final form = FormData()
        ..files.add(MapEntry(
          'file',
          await MultipartFile.fromFile(
            file.path,
            filename: filename,
            contentType: MediaType.parse(mimeType),
          ),
        ));
      final resp = await _dio.post('/settings/images', data: form);
      if (kDebugMode) {
        debugPrint('[SettingsImage] ← status=${resp.statusCode}  body=${resp.data}');
      }
      _assertOk(resp);
      return resp.data['data']['url'] as String;
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('[SettingsImage] ✗ status=${e.response?.statusCode}  body=${e.response?.data}');
      }
      throw exceptionFromDio(e);
    }
  }

  static String _imageMimeType(String ext) => switch (ext) {
        'jpg' || 'jpeg' => 'image/jpeg',
        'png' => 'image/png',
        'webp' => 'image/webp',
        'gif' => 'image/gif',
        _ => 'application/octet-stream',
      };

  /// Full replace of the shop settings. Builds the exact JSON the API expects:
  /// hex color strings, a CSS `borderRadius` string ("16px"), nested social.
  Future<void> updateSettings(StorefrontSettings s) async {
    try {
      final resp = await _dio.put('/settings', data: {
        'brandName': s.brandName,
        'logo': s.logo ?? '',
        'favicon': s.favicon ?? '',
        'website': s.website,
        'primaryColor': s.primaryColor,
        'secondaryColor': s.secondaryColor,
        'accentColor': s.accentColor,
        'backgroundColor': s.backgroundColor,
        'surfaceColor': s.surfaceColor,
        'textColor': s.textColor,
        'borderRadius': '${s.borderRadius.round()}px',
        'fontFamily': s.fontFamily,
        'social': {
          'instagram': s.social.instagram,
          'facebook': s.social.facebook,
          'whatsApp': s.social.whatsApp,
        },
        'heroSlides': s.heroSlides
            .map((h) => {
                  'imageUrl': h.imageUrl,
                  'title': h.title ?? '',
                  'subtitle': h.subtitle ?? '',
                  'ctaText': h.ctaText ?? '',
                  'ctaHref': h.ctaHref ?? '',
                })
            .toList(),
      });
      _assertOk(resp);
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
