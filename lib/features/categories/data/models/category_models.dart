import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_models.freezed.dart';
part 'category_models.g.dart';

@freezed
sealed class CategoryListItem with _$CategoryListItem {
  const factory CategoryListItem({
    required int id,
    required String name,
    String? parentName,
    String? imageUrl,
    @Default(0) int productCount,
    @Default(0) int displayOrder,
    @Default(true) bool isActive,
  }) = _CategoryListItem;

  factory CategoryListItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryListItemFromJson(json);
}

@freezed
sealed class CategoryDetail with _$CategoryDetail {
  const factory CategoryDetail({
    required int id,
    required String name,
    String? description,
    int? parentId,
    @Default(0) int displayOrder,
    @Default(true) bool isActive,
    String? imageUrl,
  }) = _CategoryDetail;

  factory CategoryDetail.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailFromJson(json);
}

@freezed
sealed class CategoryRequest with _$CategoryRequest {
  const factory CategoryRequest({
    required String name,
    String? description,
    int? parentId,
    @Default(0) int displayOrder,
    @Default(true) bool isActive,
    @Default(false) bool removeImage,
  }) = _CategoryRequest;

  factory CategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$CategoryRequestFromJson(json);
}
