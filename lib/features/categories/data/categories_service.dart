import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';
import 'package:my_gallery/features/products/data/image_rules.dart';

class CategoriesService {
  final Dio _dio;

  CategoriesService({Dio? dio}) : _dio = dio ?? ApiClient.dio;

  Future<List<CategoryListItem>> getCategories() async {
    try {
      final resp = await _dio.get('/categories');
      _assertOk(resp);
      final list = resp.data['data'] as List? ?? [];
      return list
          .map((e) => CategoryListItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<CategoryDetail> getCategory(int id) async {
    try {
      final resp = await _dio.get('/categories/$id');
      _assertOk(resp);
      return CategoryDetail.fromJson(resp.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<int> createCategory(CategoryRequest request) async {
    try {
      final resp = await _dio.post('/categories', data: _toJson(request));
      if (resp.statusCode == 201) return resp.data['data'] as int;
      throw _apiError(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> updateCategory(int id, CategoryRequest request) async {
    try {
      final resp = await _dio.put('/categories/$id', data: _toJson(request));
      _assertOk(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      final resp = await _dio.delete('/categories/$id');
      _assertOk(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> uploadCategoryImage(int id, File file) async {
    final ext = file.path.split('.').last.toLowerCase();
    if (!allowedImageExts.contains(ext)) {
      throw const ApiException(
        kind: ApiErrorKind.validation,
        message: 'نوع الملف غير مدعوم. يُسمح فقط بـ: jpeg، png، webp، gif',
      );
    }
    final fileSize = await file.length();
    if (fileSize > maxImageBytes) {
      throw const ApiException(
        kind: ApiErrorKind.validation,
        message: 'حجم الملف يتجاوز 5 ميجابايت',
      );
    }

    final filename = file.uri.pathSegments.last;
    final mimeType = _imageMimeType(ext);

    if (kDebugMode) {
      debugPrint('[CategoryImage] → POST /categories/$id/images');
      debugPrint('[CategoryImage]   field=image  filename=$filename  mime=$mimeType  size=${fileSize}B');
    }

    try {
      final form = FormData()
        ..files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(
            file.path,
            filename: filename,
            contentType: MediaType.parse(mimeType),
          ),
        ));
      final resp = await _dio.post('/categories/$id/images', data: form);

      if (kDebugMode) {
        debugPrint('[CategoryImage] ← status=${resp.statusCode}  body=${resp.data}');
      }

      _assertOk(resp);
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('[CategoryImage] ✗ status=${e.response?.statusCode}');
        debugPrint('[CategoryImage] ✗ body=${e.response?.data}');
        debugPrint('[CategoryImage] ✗ type=${e.type}  message=${e.message}');
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

  Future<void> reorderCategories(List<int> orderedIds) async {
    try {
      await _dio.patch('/categories/reorder', data: {'categoryIds': orderedIds});
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> activateCategory(int id) async {
    try {
      await _dio.patch('/categories/$id/activate');
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> deactivateCategory(int id) async {
    try {
      await _dio.patch('/categories/$id/deactivate');
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

  Map<String, dynamic> _toJson(CategoryRequest r) => {
        'name': r.name,
        if (r.description != null) 'description': r.description,
        if (r.parentId != null) 'parentId': r.parentId,
        'displayOrder': r.displayOrder,
        'isActive': r.isActive,
        'removeImage': r.removeImage,
      };
}
