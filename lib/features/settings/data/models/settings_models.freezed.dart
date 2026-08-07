// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialLinks {

 String get instagram; String get facebook; String get whatsApp;
/// Create a copy of SocialLinks
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLinksCopyWith<SocialLinks> get copyWith => _$SocialLinksCopyWithImpl<SocialLinks>(this as SocialLinks, _$identity);

  /// Serializes this SocialLinks to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLinks&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.whatsApp, whatsApp) || other.whatsApp == whatsApp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,instagram,facebook,whatsApp);

@override
String toString() {
  return 'SocialLinks(instagram: $instagram, facebook: $facebook, whatsApp: $whatsApp)';
}


}

/// @nodoc
abstract mixin class $SocialLinksCopyWith<$Res>  {
  factory $SocialLinksCopyWith(SocialLinks value, $Res Function(SocialLinks) _then) = _$SocialLinksCopyWithImpl;
@useResult
$Res call({
 String instagram, String facebook, String whatsApp
});




}
/// @nodoc
class _$SocialLinksCopyWithImpl<$Res>
    implements $SocialLinksCopyWith<$Res> {
  _$SocialLinksCopyWithImpl(this._self, this._then);

  final SocialLinks _self;
  final $Res Function(SocialLinks) _then;

/// Create a copy of SocialLinks
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? instagram = null,Object? facebook = null,Object? whatsApp = null,}) {
  return _then(_self.copyWith(
instagram: null == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String,facebook: null == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String,whatsApp: null == whatsApp ? _self.whatsApp : whatsApp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialLinks].
extension SocialLinksPatterns on SocialLinks {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialLinks value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialLinks() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialLinks value)  $default,){
final _that = this;
switch (_that) {
case _SocialLinks():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialLinks value)?  $default,){
final _that = this;
switch (_that) {
case _SocialLinks() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String instagram,  String facebook,  String whatsApp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialLinks() when $default != null:
return $default(_that.instagram,_that.facebook,_that.whatsApp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String instagram,  String facebook,  String whatsApp)  $default,) {final _that = this;
switch (_that) {
case _SocialLinks():
return $default(_that.instagram,_that.facebook,_that.whatsApp);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String instagram,  String facebook,  String whatsApp)?  $default,) {final _that = this;
switch (_that) {
case _SocialLinks() when $default != null:
return $default(_that.instagram,_that.facebook,_that.whatsApp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialLinks implements SocialLinks {
  const _SocialLinks({this.instagram = '', this.facebook = '', this.whatsApp = ''});
  factory _SocialLinks.fromJson(Map<String, dynamic> json) => _$SocialLinksFromJson(json);

@override@JsonKey() final  String instagram;
@override@JsonKey() final  String facebook;
@override@JsonKey() final  String whatsApp;

/// Create a copy of SocialLinks
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialLinksCopyWith<_SocialLinks> get copyWith => __$SocialLinksCopyWithImpl<_SocialLinks>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialLinksToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialLinks&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.whatsApp, whatsApp) || other.whatsApp == whatsApp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,instagram,facebook,whatsApp);

@override
String toString() {
  return 'SocialLinks(instagram: $instagram, facebook: $facebook, whatsApp: $whatsApp)';
}


}

/// @nodoc
abstract mixin class _$SocialLinksCopyWith<$Res> implements $SocialLinksCopyWith<$Res> {
  factory _$SocialLinksCopyWith(_SocialLinks value, $Res Function(_SocialLinks) _then) = __$SocialLinksCopyWithImpl;
@override @useResult
$Res call({
 String instagram, String facebook, String whatsApp
});




}
/// @nodoc
class __$SocialLinksCopyWithImpl<$Res>
    implements _$SocialLinksCopyWith<$Res> {
  __$SocialLinksCopyWithImpl(this._self, this._then);

  final _SocialLinks _self;
  final $Res Function(_SocialLinks) _then;

/// Create a copy of SocialLinks
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? instagram = null,Object? facebook = null,Object? whatsApp = null,}) {
  return _then(_SocialLinks(
instagram: null == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String,facebook: null == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String,whatsApp: null == whatsApp ? _self.whatsApp : whatsApp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StorefrontSettings {

 String get brandName; String? get logo; String? get favicon; String get website;// ── Visual identity palette (hex #RRGGBB strings on the wire) ───────────
 String get primaryColor; String get secondaryColor; String get accentColor; String get backgroundColor; String get surfaceColor; String get textColor;// Server sends a CSS string like "16px"; parsed to a double for rendering.
@JsonKey(fromJson: radiusFromJson) double get borderRadius; String get fontFamily; List<HeroSlide> get heroSlides; SocialLinks get social;
/// Create a copy of StorefrontSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorefrontSettingsCopyWith<StorefrontSettings> get copyWith => _$StorefrontSettingsCopyWithImpl<StorefrontSettings>(this as StorefrontSettings, _$identity);

  /// Serializes this StorefrontSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontSettings&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.favicon, favicon) || other.favicon == favicon)&&(identical(other.website, website) || other.website == website)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.surfaceColor, surfaceColor) || other.surfaceColor == surfaceColor)&&(identical(other.textColor, textColor) || other.textColor == textColor)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&const DeepCollectionEquality().equals(other.heroSlides, heroSlides)&&(identical(other.social, social) || other.social == social));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,brandName,logo,favicon,website,primaryColor,secondaryColor,accentColor,backgroundColor,surfaceColor,textColor,borderRadius,fontFamily,const DeepCollectionEquality().hash(heroSlides),social);

@override
String toString() {
  return 'StorefrontSettings(brandName: $brandName, logo: $logo, favicon: $favicon, website: $website, primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, backgroundColor: $backgroundColor, surfaceColor: $surfaceColor, textColor: $textColor, borderRadius: $borderRadius, fontFamily: $fontFamily, heroSlides: $heroSlides, social: $social)';
}


}

/// @nodoc
abstract mixin class $StorefrontSettingsCopyWith<$Res>  {
  factory $StorefrontSettingsCopyWith(StorefrontSettings value, $Res Function(StorefrontSettings) _then) = _$StorefrontSettingsCopyWithImpl;
@useResult
$Res call({
 String brandName, String? logo, String? favicon, String website, String primaryColor, String secondaryColor, String accentColor, String backgroundColor, String surfaceColor, String textColor,@JsonKey(fromJson: radiusFromJson) double borderRadius, String fontFamily, List<HeroSlide> heroSlides, SocialLinks social
});


$SocialLinksCopyWith<$Res> get social;

}
/// @nodoc
class _$StorefrontSettingsCopyWithImpl<$Res>
    implements $StorefrontSettingsCopyWith<$Res> {
  _$StorefrontSettingsCopyWithImpl(this._self, this._then);

  final StorefrontSettings _self;
  final $Res Function(StorefrontSettings) _then;

/// Create a copy of StorefrontSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? brandName = null,Object? logo = freezed,Object? favicon = freezed,Object? website = null,Object? primaryColor = null,Object? secondaryColor = null,Object? accentColor = null,Object? backgroundColor = null,Object? surfaceColor = null,Object? textColor = null,Object? borderRadius = null,Object? fontFamily = null,Object? heroSlides = null,Object? social = null,}) {
  return _then(_self.copyWith(
brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,favicon: freezed == favicon ? _self.favicon : favicon // ignore: cast_nullable_to_non_nullable
as String?,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String,secondaryColor: null == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String,accentColor: null == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,surfaceColor: null == surfaceColor ? _self.surfaceColor : surfaceColor // ignore: cast_nullable_to_non_nullable
as String,textColor: null == textColor ? _self.textColor : textColor // ignore: cast_nullable_to_non_nullable
as String,borderRadius: null == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as double,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,heroSlides: null == heroSlides ? _self.heroSlides : heroSlides // ignore: cast_nullable_to_non_nullable
as List<HeroSlide>,social: null == social ? _self.social : social // ignore: cast_nullable_to_non_nullable
as SocialLinks,
  ));
}
/// Create a copy of StorefrontSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialLinksCopyWith<$Res> get social {
  
  return $SocialLinksCopyWith<$Res>(_self.social, (value) {
    return _then(_self.copyWith(social: value));
  });
}
}


/// Adds pattern-matching-related methods to [StorefrontSettings].
extension StorefrontSettingsPatterns on StorefrontSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorefrontSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorefrontSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorefrontSettings value)  $default,){
final _that = this;
switch (_that) {
case _StorefrontSettings():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorefrontSettings value)?  $default,){
final _that = this;
switch (_that) {
case _StorefrontSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String brandName,  String? logo,  String? favicon,  String website,  String primaryColor,  String secondaryColor,  String accentColor,  String backgroundColor,  String surfaceColor,  String textColor, @JsonKey(fromJson: radiusFromJson)  double borderRadius,  String fontFamily,  List<HeroSlide> heroSlides,  SocialLinks social)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorefrontSettings() when $default != null:
return $default(_that.brandName,_that.logo,_that.favicon,_that.website,_that.primaryColor,_that.secondaryColor,_that.accentColor,_that.backgroundColor,_that.surfaceColor,_that.textColor,_that.borderRadius,_that.fontFamily,_that.heroSlides,_that.social);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String brandName,  String? logo,  String? favicon,  String website,  String primaryColor,  String secondaryColor,  String accentColor,  String backgroundColor,  String surfaceColor,  String textColor, @JsonKey(fromJson: radiusFromJson)  double borderRadius,  String fontFamily,  List<HeroSlide> heroSlides,  SocialLinks social)  $default,) {final _that = this;
switch (_that) {
case _StorefrontSettings():
return $default(_that.brandName,_that.logo,_that.favicon,_that.website,_that.primaryColor,_that.secondaryColor,_that.accentColor,_that.backgroundColor,_that.surfaceColor,_that.textColor,_that.borderRadius,_that.fontFamily,_that.heroSlides,_that.social);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String brandName,  String? logo,  String? favicon,  String website,  String primaryColor,  String secondaryColor,  String accentColor,  String backgroundColor,  String surfaceColor,  String textColor, @JsonKey(fromJson: radiusFromJson)  double borderRadius,  String fontFamily,  List<HeroSlide> heroSlides,  SocialLinks social)?  $default,) {final _that = this;
switch (_that) {
case _StorefrontSettings() when $default != null:
return $default(_that.brandName,_that.logo,_that.favicon,_that.website,_that.primaryColor,_that.secondaryColor,_that.accentColor,_that.backgroundColor,_that.surfaceColor,_that.textColor,_that.borderRadius,_that.fontFamily,_that.heroSlides,_that.social);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorefrontSettings implements StorefrontSettings {
  const _StorefrontSettings({required this.brandName, this.logo, this.favicon, this.website = '', this.primaryColor = '#C0446A', this.secondaryColor = '#3C2A34', this.accentColor = '#D4A02A', this.backgroundColor = '#FBF7F4', this.surfaceColor = '#FFFFFF', this.textColor = '#2A2024', @JsonKey(fromJson: radiusFromJson) this.borderRadius = 16.0, this.fontFamily = 'Tajawal', final  List<HeroSlide> heroSlides = const [], this.social = const SocialLinks()}): _heroSlides = heroSlides;
  factory _StorefrontSettings.fromJson(Map<String, dynamic> json) => _$StorefrontSettingsFromJson(json);

@override final  String brandName;
@override final  String? logo;
@override final  String? favicon;
@override@JsonKey() final  String website;
// ── Visual identity palette (hex #RRGGBB strings on the wire) ───────────
@override@JsonKey() final  String primaryColor;
@override@JsonKey() final  String secondaryColor;
@override@JsonKey() final  String accentColor;
@override@JsonKey() final  String backgroundColor;
@override@JsonKey() final  String surfaceColor;
@override@JsonKey() final  String textColor;
// Server sends a CSS string like "16px"; parsed to a double for rendering.
@override@JsonKey(fromJson: radiusFromJson) final  double borderRadius;
@override@JsonKey() final  String fontFamily;
 final  List<HeroSlide> _heroSlides;
@override@JsonKey() List<HeroSlide> get heroSlides {
  if (_heroSlides is EqualUnmodifiableListView) return _heroSlides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_heroSlides);
}

@override@JsonKey() final  SocialLinks social;

/// Create a copy of StorefrontSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorefrontSettingsCopyWith<_StorefrontSettings> get copyWith => __$StorefrontSettingsCopyWithImpl<_StorefrontSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorefrontSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorefrontSettings&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.favicon, favicon) || other.favicon == favicon)&&(identical(other.website, website) || other.website == website)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.secondaryColor, secondaryColor) || other.secondaryColor == secondaryColor)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.surfaceColor, surfaceColor) || other.surfaceColor == surfaceColor)&&(identical(other.textColor, textColor) || other.textColor == textColor)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&const DeepCollectionEquality().equals(other._heroSlides, _heroSlides)&&(identical(other.social, social) || other.social == social));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,brandName,logo,favicon,website,primaryColor,secondaryColor,accentColor,backgroundColor,surfaceColor,textColor,borderRadius,fontFamily,const DeepCollectionEquality().hash(_heroSlides),social);

@override
String toString() {
  return 'StorefrontSettings(brandName: $brandName, logo: $logo, favicon: $favicon, website: $website, primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, backgroundColor: $backgroundColor, surfaceColor: $surfaceColor, textColor: $textColor, borderRadius: $borderRadius, fontFamily: $fontFamily, heroSlides: $heroSlides, social: $social)';
}


}

/// @nodoc
abstract mixin class _$StorefrontSettingsCopyWith<$Res> implements $StorefrontSettingsCopyWith<$Res> {
  factory _$StorefrontSettingsCopyWith(_StorefrontSettings value, $Res Function(_StorefrontSettings) _then) = __$StorefrontSettingsCopyWithImpl;
@override @useResult
$Res call({
 String brandName, String? logo, String? favicon, String website, String primaryColor, String secondaryColor, String accentColor, String backgroundColor, String surfaceColor, String textColor,@JsonKey(fromJson: radiusFromJson) double borderRadius, String fontFamily, List<HeroSlide> heroSlides, SocialLinks social
});


@override $SocialLinksCopyWith<$Res> get social;

}
/// @nodoc
class __$StorefrontSettingsCopyWithImpl<$Res>
    implements _$StorefrontSettingsCopyWith<$Res> {
  __$StorefrontSettingsCopyWithImpl(this._self, this._then);

  final _StorefrontSettings _self;
  final $Res Function(_StorefrontSettings) _then;

/// Create a copy of StorefrontSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? brandName = null,Object? logo = freezed,Object? favicon = freezed,Object? website = null,Object? primaryColor = null,Object? secondaryColor = null,Object? accentColor = null,Object? backgroundColor = null,Object? surfaceColor = null,Object? textColor = null,Object? borderRadius = null,Object? fontFamily = null,Object? heroSlides = null,Object? social = null,}) {
  return _then(_StorefrontSettings(
brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,favicon: freezed == favicon ? _self.favicon : favicon // ignore: cast_nullable_to_non_nullable
as String?,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String,secondaryColor: null == secondaryColor ? _self.secondaryColor : secondaryColor // ignore: cast_nullable_to_non_nullable
as String,accentColor: null == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as String,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,surfaceColor: null == surfaceColor ? _self.surfaceColor : surfaceColor // ignore: cast_nullable_to_non_nullable
as String,textColor: null == textColor ? _self.textColor : textColor // ignore: cast_nullable_to_non_nullable
as String,borderRadius: null == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as double,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,heroSlides: null == heroSlides ? _self._heroSlides : heroSlides // ignore: cast_nullable_to_non_nullable
as List<HeroSlide>,social: null == social ? _self.social : social // ignore: cast_nullable_to_non_nullable
as SocialLinks,
  ));
}

/// Create a copy of StorefrontSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialLinksCopyWith<$Res> get social {
  
  return $SocialLinksCopyWith<$Res>(_self.social, (value) {
    return _then(_self.copyWith(social: value));
  });
}
}


