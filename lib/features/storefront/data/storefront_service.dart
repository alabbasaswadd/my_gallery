import 'package:dio/dio.dart';
import 'package:my_gallery/core/config/app_config.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/network/api_response.dart';
import 'package:my_gallery/features/storefront/data/models/storefront_models.dart';

class StorefrontService {
  final Dio _dio;
  final int shopId;

  StorefrontService({Dio? dio, int? shopId})
      : _dio = dio ?? ApiClient.dio,
        shopId = shopId ?? AppConfig.shopId;

  String get _base => '/storefront/$shopId';

  Future<ApiResponse<List<StorefrontProduct>>> getProducts({
    String? search,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    String sort = 'Newest',
    int page = 1,
    int pageSize = 12,
  }) async {
    try {
      final params = <String, dynamic>{
        'Page': page,
        'PageSize': pageSize,
        'Sort': sort,
      };
      if (search?.isNotEmpty == true) params['Search'] = search;
      if (categoryId != null) params['CategoryId'] = categoryId;
      if (minPrice != null) params['MinPrice'] = minPrice;
      if (maxPrice != null) params['MaxPrice'] = maxPrice;

      final resp = await _dio.get('$_base/products', queryParameters: params);
      _assertOk(resp);

      final data = resp.data as Map<String, dynamic>;
      final items = (data['data'] as List? ?? [])
          .map((e) => StorefrontProduct.fromJson(e as Map<String, dynamic>))
          .toList();
      final pagination = data['pagination'] != null
          ? PaginationMeta.fromJson(data['pagination'] as Map<String, dynamic>)
          : null;
      return ApiResponse<List<StorefrontProduct>>(
        success: true,
        data: items,
        pagination: pagination,
      );
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<StorefrontProductDetail> getProduct(int productId) async {
    try {
      final resp = await _dio.get('$_base/products/$productId');
      _assertOk(resp);
      return StorefrontProductDetail.fromJson(
          resp.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<List<StorefrontCategory>> getCategories() async {
    try {
      final resp = await _dio.get('$_base/categories');
      _assertOk(resp);
      return (resp.data['data'] as List? ?? [])
          .map((e) => StorefrontCategory.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<PlaceOrderResult> placeOrder(PlaceOrderRequest request) async {
    try {
      final resp = await _dio.post('$_base/orders', data: {
        'customerWhatsApp': request.customerWhatsApp,
        if (request.customerName?.isNotEmpty == true)
          'customerName': request.customerName,
        if (request.notes?.isNotEmpty == true) 'notes': request.notes,
        'items': request.items
            .map((i) => {'productId': i.productId, 'quantity': i.quantity})
            .toList(),
      });
      if (resp.statusCode == 201 && resp.data['success'] == true) {
        return PlaceOrderResult.fromJson(
            resp.data['data'] as Map<String, dynamic>);
      }
      final msg = resp.statusCode == 429
          ? 'الرجاء الانتظار قبل إرسال طلب آخر'
          : (resp.data['message'] as String? ?? 'فشل إرسال الطلب');
      throw ApiException(message: msg, statusCode: resp.statusCode);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  void _assertOk(Response resp) {
    final s = resp.statusCode ?? 0;
    if (s < 200 || s >= 300) {
      final msg =
          (resp.data is Map ? resp.data['message'] : null) as String? ??
              'خطأ غير متوقع';
      throw ApiException(message: msg, statusCode: s);
    }
  }
}
