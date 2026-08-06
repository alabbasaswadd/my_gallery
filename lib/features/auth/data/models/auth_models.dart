import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
sealed class AuthResult with _$AuthResult {
  const factory AuthResult({
    required String accessToken,
    required String expiresAt,
    required AuthUser user,
  }) = _AuthResult;

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);
}

@freezed
sealed class AuthUser with _$AuthUser {
  const factory AuthUser({
    required int id,
    required String fullName,
    required String email,
    required String role,
    required int shopId,
    required String shopName,
    @Default([]) List<String> permissions,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

@freezed
sealed class CurrentUser with _$CurrentUser {
  const factory CurrentUser({
    required String fullName,
    required String email,
    required String role,
    required int shopId,
    required String shopName,
  }) = _CurrentUser;

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);
}

@freezed
sealed class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}
