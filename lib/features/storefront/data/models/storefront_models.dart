import 'package:freezed_annotation/freezed_annotation.dart';

part 'storefront_models.freezed.dart';
part 'storefront_models.g.dart';

@freezed
sealed class StorefrontProduct with _$StorefrontProduct {
  const factory StorefrontProduct({
    required int id,
    required String name,
    String? categoryName,
    String? imageUrl,
    required double price,
    double? discountPrice,
    String? shortDescription,
  }) = _StorefrontProduct;

  factory StorefrontProduct.fromJson(Map<String, dynamic> json) =>
      _$StorefrontProductFromJson(json);
}

@freezed
sealed class StorefrontProductDetail with _$StorefrontProductDetail {
  const factory StorefrontProductDetail({
    required int id,
    required String name,
    String? shortDescription,
    String? description,
    required double price,
    double? discountPrice,
    String? categoryName,
    @Default([]) List<StorefrontImage> images,
  }) = _StorefrontProductDetail;

  factory StorefrontProductDetail.fromJson(Map<String, dynamic> json) =>
      _$StorefrontProductDetailFromJson(json);
}

@freezed
sealed class StorefrontImage with _$StorefrontImage {
  const factory StorefrontImage({
    required int id,
    required String url,
    @Default(false) bool isCover,
    @Default(0) int sortOrder,
  }) = _StorefrontImage;

  factory StorefrontImage.fromJson(Map<String, dynamic> json) =>
      _$StorefrontImageFromJson(json);
}

@freezed
sealed class StorefrontCategory with _$StorefrontCategory {
  const factory StorefrontCategory({
    required int id,
    required String name,
    String? imageUrl,
  }) = _StorefrontCategory;

  factory StorefrontCategory.fromJson(Map<String, dynamic> json) =>
      _$StorefrontCategoryFromJson(json);
}

@freezed
sealed class PlaceOrderRequest with _$PlaceOrderRequest {
  const factory PlaceOrderRequest({
    required String customerWhatsApp,
    String? customerName,
    String? notes,
    required List<OrderItemRequest> items,
  }) = _PlaceOrderRequest;

  factory PlaceOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderRequestFromJson(json);
}

@freezed
sealed class OrderItemRequest with _$OrderItemRequest {
  const factory OrderItemRequest({
    required int productId,
    required int quantity,
  }) = _OrderItemRequest;

  factory OrderItemRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderItemRequestFromJson(json);
}

@freezed
sealed class PlaceOrderResult with _$PlaceOrderResult {
  const factory PlaceOrderResult({
    required int id,
    required String orderNumber,
    required double totalAmount,
  }) = _PlaceOrderResult;

  factory PlaceOrderResult.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderResultFromJson(json);
}
