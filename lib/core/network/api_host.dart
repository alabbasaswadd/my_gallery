import 'package:my_gallery/core/config/app_config.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controls which host the shared Dio talks to.
///
/// The app ships pointing at the central API ([AppConfig.apiBaseUrl]). At login
/// the backend returns the shop's own domain; the app then routes every
/// authenticated call to `https://<domain>/api/v1`, persisting it so the choice
/// survives restarts. Login/registration themselves always go to the central
/// API (the domain isn't known yet), and logout returns to it.
class ApiHost {
  ApiHost._();
  static final ApiHost instance = ApiHost._();

  static const _key = 'api_host_domain';

  String? _domain;

  /// The active shop domain (host only), or null when using the central API.
  String? get domain => _domain;

  String _baseUrlFor(String? domain) => (domain != null && domain.isNotEmpty)
      ? 'https://$domain${AppConfig.apiPrefix}'
      : AppConfig.apiBaseUrl;

  void _apply() => ApiClient.dio.options.baseUrl = _baseUrlFor(_domain);

  /// Loads any persisted shop domain and points Dio at it. Call once at startup
  /// before the first authenticated request.
  Future<void> restore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _domain = prefs.getString(_key);
    } catch (_) {
      _domain = null;
    }
    _apply();
  }

  /// Point Dio at the central API without clearing the persisted domain — used
  /// for the anonymous login/registration calls.
  void useDefault() {
    ApiClient.dio.options.baseUrl = AppConfig.apiBaseUrl;
  }

  /// Adopt the shop domain returned at login/registration and persist it. A null
  /// or empty domain falls back to the central API.
  Future<void> setFromDomain(String? domain) async {
    final value = domain?.trim();
    _domain = (value != null && value.isNotEmpty) ? value : null;
    _apply();
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_domain == null) {
        await prefs.remove(_key);
      } else {
        await prefs.setString(_key, _domain!);
      }
    } catch (_) {}
  }

  /// Clear the shop domain and return to the central API (on logout).
  Future<void> reset() => setFromDomain(null);
}
