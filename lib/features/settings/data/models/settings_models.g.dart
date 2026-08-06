// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialLinks _$SocialLinksFromJson(Map<String, dynamic> json) => _SocialLinks(
  instagram: json['instagram'] as String? ?? '',
  facebook: json['facebook'] as String? ?? '',
  whatsApp: json['whatsApp'] as String? ?? '',
);

Map<String, dynamic> _$SocialLinksToJson(_SocialLinks instance) =>
    <String, dynamic>{
      'instagram': instance.instagram,
      'facebook': instance.facebook,
      'whatsApp': instance.whatsApp,
    };

_StorefrontSettings _$StorefrontSettingsFromJson(Map<String, dynamic> json) =>
    _StorefrontSettings(
      brandName: json['brandName'] as String,
      logo: json['logo'] as String?,
      favicon: json['favicon'] as String?,
      primaryColor: json['primaryColor'] as String? ?? '#C0446A',
      secondaryColor: json['secondaryColor'] as String? ?? '#3C2A34',
      accentColor: json['accentColor'] as String? ?? '#D4A02A',
      backgroundColor: json['backgroundColor'] as String? ?? '#FBF7F4',
      surfaceColor: json['surfaceColor'] as String? ?? '#FFFFFF',
      textColor: json['textColor'] as String? ?? '#2A2024',
      borderRadius: (json['borderRadius'] as num?)?.toDouble() ?? 16.0,
      fontFamily: json['fontFamily'] as String? ?? 'Tajawal',
      heroSlides:
          (json['heroSlides'] as List<dynamic>?)
              ?.map((e) => HeroSlide.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      social: json['social'] == null
          ? const SocialLinks()
          : SocialLinks.fromJson(json['social'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StorefrontSettingsToJson(_StorefrontSettings instance) =>
    <String, dynamic>{
      'brandName': instance.brandName,
      'logo': instance.logo,
      'favicon': instance.favicon,
      'primaryColor': instance.primaryColor,
      'secondaryColor': instance.secondaryColor,
      'accentColor': instance.accentColor,
      'backgroundColor': instance.backgroundColor,
      'surfaceColor': instance.surfaceColor,
      'textColor': instance.textColor,
      'borderRadius': instance.borderRadius,
      'fontFamily': instance.fontFamily,
      'heroSlides': instance.heroSlides,
      'social': instance.social,
    };

_HeroSlide _$HeroSlideFromJson(Map<String, dynamic> json) => _HeroSlide(
  imageUrl: json['imageUrl'] as String,
  title: json['title'] as String?,
  subtitle: json['subtitle'] as String?,
  ctaText: json['ctaText'] as String?,
  ctaHref: json['ctaHref'] as String?,
);

Map<String, dynamic> _$HeroSlideToJson(_HeroSlide instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'ctaText': instance.ctaText,
      'ctaHref': instance.ctaHref,
    };
