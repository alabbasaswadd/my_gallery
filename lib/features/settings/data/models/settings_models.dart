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
    @Default([]) List<HeroSlide> heroSlides,
    @Default(SocialLinks()) SocialLinks social,
    @Default('') String website,
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
