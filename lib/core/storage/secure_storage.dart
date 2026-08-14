import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _accessTokenKey = 'access_token';
  static const _expiresAtKey = 'expires_at';

  static Future<void> saveTokens({
    required String accessToken,
    required String expiresAt,
  }) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _expiresAtKey, value: expiresAt),
    ]);
  }

  static Future<String?> getAccessToken() => _readSafe(_accessTokenKey);

  static Future<String?> getExpiresAt() => _readSafe(_expiresAtKey);

  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      if (kDebugMode) debugPrint('[SecureStorage] clearAll failed: $e');
    }
  }

  static Future<bool> hasValidSession() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // On web, flutter_secure_storage uses window.crypto.subtle (AES-GCM) to
  // decrypt stored values. If the ciphertext no longer matches the in-memory
  // key — e.g. after the user clears browser storage or opens a new session —
  // the native Web Crypto API throws OperationError.
  //
  // We catch it and return null so the rest of the app treats it as "no token"
  // and redirects to login gracefully. We intentionally do NOT call clearAll()
  // here: clearing on every failed read would wipe a freshly saved token on the
  // very next read (e.g. the _AuthInterceptor reading the token right after
  // login), creating an infinite wipe/login cycle.
  static Future<String?> _readSafe(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      if (kDebugMode) debugPrint('[SecureStorage] read failed for $key: $e');
      return null;
    }
  }
}
