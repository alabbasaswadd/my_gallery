// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryListItem _$CategoryListItemFromJson(Map<String, dynamic> json) =>
    _CategoryListItem(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      parentName: json['parentName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      productCount: (json['productCount'] as num?)?.toInt() ?? 0,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$CategoryListItemToJson(_CategoryListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentName': instance.parentName,
      'imageUrl': instance.imageUrl,
      'productCount': instance.productCount,
      'displayOrder': instance.displayOrder,
      'isActive': instance.isActive,
    };

_CategoryDetail _$CategoryDetailFromJson(Map<String, dynamic> json) =>
    _CategoryDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      parentId: (json['parentId'] as num?)?.toInt(),
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$CategoryDetailToJson(_CategoryDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'parentId': instance.parentId,
      'displayOrder': instance.displayOrder,
      'isActive': instance.isActive,
      'imageUrl': instance.imageUrl,
    };

_CategoryRequest _$CategoryRequestFromJson(Map<String, dynamic> json) =>
    _CategoryRequest(
      name: json['name'] as String,
      description: json['description'] as String?,
      parentId: (json['parentId'] as num?)?.toInt(),
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      removeImage: json['removeImage'] as bool? ?? false,
    );

Map<String, dynamic> _$CategoryRequestToJson(_CategoryRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'parentId': instance.parentId,
      'displayOrder': instance.displayOrder,
      'isActive': instance.isActive,
      'removeImage': instance.removeImage,
    };
