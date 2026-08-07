// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occasion_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OccasionListItem _$OccasionListItemFromJson(Map<String, dynamic> json) =>
    _OccasionListItem(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String?,
      icon: json['icon'] as String?,
      imageUrl: json['imageUrl'] as String?,
      productCount: (json['productCount'] as num?)?.toInt() ?? 0,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$OccasionListItemToJson(_OccasionListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'icon': instance.icon,
      'imageUrl': instance.imageUrl,
      'productCount': instance.productCount,
      'displayOrder': instance.displayOrder,
      'isActive': instance.isActive,
    };

_OccasionDetail _$OccasionDetailFromJson(Map<String, dynamic> json) =>
    _OccasionDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      imageUrl: json['imageUrl'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$OccasionDetailToJson(_OccasionDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'icon': instance.icon,
      'imageUrl': instance.imageUrl,
      'displayOrder': instance.displayOrder,
      'isActive': instance.isActive,
    };

_OccasionRequest _$OccasionRequestFromJson(Map<String, dynamic> json) =>
    _OccasionRequest(
      name: json['name'] as String,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$OccasionRequestToJson(_OccasionRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'icon': instance.icon,
      'displayOrder': instance.displayOrder,
      'isActive': instance.isActive,
    };
