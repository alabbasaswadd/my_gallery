class AppConfig {
  // static const String baseUrl = 'http://my-galary-api.runasp.net';
  static const String baseUrl =
      'https://alqaleatalsaghira-api.codetechsyria.com';
  static const String apiPrefix = '/api/v1';
  static String get apiBaseUrl => '$baseUrl$apiPrefix';

  // Shop ID for the customer-facing storefront.
  // Change to your shop's id (demo staff: shop 2).
  static const int shopId = 2;
}
