// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItem _$CartItemFromJson(Map<String, dynamic> json) => _CartItem(
  productId: (json['productId'] as num).toInt(),
  name: json['name'] as String,
  unitPrice: (json['unitPrice'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String?,
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$CartItemToJson(_CartItem instance) => <String, dynamic>{
  'productId': instance.productId,
  'name': instance.name,
  'unitPrice': instance.unitPrice,
  'imageUrl': instance.imageUrl,
  'quantity': instance.quantity,
};
