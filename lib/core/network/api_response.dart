import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    @Default(false) bool success,
    String? message,
    T? data,
    List<String>? errors,
    @JsonKey(name: 'pagination') PaginationMeta? pagination,
    String? timestamp,
    String? traceId,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}

@freezed
sealed class PaginationMeta with _$PaginationMeta {
  const factory PaginationMeta({
    @Default(1) int page,
    @Default(12) int pageSize,
    @Default(0) int totalCount,
    @Default(0) int totalPages,
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
  }) = _PaginationMeta;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
}
