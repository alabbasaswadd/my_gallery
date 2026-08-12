import 'package:dio/dio.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/api_host.dart';
import 'package:my_gallery/features/auth/data/models/auth_models.dart';
import 'package:my_gallery/features/store_registration/data/models/store_registration_models.dart';

/// Talks to the public store-creation endpoint. Anonymous (no bearer token);
/// on success the API returns an [AuthResult] the caller uses to sign in.
class StoreRegistrationService {
  final Dio _dio;

  StoreRegistrationService({Dio? dio}) : _dio = dio ?? ApiClient.dio;

  /// Creates a store and returns the owner's fresh auth session.
  ///
  /// A duplicate subdomain/domain/email surfaces as an [ApiException]
  /// (validation/conflict) carrying the server's Arabic message.
  Future<AuthResult> register(RegisterStoreRequest request) async {
    try {
      // Registration is anonymous — always hit the central API.
      ApiHost.instance.useDefault();
      final resp = await _dio.post('/stores/register', data: _toJson(request));
      final data = resp.data['data'] as Map<String, dynamic>;
      // The new shop's live subdomain becomes the client's API host.
      final domain =
          (data['user'] as Map<String, dynamic>?)?['primaryDomain'] as String?;
      await ApiHost.instance.setFromDomain(domain);
      return AuthResult.fromJson(data);
    } on DioException catch (e) {
      throw exceptionFromDio(e);
    }
  }

  /// Sends only the fields that carry a value, so the server never receives
  /// empty strings for optionals it treats as "not provided".
  Map<String, dynamic> _toJson(RegisterStoreRequest r) {
    final map = <String, dynamic>{
      'shopName': r.shopName.trim(),
      'ownerName': r.ownerName.trim(),
      'subdomainLabel': r.subdomainLabel.trim().toLowerCase(),
      'email': r.email.trim(),
      'password': r.password,
    };
    void put(String key, String? value) {
      final v = value?.trim();
      if (v != null && v.isNotEmpty) map[key] = v;
    }

    put('phone', r.phone);
    put('whatsApp', r.whatsApp);
    put('city', r.city);
    put('country', r.country);
    put('businessType', r.businessType);
    put('description', r.description);
    put('customDomain', r.customDomain);
    return map;
  }
}
