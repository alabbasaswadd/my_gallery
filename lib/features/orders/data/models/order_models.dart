import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_models.freezed.dart';
part 'order_models.g.dart';

@freezed
sealed class OrderListItem with _$OrderListItem {
  const factory OrderListItem({
    required int id,
    required String orderNumber,
    String? customerName,
    String? customerWhatsApp,
    required String status,
    required double totalAmount,
    @Default(0) int itemsCount,
    String? createdAt,
  }) = _OrderListItem;

  factory OrderListItem.fromJson(Map<String, dynamic> json) =>
      _$OrderListItemFromJson(json);
}

@freezed
sealed class OrderDetail with _$OrderDetail {
  const factory OrderDetail({
    required int id,
    required String orderNumber,
    String? customerName,
    String? customerWhatsApp,
    String? notes,
    required String status,
    required double totalAmount,
    @Default([]) List<OrderDetailItem> items,
    String? createdAt,
  }) = _OrderDetail;

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);
}

@freezed
sealed class OrderDetailItem with _$OrderDetailItem {
  const factory OrderDetailItem({
    required int id,
    required String productName,
    required double unitPrice,
    required int quantity,
    required double lineTotal,
  }) = _OrderDetailItem;

  factory OrderDetailItem.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailItemFromJson(json);
}