/// @nodoc
mixin _$HeroSlide {

 String get imageUrl; String? get title; String? get subtitle; String? get ctaText; String? get ctaHref;
/// Create a copy of HeroSlide
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeroSlideCopyWith<HeroSlide> get copyWith => _$HeroSlideCopyWithImpl<HeroSlide>(this as HeroSlide, _$identity);

  /// Serializes this HeroSlide to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeroSlide&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.ctaText, ctaText) || other.ctaText == ctaText)&&(identical(other.ctaHref, ctaHref) || other.ctaHref == ctaHref));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,title,subtitle,ctaText,ctaHref);

@override
String toString() {
  return 'HeroSlide(imageUrl: $imageUrl, title: $title, subtitle: $subtitle, ctaText: $ctaText, ctaHref: $ctaHref)';
}


}

/// @nodoc
abstract mixin class $HeroSlideCopyWith<$Res>  {
  factory $HeroSlideCopyWith(HeroSlide value, $Res Function(HeroSlide) _then) = _$HeroSlideCopyWithImpl;
@useResult
$Res call({
 String imageUrl, String? title, String? subtitle, String? ctaText, String? ctaHref
});




}
/// @nodoc
class _$HeroSlideCopyWithImpl<$Res>
    implements $HeroSlideCopyWith<$Res> {
  _$HeroSlideCopyWithImpl(this._self, this._then);

  final HeroSlide _self;
  final $Res Function(HeroSlide) _then;

/// Create a copy of HeroSlide
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,Object? title = freezed,Object? subtitle = freezed,Object? ctaText = freezed,Object? ctaHref = freezed,}) {
  return _then(_self.copyWith(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,ctaText: freezed == ctaText ? _self.ctaText : ctaText // ignore: cast_nullable_to_non_nullable
as String?,ctaHref: freezed == ctaHref ? _self.ctaHref : ctaHref // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HeroSlide].
extension HeroSlidePatterns on HeroSlide {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeroSlide value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeroSlide() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeroSlide value)  $default,){
final _that = this;
switch (_that) {
case _HeroSlide():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeroSlide value)?  $default,){
final _that = this;
switch (_that) {
case _HeroSlide() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String imageUrl,  String? title,  String? subtitle,  String? ctaText,  String? ctaHref)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeroSlide() when $default != null:
return $default(_that.imageUrl,_that.title,_that.subtitle,_that.ctaText,_that.ctaHref);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String imageUrl,  String? title,  String? subtitle,  String? ctaText,  String? ctaHref)  $default,) {final _that = this;
switch (_that) {
case _HeroSlide():
return $default(_that.imageUrl,_that.title,_that.subtitle,_that.ctaText,_that.ctaHref);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String imageUrl,  String? title,  String? subtitle,  String? ctaText,  String? ctaHref)?  $default,) {final _that = this;
switch (_that) {
case _HeroSlide() when $default != null:
return $default(_that.imageUrl,_that.title,_that.subtitle,_that.ctaText,_that.ctaHref);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeroSlide implements HeroSlide {
  const _HeroSlide({required this.imageUrl, this.title, this.subtitle, this.ctaText, this.ctaHref});
  factory _HeroSlide.fromJson(Map<String, dynamic> json) => _$HeroSlideFromJson(json);

@override final  String imageUrl;
@override final  String? title;
@override final  String? subtitle;
@override final  String? ctaText;
@override final  String? ctaHref;

/// Create a copy of HeroSlide
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeroSlideCopyWith<_HeroSlide> get copyWith => __$HeroSlideCopyWithImpl<_HeroSlide>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeroSlideToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeroSlide&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.ctaText, ctaText) || other.ctaText == ctaText)&&(identical(other.ctaHref, ctaHref) || other.ctaHref == ctaHref));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,title,subtitle,ctaText,ctaHref);

