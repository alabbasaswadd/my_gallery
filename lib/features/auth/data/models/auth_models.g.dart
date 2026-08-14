// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResult _$AuthResultFromJson(Map<String, dynamic> json) => _AuthResult(
  accessToken: json['accessToken'] as String,
  expiresAt: json['expiresAt'] as String,
  refreshToken: json['refreshToken'] as String?,
  refreshExpiresAt: json['refreshExpiresAt'] as String?,
  user: AuthUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthResultToJson(_AuthResult instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'expiresAt': instance.expiresAt,
      'refreshToken': instance.refreshToken,
      'refreshExpiresAt': instance.refreshExpiresAt,
      'user': instance.user,
    };

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  id: (json['id'] as num).toInt(),
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  shopId: (json['shopId'] as num).toInt(),
  shopName: json['shopName'] as String,
  permissions:
      (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'email': instance.email,
  'role': instance.role,
  'shopId': instance.shopId,
  'shopName': instance.shopName,
  'permissions': instance.permissions,
};

_CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) => _CurrentUser(
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  shopId: (json['shopId'] as num).toInt(),
  shopName: json['shopName'] as String,
);

Map<String, dynamic> _$CurrentUserToJson(_CurrentUser instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'role': instance.role,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
    };

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};
