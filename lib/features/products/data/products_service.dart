import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/network/api_response.dart';
import 'package:my_gallery/features/products/data/image_rules.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';

class ProductsService {
  final Dio _dio;

  ProductsService({Dio? dio}) : _dio = dio ?? ApiClient.dio;

  Future<ApiResponse<List<ProductListItem>>> getProducts(ProductFilter filter) async {
    try {
      final params = <String, dynamic>{
        'Page': filter.page,
        'PageSize': filter.pageSize,
        'Sort': filter.sort,
      };
      if (filter.search?.isNotEmpty == true) params['Search'] = filter.search;
      if (filter.categoryId != null) params['CategoryId'] = filter.categoryId;
      if (filter.minPrice != null) params['MinPrice'] = filter.minPrice;
      if (filter.maxPrice != null) params['MaxPrice'] = filter.maxPrice;
      if (filter.isActive != null) params['IsActive'] = filter.isActive;

      final resp = await _dio.get('/products', queryParameters: params);
      _assertOk(resp);

      final data = resp.data as Map<String, dynamic>;
      final items = (data['data'] as List? ?? [])
          .map((e) => ProductListItem.fromJson(e as Map<String, dynamic>))
          .toList();
      final pagination = data['pagination'] != null
          ? PaginationMeta.fromJson(data['pagination'] as Map<String, dynamic>)
          : null;
      return ApiResponse<List<ProductListItem>>(
        success: data['success'] as bool? ?? true,
        message: data['message'] as String?,
        data: items,
        pagination: pagination,
      );
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<ProductDetail> getProduct(int id) async {
    try {
      final resp = await _dio.get('/products/$id');
      _assertOk(resp);
      return ProductDetail.fromJson(resp.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<int> createProduct(ProductRequest request) async {
    try {
      final resp = await _dio.post('/products', data: _toJson(request));
      if (resp.statusCode == 201) return resp.data['data'] as int;
      throw _apiError(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> updateProduct(int id, ProductRequest request) async {
    try {
      final resp = await _dio.put('/products/$id', data: _toJson(request));
      _assertOk(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final resp = await _dio.delete('/products/$id');
      _assertOk(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> activateProduct(int id) async {
    try {
      await _dio.patch('/products/$id/activate');
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> deactivateProduct(int id) async {
    try {
      await _dio.patch('/products/$id/deactivate');
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> updateStock(int id, int quantity) async {
    try {
      await _dio.patch('/products/$id/stock', data: {'stockQuantity': quantity});
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> updatePrice(int id, double price) async {
    try {
      await _dio.patch('/products/$id/price', data: {'price': price});
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> updateDiscount(int id, double? discountPrice) async {
    try {
      await _dio.patch('/products/$id/discount', data: {'discountPrice': discountPrice});
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<int> duplicateProduct(int id) async {
    try {
      final resp = await _dio.post('/products/$id/duplicate');
      if (resp.statusCode == 201) return resp.data['data'] as int;
      throw _apiError(resp);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> uploadImages(int id, List<File> files) async {
    await assertValidImages(files);
    try {
      final formData = FormData();
      for (final file in files) {
        final filename = file.uri.pathSegments.last;
        final ext = filename.split('.').last.toLowerCase();
        final mimeType = _imageMimeType(ext);
        if (kDebugMode) {
          debugPrint('[ProductImage] → POST /products/$id/images  field=files  filename=$filename  mime=$mimeType');
        }
        formData.files.add(MapEntry(
          'files',
          await MultipartFile.fromFile(
            file.path,
            filename: filename,
            contentType: MediaType.parse(mimeType),
          ),
        ));
      }
      final resp = await _dio.post('/products/$id/images', data: formData);
      if (kDebugMode) {
        debugPrint('[ProductImage] ← status=${resp.statusCode}  body=${resp.data}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('[ProductImage] ✗ status=${e.response?.statusCode}  body=${e.response?.data}');
      }
      throw exceptionFromDio(e);
    }
  }

  Future<void> deleteImage(int productId, int imageId) async {
    try {
      await _dio.delete('/products/$productId/images/$imageId');
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> setCoverImage(int productId, int imageId) async {
    try {
      await _dio.patch('/products/$productId/cover-image', data: {'imageId': imageId});
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> replaceImage(int productId, int imageId, File file) async {
    final ext = file.path.split('.').last.toLowerCase();
    if (!{'jpg', 'jpeg', 'png', 'webp', 'gif'}.contains(ext)) {
      throw const ApiException(
        kind: ApiErrorKind.validation,
        message: 'نوع الملف غير مدعوم. يُسمح فقط بـ: jpeg، png، webp، gif',
      );
    }
    final sizeBytes = await file.length();
    if (sizeBytes > 5 * 1024 * 1024) {
      throw const ApiException(
        kind: ApiErrorKind.validation,
        message: 'حجم الملف يتجاوز 5 ميجابايت',
      );
    }
    final filename = file.uri.pathSegments.last;
    final mimeType = _imageMimeType(ext);
    if (kDebugMode) {
      debugPrint('[ProductImage] → PUT /products/$productId/images/$imageId  field=file  filename=$filename  mime=$mimeType');
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
      final resp = await _dio.put(
        '/products/$productId/images/$imageId',
        data: form,
      );
      if (kDebugMode) {
        debugPrint('[ProductImage] ← status=${resp.statusCode}  body=${resp.data}');
      }
      _assertOk(resp);
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('[ProductImage] ✗ status=${e.response?.statusCode}  body=${e.response?.data}');
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

  Map<String, dynamic> _toJson(ProductRequest r) => {
        'name': r.name,
        'categoryId': r.categoryId,
        'price': r.price,
        if (r.shortDescription != null) 'shortDescription': r.shortDescription,
        if (r.description != null) 'description': r.description,
        if (r.sku != null) 'sku': r.sku,
        if (r.barcode != null) 'barcode': r.barcode,
        'discountPrice': r.discountPrice,
        'stockQuantity': r.stockQuantity,
        if (r.weight != null) 'weight': r.weight,
        if (r.width != null) 'width': r.width,
        if (r.height != null) 'height': r.height,
        if (r.length != null) 'length': r.length,
        'isFeatured': r.isFeatured,
        'isNew': r.isNew,
        'isAvailable': r.isAvailable,
        'isActive': r.isActive,
        'tagIds': r.tagIds,
        'occasionIds': r.occasionIds,
        if (r.removeImageIds.isNotEmpty) 'removeImageIds': r.removeImageIds,
        if (r.coverImageId != null) 'coverImageId': r.coverImageId,
      };
}
