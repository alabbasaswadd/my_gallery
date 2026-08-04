import 'package:dio/dio.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/network/api_response.dart';
import 'package:my_gallery/features/orders/data/models/order_models.dart';

class OrdersService {
  final Dio _dio;

  OrdersService({Dio? dio}) : _dio = dio ?? ApiClient.dio;

  Future<ApiResponse<List<OrderListItem>>> getOrders({
    String? status,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final params = <String, dynamic>{'Page': page, 'PageSize': pageSize};
      if (status != null && status != 'All') params['Status'] = status;

      final resp = await _dio.get('/orders', queryParameters: params);
      _assertOk(resp);

      final data = resp.data as Map<String, dynamic>;
      final items = (data['data'] as List? ?? [])
          .map((e) => OrderListItem.fromJson(e as Map<String, dynamic>))
          .toList();
      final pagination = data['pagination'] != null
          ? PaginationMeta.fromJson(data['pagination'] as Map<String, dynamic>)
          : null;
      return ApiResponse<List<OrderListItem>>(
        success: true,
        data: items,
        pagination: pagination,
      );
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<OrderDetail> getOrder(int id) async {
    try {
      final resp = await _dio.get('/orders/$id');
      _assertOk(resp);
      return OrderDetail.fromJson(resp.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  Future<void> updateStatus(int id, String status) async {
    try {
      final resp =
          await _dio.patch('/orders/$id/status', data: {'status': status});
      _assertOk(resp);
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
