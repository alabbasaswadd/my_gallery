import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_gallery/core/config/app_config.dart';
import 'package:my_gallery/core/utils/store_links.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// A professional, printable QR card showing the store identity, an optional
/// product name, the QR code, and a small URL caption.
///
/// It deliberately renders on a fixed **light** palette (white background, dark
/// QR modules) regardless of the app's light/dark theme, so the exported PNG is
/// always high-contrast and scannable when printed or shared. The store's
/// [accentColor] (theme primary) is used only for tasteful accents.
class QrCard extends StatelessWidget {
  final String url;
  final String storeName;
  final String? logoUrl;
  final String? productName;
  final Color accentColor;

  const QrCard({
    super.key,
    required this.url,
    required this.storeName,
    required this.accentColor,
    this.logoUrl,
    this.productName,
  });

  @override
  Widget build(BuildContext context) {
    const cardColor = Colors.white;
    const titleColor = Color(0xFF1A1A1A);
    const captionColor = Color(0xFF6B6B6B);

    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.15),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Store identity ────────────────────────────────────────────
          _Logo(logoUrl: logoUrl, storeName: storeName, accent: accentColor),
          const SizedBox(height: 12),
          Text(
            storeName,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          if (productName != null && productName!.trim().isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              productName!,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: captionColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.25,
              ),
            ),
          ],
          const SizedBox(height: 20),

          // ── QR ────────────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEDEDED)),
            ),
            child: QrImageView(
              data: url,
              version: QrVersions.auto,
              size: 208,
              gapless: false,
              backgroundColor: Colors.white,
              eyeStyle: QrEyeStyle(
                eyeShape: QrEyeShape.circle,
                color: accentColor,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── URL caption ───────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.link_rounded, size: 14, color: accentColor),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  StoreLinks.pretty(url),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: captionColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final String? logoUrl;
  final String storeName;
  final Color accent;

  const _Logo({
    required this.logoUrl,
    required this.storeName,
    required this.accent,
  });

  String? get _fullUrl {
    final path = logoUrl;
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('http')) return path;
    return '${AppConfig.baseUrl}$path';
  }

  @override
  Widget build(BuildContext context) {
    final url = _fullUrl;
    const size = 64.0;
    final ring = accent.withValues(alpha: 0.18);

    Widget fallback() => Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accent.withValues(alpha: 0.12),
        border: Border.all(color: ring, width: 2),
      ),
      child: Text(
        storeName.isNotEmpty ? storeName.characters.first : '؟',
        style: TextStyle(
          color: accent,
          fontSize: 26,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

    if (url == null) return fallback();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ring, width: 2),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder: (_, __) => fallback(),
          errorWidget: (_, __, ___) => fallback(),
        ),
      ),
    );
  }
}
