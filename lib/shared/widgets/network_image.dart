import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gallery/core/config/app_config.dart';
import 'package:shimmer/shimmer.dart';

/// Resolves a stored image reference to a fully-qualified URL, mirroring the
/// backend storage layout. Single source of truth — use this everywhere instead
/// of re-deriving the base URL locally.
///
/// - `http…` / `data:` → used as-is (legacy full URL, external image, inline URI).
/// - `/…` absolute path → served straight from the host (legacy `/uploads/…`).
/// - relative storage key (`uploads/shop-x/…`) → the `/api/v1/images/{key}` endpoint.
///
/// Returns null for a null/empty reference.
String? resolveImageUrl(String? path) {
  if (path == null || path.isEmpty) return null;
  if (path.startsWith('http') || path.startsWith('data:')) return path;
  if (path.startsWith('/')) return '${AppConfig.baseUrl}$path';
  return '${AppConfig.apiBaseUrl}/images/$path';
}

class AppNetworkImage extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  /// Shown when the URL is null/empty or the image fails to load.
  /// Defaults to [_placeholder] when omitted.
  final Widget? errorWidget;

  const AppNetworkImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorWidget,
  });

  String? get _fullUrl {
    final resolved = resolveImageUrl(imagePath);
    if (kDebugMode) {
      debugPrint('[AppNetworkImage] "$imagePath" → "$resolved"');
    }
    return resolved;
  }

  @override
  Widget build(BuildContext context) {
    final url = _fullUrl;
    if (url == null) return _fallback();

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: url.toLowerCase().endsWith('.svg')
          ? _buildSvg(url)
          : _buildRaster(url),
    );
  }

  Widget _buildSvg(String url) {
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: (_) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(color: Colors.white, width: width, height: height),
      ),
    );
  }

  Widget _buildRaster(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(color: Colors.white, width: width, height: height),
      ),
      errorWidget: (_, url, error) {
        if (kDebugMode) {
          debugPrint('[AppNetworkImage] failed to load "$url": $error');
        }
        return _fallback();
      },
    );
  }

  Widget _fallback() {
    if (errorWidget != null) {
      return SizedBox(
        width: width,
        height: height,
        child: Center(child: errorWidget),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFFF0E8EC),
      child: const Icon(
        Icons.image_outlined,
        color: Color(0xFFC0446A),
        size: 32,
      ),
    );
  }
}
