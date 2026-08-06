import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/occasions/data/models/occasion_models.dart';
import 'package:my_gallery/features/products/data/image_rules.dart';

class OccasionsService {
  final Dio _dio;

  OccasionsService({Dio? dio}) : _dio = dio ?? ApiClient.dio;

  Future<List<OccasionListItem>> getOccasions() async {
    try {
      final resp = await _dio.get('/occasions');
      _assertOk(resp);
      final list = resp.data['data'] as List? ?? [];
      return list
          .map((e) => OccasionListItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<OccasionDetail> getOccasion(int id) async {
    try {
      final resp = await _dio.get('/occasions/$id');
      _assertOk(resp);
      return OccasionDetail.fromJson(resp.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<OccasionDetail> getOccasionBySlug(String slug) async {
    try {
      final resp = await _dio.get('/occasions/slug/$slug');
      _assertOk(resp);
      return OccasionDetail.fromJson(resp.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<int> createOccasion(OccasionRequest request) async {
    try {
      final resp = await _dio.post('/occasions', data: _toJson(request));
      if (resp.statusCode == 201) return resp.data['data'] as int;
      throw _apiError(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> updateOccasion(int id, OccasionRequest request) async {
    try {
      final resp = await _dio.put('/occasions/$id', data: _toJson(request));
      _assertOk(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> deleteOccasion(int id) async {
    try {
      final resp = await _dio.delete('/occasions/$id');
      _assertOk(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> reorderOccasions(List<int> orderedIds) async {
    try {
      await _dio.patch('/occasions/reorder', data: {'occasionIds': orderedIds});
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> activateOccasion(int id) async {
    try {
      await _dio.patch('/occasions/$id/activate');
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> deactivateOccasion(int id) async {
    try {
      await _dio.patch('/occasions/$id/deactivate');
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  /// Uploads and attaches the occasion image (multipart field `file`).
  Future<void> uploadImage(int id, File file) async {
    await assertValidImages([file]);
    try {
      final form = FormData()
        ..files.add(MapEntry(
          'file',
          await MultipartFile.fromFile(
            file.path,
            filename: file.uri.pathSegments.last,
          ),
        ));
      final resp = await _dio.post(
        '/occasions/$id/image',
        data: form,
        options: Options(contentType: 'multipart/form-data'),
      );
      _assertOk(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  void _assertOk(Response resp) {
    final status = resp.statusCode ?? 0;
    if (status < 200 || status >= 300) throw _apiError(resp);
  }

  ApiException _apiError(Response resp) {
    final data = resp.data;
    String message = 'حدث خطأ غير متوقع';
    if (data is Map) {
      message = data['message'] as String? ?? data['title'] as String? ?? message;
    }
    return ApiException(message: message, statusCode: resp.statusCode);
  }

  Map<String, dynamic> _toJson(OccasionRequest r) => {
        'name': r.name,
        if (r.slug != null && r.slug!.isNotEmpty) 'slug': r.slug,
        if (r.description != null) 'description': r.description,
        if (r.icon != null) 'icon': r.icon,
        'displayOrder': r.displayOrder,
        'isActive': r.isActive,
      };
}
