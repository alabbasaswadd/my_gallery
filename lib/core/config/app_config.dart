class AppConfig {
  // static const String baseUrl =
  //     'https://alqaleatalsaghira-api.codetechsyria.com';
  static const String baseUrl = 'https://testing.syriangallery.shop';
  static const String apiPrefix = '/api/v1';
  static String get apiBaseUrl => '$baseUrl$apiPrefix';

  /// Resolved from --dart-define=SHOP_ID=<n> at build time.
  static const int shopId = int.fromEnvironment('SHOP_ID', defaultValue: 2);

  /// Platform base domain used to preview a new store's subdomain
  /// (`<label>.<storeBaseDomain>`) in the create-store wizard. Display-only —
  /// the backend authoritatively builds the address from its own `Tenancy:BaseDomain`.
  static const String storeBaseDomain = String.fromEnvironment(
    'STORE_BASE_DOMAIN',
    defaultValue: 'syriangallery.shop',
  );
}
