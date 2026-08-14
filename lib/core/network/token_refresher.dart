import 'package:dio/dio.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/storage/secure_storage.dart';

/// The three possible outcomes of trying to refresh an expired access token.
enum RefreshResultKind {
  /// A new token pair was issued — the caller should retry with [RefreshResult.accessToken].
  refreshed,

  /// The refresh token is missing, invalid or expired (server said 401) — the
  /// session has genuinely ended and the user must be logged out.
  sessionEnded,

  /// The refresh could not be completed right now (no network, timeout, or a 5xx
  /// server error). This is INCONCLUSIVE: the user must NOT be logged out.
  unavailable,
}

class RefreshResult {
  const RefreshResult._(this.kind, [this.accessToken]);

  final RefreshResultKind kind;
  final String? accessToken;

  factory RefreshResult.refreshed(String token) =>
      RefreshResult._(RefreshResultKind.refreshed, token);
  static const RefreshResult sessionEnded =
      RefreshResult._(RefreshResultKind.sessionEnded);
  static const RefreshResult unavailable =
      RefreshResult._(RefreshResultKind.unavailable);
}

/// Exchanges the stored refresh token for a fresh access token.
///
/// Single-flight: many requests can 401 at once (e.g. a screen firing several
/// calls), but they all share ONE in-flight `/auth/refresh` round-trip, so the
/// server is hit exactly once and every caller gets the same result.
///
/// It deliberately distinguishes a genuine end-of-session (server 401 on the
/// refresh token itself) from a transient inability to reach the server, so that
/// network/timeout/5xx problems never log the user out.
class TokenRefresher {
  TokenRefresher._();
  static final TokenRefresher instance = TokenRefresher._();

  Future<RefreshResult>? _inFlight;

  Future<RefreshResult> refresh() =>
      _inFlight ??= _run().whenComplete(() => _inFlight = null);

  Future<RefreshResult> _run() async {
    final refreshToken = await SecureStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      // Nothing to refresh with — the session is over.
      return RefreshResult.sessionEnded;
    }

    // A bare Dio (no interceptors) targeting the CURRENT base URL: avoids
    // recursion back into the auth interceptor and reuses whichever host the app
    // is already talking to (central API or the shop's own domain).
    final bare = Dio(
      BaseOptions(
        baseUrl: ApiClient.dio.options.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
        validateStatus: (_) => true,
      ),
    );

    try {
      final resp = await bare.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      final status = resp.statusCode ?? 0;

      if (status >= 200 && status < 300) {
        final data = resp.data['data'] as Map<String, dynamic>;
        final access = data['accessToken'] as String;
        await SecureStorage.saveTokens(
          accessToken: access,
          expiresAt: data['expiresAt'].toString(),
          refreshToken: data['refreshToken'] as String?,
          refreshExpiresAt: data['refreshExpiresAt']?.toString(),
        );
        return RefreshResult.refreshed(access);
      }

      // Only a 401 means the refresh token itself was rejected → real logout.
      if (status == 401) return RefreshResult.sessionEnded;

      // 5xx / 429 / anything else → server trouble, not an auth failure.
      return RefreshResult.unavailable;
    } on DioException {
      // No response at all (offline / timeout / connection refused) → inconclusive.
      return RefreshResult.unavailable;
    }
  }
}
