import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _accessTokenKey = 'access_token';
  static const _expiresAtKey = 'expires_at';
  static const _refreshTokenKey = 'refresh_token';
  static const _refreshExpiresAtKey = 'refresh_expires_at';

  static Future<void> saveTokens({
    required String accessToken,
    required String expiresAt,
    String? refreshToken,
    String? refreshExpiresAt,
  }) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _expiresAtKey, value: expiresAt),
      // Refresh token is optional so a server that hasn't been upgraded yet still
      // logs the user in; when present it keeps the session alive past access expiry.
      if (refreshToken != null && refreshToken.isNotEmpty)
        _storage.write(key: _refreshTokenKey, value: refreshToken),
      if (refreshExpiresAt != null && refreshExpiresAt.isNotEmpty)
        _storage.write(key: _refreshExpiresAtKey, value: refreshExpiresAt),
    ]);
  }

  static Future<String?> getAccessToken() => _readSafe(_accessTokenKey);

  static Future<String?> getExpiresAt() => _readSafe(_expiresAtKey);

  static Future<String?> getRefreshToken() => _readSafe(_refreshTokenKey);

  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      if (kDebugMode) debugPrint('[SecureStorage] clearAll failed: $e');
    }
  }

  /// A session is considered present as long as we hold an access token OR a
  /// refresh token — the access token alone may be expired, but a valid refresh
  /// token can silently mint a new one, so the user must not be treated as logged
  /// out. Expiry is enforced by the server (401), never by the client clock.
  static Future<bool> hasValidSession() async {
    final token = await getAccessToken();
    if (token != null && token.isNotEmpty) return true;
    final refresh = await getRefreshToken();
    return refresh != null && refresh.isNotEmpty;
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
