import 'package:dio/dio.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';

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
