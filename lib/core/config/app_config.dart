class AppConfig {
  static const String baseUrl =
      'https://alqaleatalsaghira-api.codetechsyria.com';
  static const String apiPrefix = '/api/v1';
  static String get apiBaseUrl => '$baseUrl$apiPrefix';

  /// Resolved from --dart-define=SHOP_ID=<n> at build time.
  static const int shopId = int.fromEnvironment('SHOP_ID', defaultValue: 2);
}
