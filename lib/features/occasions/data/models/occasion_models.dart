import 'package:freezed_annotation/freezed_annotation.dart';

part 'occasion_models.freezed.dart';
part 'occasion_models.g.dart';

@freezed
sealed class OccasionListItem with _$OccasionListItem {
  const factory OccasionListItem({
    required int id,
    required String name,
    String? slug,
    String? icon,
    String? imageUrl,
    @Default(0) int productCount,
    @Default(0) int displayOrder,
    @Default(true) bool isActive,
  }) = _OccasionListItem;

  factory OccasionListItem.fromJson(Map<String, dynamic> json) =>
      _$OccasionListItemFromJson(json);
}

@freezed
sealed class OccasionDetail with _$OccasionDetail {
  const factory OccasionDetail({
    required int id,
    required String name,
    String? slug,
    String? description,
    String? icon,
    String? imageUrl,
    @Default(0) int displayOrder,
    @Default(true) bool isActive,
  }) = _OccasionDetail;

  factory OccasionDetail.fromJson(Map<String, dynamic> json) =>
      _$OccasionDetailFromJson(json);
}

@freezed
sealed class OccasionRequest with _$OccasionRequest {
  const factory OccasionRequest({
    required String name,
    String? slug,
    String? description,
    String? icon,
    @Default(0) int displayOrder,
    @Default(true) bool isActive,
  }) = _OccasionRequest;

  factory OccasionRequest.fromJson(Map<String, dynamic> json) =>
      _$OccasionRequestFromJson(json);
}