@override
String toString() {
  return 'HeroSlide(imageUrl: $imageUrl, title: $title, subtitle: $subtitle, ctaText: $ctaText, ctaHref: $ctaHref)';
}


}

/// @nodoc
abstract mixin class _$HeroSlideCopyWith<$Res> implements $HeroSlideCopyWith<$Res> {
  factory _$HeroSlideCopyWith(_HeroSlide value, $Res Function(_HeroSlide) _then) = __$HeroSlideCopyWithImpl;
@override @useResult
$Res call({
 String imageUrl, String? title, String? subtitle, String? ctaText, String? ctaHref
});




}
/// @nodoc
class __$HeroSlideCopyWithImpl<$Res>
    implements _$HeroSlideCopyWith<$Res> {
  __$HeroSlideCopyWithImpl(this._self, this._then);

  final _HeroSlide _self;
  final $Res Function(_HeroSlide) _then;

/// Create a copy of HeroSlide
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,Object? title = freezed,Object? subtitle = freezed,Object? ctaText = freezed,Object? ctaHref = freezed,}) {
  return _then(_HeroSlide(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,ctaText: freezed == ctaText ? _self.ctaText : ctaText // ignore: cast_nullable_to_non_nullable
as String?,ctaHref: freezed == ctaHref ? _self.ctaHref : ctaHref // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
