// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storefront_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StorefrontProduct _$StorefrontProductFromJson(Map<String, dynamic> json) =>
    _StorefrontProduct(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      categoryName: json['categoryName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      shortDescription: json['shortDescription'] as String?,
    );

Map<String, dynamic> _$StorefrontProductToJson(_StorefrontProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryName': instance.categoryName,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'discountPrice': instance.discountPrice,
      'shortDescription': instance.shortDescription,
    };

_StorefrontProductDetail _$StorefrontProductDetailFromJson(
  Map<String, dynamic> json,
) => _StorefrontProductDetail(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  shortDescription: json['shortDescription'] as String?,
  description: json['description'] as String?,
  price: (json['price'] as num).toDouble(),
  discountPrice: (json['discountPrice'] as num?)?.toDouble(),
  categoryName: json['categoryName'] as String?,
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => StorefrontImage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$StorefrontProductDetailToJson(
  _StorefrontProductDetail instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'shortDescription': instance.shortDescription,
  'description': instance.description,
  'price': instance.price,
  'discountPrice': instance.discountPrice,
  'categoryName': instance.categoryName,
  'images': instance.images,
};

_StorefrontImage _$StorefrontImageFromJson(Map<String, dynamic> json) =>
    _StorefrontImage(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      isCover: json['isCover'] as bool? ?? false,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$StorefrontImageToJson(_StorefrontImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'isCover': instance.isCover,
      'sortOrder': instance.sortOrder,
    };

_StorefrontCategory _$StorefrontCategoryFromJson(Map<String, dynamic> json) =>
    _StorefrontCategory(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$StorefrontCategoryToJson(_StorefrontCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };

_PlaceOrderRequest _$PlaceOrderRequestFromJson(Map<String, dynamic> json) =>
    _PlaceOrderRequest(
      customerWhatsApp: json['customerWhatsApp'] as String,
      customerName: json['customerName'] as String?,
      notes: json['notes'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItemRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceOrderRequestToJson(_PlaceOrderRequest instance) =>
    <String, dynamic>{
      'customerWhatsApp': instance.customerWhatsApp,
      'customerName': instance.customerName,
      'notes': instance.notes,
      'items': instance.items,
    };

_OrderItemRequest _$OrderItemRequestFromJson(Map<String, dynamic> json) =>
    _OrderItemRequest(
      productId: (json['productId'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$OrderItemRequestToJson(_OrderItemRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
    };

_PlaceOrderResult _$PlaceOrderResultFromJson(Map<String, dynamic> json) =>
    _PlaceOrderResult(
      id: (json['id'] as num).toInt(),
      orderNumber: json['orderNumber'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$PlaceOrderResultToJson(_PlaceOrderResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'totalAmount': instance.totalAmount,
    };
