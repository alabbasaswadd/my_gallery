// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductListItem _$ProductListItemFromJson(Map<String, dynamic> json) =>
    _ProductListItem(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      categoryName: json['categoryName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ProductListItemToJson(_ProductListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryName': instance.categoryName,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'discountPrice': instance.discountPrice,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt,
    };

_ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) =>
    _ProductDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String?,
      description: json['description'] as String?,
      sku: json['sku'] as String?,
      barcode: json['barcode'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      stockQuantity: (json['stockQuantity'] as num?)?.toInt() ?? 0,
      weight: (json['weight'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toDouble(),
      isFeatured: json['isFeatured'] as bool? ?? false,
      isNew: json['isNew'] as bool? ?? false,
      isAvailable: json['isAvailable'] as bool? ?? true,
      isActive: json['isActive'] as bool? ?? true,
      tagIds:
          (json['tagIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      occasionIds:
          (json['occasionIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProductDetailToJson(_ProductDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'description': instance.description,
      'sku': instance.sku,
      'barcode': instance.barcode,
      'categoryId': instance.categoryId,
      'price': instance.price,
      'discountPrice': instance.discountPrice,
      'stockQuantity': instance.stockQuantity,
      'weight': instance.weight,
      'width': instance.width,
      'height': instance.height,
      'length': instance.length,
      'isFeatured': instance.isFeatured,
      'isNew': instance.isNew,
      'isAvailable': instance.isAvailable,
      'isActive': instance.isActive,
      'tagIds': instance.tagIds,
      'occasionIds': instance.occasionIds,
      'images': instance.images,
    };

_ProductImage _$ProductImageFromJson(Map<String, dynamic> json) =>
    _ProductImage(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      isCover: json['isCover'] as bool? ?? false,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProductImageToJson(_ProductImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'isCover': instance.isCover,
      'sortOrder': instance.sortOrder,
    };

_ProductRequest _$ProductRequestFromJson(Map<String, dynamic> json) =>
    _ProductRequest(
      name: json['name'] as String,
      categoryId: (json['categoryId'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      shortDescription: json['shortDescription'] as String?,
      description: json['description'] as String?,
      sku: json['sku'] as String?,
      barcode: json['barcode'] as String?,
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      stockQuantity: (json['stockQuantity'] as num?)?.toInt() ?? 0,
      weight: (json['weight'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toDouble(),
      isFeatured: json['isFeatured'] as bool? ?? false,
      isNew: json['isNew'] as bool? ?? false,
      isAvailable: json['isAvailable'] as bool? ?? true,
      isActive: json['isActive'] as bool? ?? true,
      tagIds:
          (json['tagIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      occasionIds:
          (json['occasionIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      removeImageIds:
          (json['removeImageIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      coverImageId: (json['coverImageId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductRequestToJson(_ProductRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'categoryId': instance.categoryId,
      'price': instance.price,
      'shortDescription': instance.shortDescription,
      'description': instance.description,
      'sku': instance.sku,
      'barcode': instance.barcode,
      'discountPrice': instance.discountPrice,
      'stockQuantity': instance.stockQuantity,
      'weight': instance.weight,
      'width': instance.width,
      'height': instance.height,
      'length': instance.length,
      'isFeatured': instance.isFeatured,
      'isNew': instance.isNew,
      'isAvailable': instance.isAvailable,
      'isActive': instance.isActive,
      'tagIds': instance.tagIds,
      'occasionIds': instance.occasionIds,
      'removeImageIds': instance.removeImageIds,
      'coverImageId': instance.coverImageId,
    };
