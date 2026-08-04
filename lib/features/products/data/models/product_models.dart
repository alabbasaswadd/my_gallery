import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_models.freezed.dart';
part 'product_models.g.dart';

@freezed
sealed class ProductListItem with _$ProductListItem {
  const factory ProductListItem({
    required int id,
    required String name,
    String? categoryName,
    String? imageUrl,
    required double price,
    double? discountPrice,
    @Default(true) bool isActive,
    String? createdAt,
  }) = _ProductListItem;

  factory ProductListItem.fromJson(Map<String, dynamic> json) =>
      _$ProductListItemFromJson(json);
}

@freezed
sealed class ProductDetail with _$ProductDetail {
  const factory ProductDetail({
    required int id,
    required String name,
    String? shortDescription,
    String? description,
    String? sku,
    String? barcode,
    int? categoryId,
    required double price,
    double? discountPrice,
    @Default(0) int stockQuantity,
    double? weight,
    double? width,
    double? height,
    double? length,
    @Default(false) bool isFeatured,
    @Default(false) bool isNew,
    @Default(true) bool isAvailable,
    @Default(true) bool isActive,
    @Default([]) List<int> tagIds,
    @Default([]) List<int> occasionIds,
    @Default([]) List<ProductImage> images,
  }) = _ProductDetail;

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);
}

@freezed
sealed class ProductImage with _$ProductImage {
  const factory ProductImage({
    required int id,
    required String url,
    @Default(false) bool isCover,
    @Default(0) int sortOrder,
  }) = _ProductImage;

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);
}

@freezed
sealed class ProductRequest with _$ProductRequest {
  const factory ProductRequest({
    required String name,
    required int categoryId,
    required double price,
    String? shortDescription,
    String? description,
    String? sku,
    String? barcode,
    double? discountPrice,
    @Default(0) int stockQuantity,
    double? weight,
    double? width,
    double? height,
    double? length,
    @Default(false) bool isFeatured,
    @Default(false) bool isNew,
    @Default(true) bool isAvailable,
    @Default(true) bool isActive,
    @Default([]) List<int> tagIds,
    @Default([]) List<int> occasionIds,
    @Default([]) List<int> removeImageIds,
    int? coverImageId,
  }) = _ProductRequest;

  factory ProductRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestFromJson(json);
}

@freezed
sealed class ProductFilter with _$ProductFilter {
  const factory ProductFilter({
    String? search,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    bool? isActive,
    @Default('Newest') String sort,
    @Default(1) int page,
    @Default(12) int pageSize,
  }) = _ProductFilter;
}
