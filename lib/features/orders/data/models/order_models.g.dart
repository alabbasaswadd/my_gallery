// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderListItem _$OrderListItemFromJson(Map<String, dynamic> json) =>
    _OrderListItem(
      id: (json['id'] as num).toInt(),
      orderNumber: json['orderNumber'] as String,
      customerName: json['customerName'] as String?,
      customerWhatsApp: json['customerWhatsApp'] as String?,
      status: json['status'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      itemsCount: (json['itemsCount'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$OrderListItemToJson(_OrderListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'customerName': instance.customerName,
      'customerWhatsApp': instance.customerWhatsApp,
      'status': instance.status,
      'totalAmount': instance.totalAmount,
      'itemsCount': instance.itemsCount,
      'createdAt': instance.createdAt,
    };

_OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) => _OrderDetail(
  id: (json['id'] as num).toInt(),
  orderNumber: json['orderNumber'] as String,
  customerName: json['customerName'] as String?,
  customerWhatsApp: json['customerWhatsApp'] as String?,
  notes: json['notes'] as String?,
  status: json['status'] as String,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => OrderDetailItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$OrderDetailToJson(_OrderDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'customerName': instance.customerName,
      'customerWhatsApp': instance.customerWhatsApp,
      'notes': instance.notes,
      'status': instance.status,
      'totalAmount': instance.totalAmount,
      'items': instance.items,
      'createdAt': instance.createdAt,
    };

_OrderDetailItem _$OrderDetailItemFromJson(Map<String, dynamic> json) =>
    _OrderDetailItem(
      id: (json['id'] as num).toInt(),
      productName: json['productName'] as String,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      lineTotal: (json['lineTotal'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderDetailItemToJson(_OrderDetailItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'lineTotal': instance.lineTotal,
    };
