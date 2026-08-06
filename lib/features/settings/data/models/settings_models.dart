import 'package:flutter/material.dart';
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
    @Default('#C0446A') String primaryColor,
    @Default('#3C2A34') String secondaryColor,
    @Default('#D4A02A') String accentColor,
    @Default('#FBF7F4') String backgroundColor,
    @Default('#FFFFFF') String surfaceColor,
    @Default('#2A2024') String textColor,
    @Default(16.0) double borderRadius,
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

/// Fallback settings used before the backend responds (or on error).
const kDefaultSettings = StorefrontSettings(brandName: 'معرضي');

/// Parses a #RRGGBB hex string to a [Color]; returns [fallback] on failure.
Color hexToColor(String? hex, Color fallback) {
  if (hex == null || hex.isEmpty) return fallback;
  try {
    final cleaned = hex.replaceAll('#', '');
    final value = int.parse(
      cleaned.length == 6 ? 'FF$cleaned' : cleaned,
      radix: 16,
    );
    return Color(value);
  } catch (_) {
    return fallback;
  }
}
