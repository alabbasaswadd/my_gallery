import 'package:flutter/painting.dart' show Color;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_models.freezed.dart';
part 'settings_models.g.dart';

@freezed
sealed class SocialLinks with _$SocialLinks {
  const factory SocialLinks({
    @Default('') String instagram,
    @Default('') String facebook,
    @Default('') String whatsApp,
  }) = _SocialLinks;

  factory SocialLinks.fromJson(Map<String, dynamic> json) =>
      _$SocialLinksFromJson(json);
}

@freezed
sealed class StorefrontSettings with _$StorefrontSettings {
  const factory StorefrontSettings({
    required String brandName,
    String? logo,
    String? favicon,
    @Default('') String website,
    // ── Visual identity palette (hex #RRGGBB strings on the wire) ───────────
    @Default('#C0446A') String primaryColor,
    @Default('#3C2A34') String secondaryColor,
    @Default('#D4A02A') String accentColor,
    @Default('#FBF7F4') String backgroundColor,
    @Default('#FFFFFF') String surfaceColor,
    @Default('#2A2024') String textColor,
    // Server sends a CSS string like "16px"; parsed to a double for rendering.
    @JsonKey(fromJson: radiusFromJson) @Default(16.0) double borderRadius,
    @Default('Tajawal') String fontFamily,
    @Default([]) List<HeroSlide> heroSlides,
    @Default(SocialLinks()) SocialLinks social,
  }) = _StorefrontSettings;

  factory StorefrontSettings.fromJson(Map<String, dynamic> json) =>
      _$StorefrontSettingsFromJson(json);
}

@freezed
sealed class HeroSlide with _$HeroSlide {
  const factory HeroSlide({
    required String imageUrl,
    String? title,
    String? subtitle,
    String? ctaText,
    String? ctaHref,
  }) = _HeroSlide;

  factory HeroSlide.fromJson(Map<String, dynamic> json) =>
      _$HeroSlideFromJson(json);
}

/// Parses a corner-radius value that may arrive as a CSS string (`"16px"`),
/// a plain number, or garbage. Always safe — falls back to `16.0`.
double radiusFromJson(dynamic value) {
  if (value is num) return value.toDouble();
  if (value is String) {
    final match = RegExp(r'[\d.]+').firstMatch(value);
    if (match != null) return double.tryParse(match.group(0)!) ?? 16.0;
  }
  return 16.0;
}

/// Parses a `#RRGGBB` (or `RRGGBB`) hex string into a [Color], returning
/// [fallback] on any malformed input. Assumes full opacity.
Color hexToColor(String hex, {Color fallback = const Color(0xFFC0446A)}) {
  var cleaned = hex.trim();
  if (cleaned.startsWith('#')) cleaned = cleaned.substring(1);
  if (cleaned.length == 6) {
    final value = int.tryParse(cleaned, radix: 16);
    if (value != null) return Color(0xFF000000 | value);
  }
  return fallback;
}

/// Fallback settings used before the backend responds (or on error).
const kDefaultSettings = StorefrontSettings(brandName: 'معرضي');
