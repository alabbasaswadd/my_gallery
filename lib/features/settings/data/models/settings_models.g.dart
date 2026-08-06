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
      heroSlides:
          (json['heroSlides'] as List<dynamic>?)
              ?.map((e) => HeroSlide.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      social: json['social'] == null
          ? const SocialLinks()
          : SocialLinks.fromJson(json['social'] as Map<String, dynamic>),
      website: json['website'] as String? ?? '',
    );

Map<String, dynamic> _$StorefrontSettingsToJson(_StorefrontSettings instance) =>
    <String, dynamic>{
      'brandName': instance.brandName,
      'logo': instance.logo,
      'favicon': instance.favicon,
      'heroSlides': instance.heroSlides,
      'social': instance.social,
      'website': instance.website,
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
