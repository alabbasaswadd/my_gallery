import 'package:my_gallery/features/settings/data/models/settings_models.dart';

/// Builds public, share-ready URLs (store + product) from the shop's
/// server-driven [StorefrontSettings.website].
///
/// Products have no slug in the backend contract, so the public product URL is
/// built from the numeric product id — `{website}/product/{id}` — matching the
/// "prefer slug if supported, otherwise use id" rule. If the owner has not set a
/// website yet, [storeUrl]/[productUrl] return `null` and the UI degrades
/// gracefully (prompting the owner to add a website in appearance settings).
class StoreLinks {
  StoreLinks._();

  /// Path segment for a single product on the public website.
  /// Kept as a single constant so it is trivial to change if the website route
  /// convention ever differs.
  static const String productPathSegment = 'product';

  /// Normalises the configured website into a clean origin without a trailing
  /// slash. Returns `null` when no usable website is configured.
  static String? baseUrl(StorefrontSettings settings) {
    var raw = settings.website.trim();
    if (raw.isEmpty) return null;
    // Tolerate an owner entering a bare domain (e.g. "example.com").
    if (!raw.startsWith('http://') && !raw.startsWith('https://')) {
      raw = 'https://$raw';
    }
    // Drop any trailing slashes so we never build `//product`.
    while (raw.endsWith('/')) {
      raw = raw.substring(0, raw.length - 1);
    }
    final uri = Uri.tryParse(raw);
    if (uri == null || uri.host.isEmpty) return null;
    // Strip any hash fragment the owner may have accidentally included in the
    // website URL (e.g. "example.com/#featured-products").
    var clean = uri.removeFragment().toString();
    while (clean.endsWith('/')) {
      clean = clean.substring(0, clean.length - 1);
    }
    return clean;
  }

  /// The public store/home URL, or `null` when no website is configured.
  static String? storeUrl(StorefrontSettings settings) => baseUrl(settings);

  /// The public product URL, or `null` when no website is configured.
  static String? productUrl(StorefrontSettings settings, int productId) {
    final base = baseUrl(settings);
    if (base == null) return null;
    return '$base/$productPathSegment/$productId';
  }

  /// A short, display-friendly form of a URL (host + path, no scheme) for
  /// captions such as the small line printed under a QR code.
  static String pretty(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return url;
    final path = uri.path == '/' ? '' : uri.path;
    return '${uri.host}$path';
  }
}
