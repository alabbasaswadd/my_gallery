// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'occasion_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OccasionListItem {

 int get id; String get name; String? get slug; String? get icon; String? get imageUrl; int get productCount; int get displayOrder; bool get isActive;
/// Create a copy of OccasionListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OccasionListItemCopyWith<OccasionListItem> get copyWith => _$OccasionListItemCopyWithImpl<OccasionListItem>(this as OccasionListItem, _$identity);

  /// Serializes this OccasionListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.productCount, productCount) || other.productCount == productCount)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon,imageUrl,productCount,displayOrder,isActive);

@override
String toString() {
  return 'OccasionListItem(id: $id, name: $name, slug: $slug, icon: $icon, imageUrl: $imageUrl, productCount: $productCount, displayOrder: $displayOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $OccasionListItemCopyWith<$Res>  {
  factory $OccasionListItemCopyWith(OccasionListItem value, $Res Function(OccasionListItem) _then) = _$OccasionListItemCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? slug, String? icon, String? imageUrl, int productCount, int displayOrder, bool isActive
});




}
/// @nodoc
class _$OccasionListItemCopyWithImpl<$Res>
    implements $OccasionListItemCopyWith<$Res> {
  _$OccasionListItemCopyWithImpl(this._self, this._then);

  final OccasionListItem _self;
  final $Res Function(OccasionListItem) _then;

/// Create a copy of OccasionListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = freezed,Object? icon = freezed,Object? imageUrl = freezed,Object? productCount = null,Object? displayOrder = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,productCount: null == productCount ? _self.productCount : productCount // ignore: cast_nullable_to_non_nullable
as int,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OccasionListItem].
extension OccasionListItemPatterns on OccasionListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OccasionListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OccasionListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OccasionListItem value)  $default,){
final _that = this;
switch (_that) {
case _OccasionListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OccasionListItem value)?  $default,){
final _that = this;
switch (_that) {
case _OccasionListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? slug,  String? icon,  String? imageUrl,  int productCount,  int displayOrder,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OccasionListItem() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.imageUrl,_that.productCount,_that.displayOrder,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? slug,  String? icon,  String? imageUrl,  int productCount,  int displayOrder,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _OccasionListItem():
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.imageUrl,_that.productCount,_that.displayOrder,_that.isActive);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? slug,  String? icon,  String? imageUrl,  int productCount,  int displayOrder,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _OccasionListItem() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.imageUrl,_that.productCount,_that.displayOrder,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OccasionListItem implements OccasionListItem {
  const _OccasionListItem({required this.id, required this.name, this.slug, this.icon, this.imageUrl, this.productCount = 0, this.displayOrder = 0, this.isActive = true});
  factory _OccasionListItem.fromJson(Map<String, dynamic> json) => _$OccasionListItemFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? slug;
@override final  String? icon;
@override final  String? imageUrl;
@override@JsonKey() final  int productCount;
@override@JsonKey() final  int displayOrder;
@override@JsonKey() final  bool isActive;

/// Create a copy of OccasionListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OccasionListItemCopyWith<_OccasionListItem> get copyWith => __$OccasionListItemCopyWithImpl<_OccasionListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OccasionListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OccasionListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.productCount, productCount) || other.productCount == productCount)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon,imageUrl,productCount,displayOrder,isActive);

@override
String toString() {
  return 'OccasionListItem(id: $id, name: $name, slug: $slug, icon: $icon, imageUrl: $imageUrl, productCount: $productCount, displayOrder: $displayOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$OccasionListItemCopyWith<$Res> implements $OccasionListItemCopyWith<$Res> {
  factory _$OccasionListItemCopyWith(_OccasionListItem value, $Res Function(_OccasionListItem) _then) = __$OccasionListItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? slug, String? icon, String? imageUrl, int productCount, int displayOrder, bool isActive
});




}
/// @nodoc
class __$OccasionListItemCopyWithImpl<$Res>
    implements _$OccasionListItemCopyWith<$Res> {
  __$OccasionListItemCopyWithImpl(this._self, this._then);

  final _OccasionListItem _self;
  final $Res Function(_OccasionListItem) _then;

/// Create a copy of OccasionListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = freezed,Object? icon = freezed,Object? imageUrl = freezed,Object? productCount = null,Object? displayOrder = null,Object? isActive = null,}) {
  return _then(_OccasionListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,productCount: null == productCount ? _self.productCount : productCount // ignore: cast_nullable_to_non_nullable
as int,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$OccasionDetail {

 int get id; String get name; String? get slug; String? get description; String? get icon; String? get imageUrl; int get displayOrder; bool get isActive;
/// Create a copy of OccasionDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OccasionDetailCopyWith<OccasionDetail> get copyWith => _$OccasionDetailCopyWithImpl<OccasionDetail>(this as OccasionDetail, _$identity);

  /// Serializes this OccasionDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,description,icon,imageUrl,displayOrder,isActive);

@override
String toString() {
  return 'OccasionDetail(id: $id, name: $name, slug: $slug, description: $description, icon: $icon, imageUrl: $imageUrl, displayOrder: $displayOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $OccasionDetailCopyWith<$Res>  {
  factory $OccasionDetailCopyWith(OccasionDetail value, $Res Function(OccasionDetail) _then) = _$OccasionDetailCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? slug, String? description, String? icon, String? imageUrl, int displayOrder, bool isActive
});




}
/// @nodoc
class _$OccasionDetailCopyWithImpl<$Res>
    implements $OccasionDetailCopyWith<$Res> {
  _$OccasionDetailCopyWithImpl(this._self, this._then);

  final OccasionDetail _self;
  final $Res Function(OccasionDetail) _then;

/// Create a copy of OccasionDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = freezed,Object? description = freezed,Object? icon = freezed,Object? imageUrl = freezed,Object? displayOrder = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OccasionDetail].
extension OccasionDetailPatterns on OccasionDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OccasionDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OccasionDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OccasionDetail value)  $default,){
final _that = this;
switch (_that) {
case _OccasionDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OccasionDetail value)?  $default,){
final _that = this;
switch (_that) {
case _OccasionDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? slug,  String? description,  String? icon,  String? imageUrl,  int displayOrder,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OccasionDetail() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.description,_that.icon,_that.imageUrl,_that.displayOrder,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? slug,  String? description,  String? icon,  String? imageUrl,  int displayOrder,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _OccasionDetail():
return $default(_that.id,_that.name,_that.slug,_that.description,_that.icon,_that.imageUrl,_that.displayOrder,_that.isActive);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? slug,  String? description,  String? icon,  String? imageUrl,  int displayOrder,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _OccasionDetail() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.description,_that.icon,_that.imageUrl,_that.displayOrder,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OccasionDetail implements OccasionDetail {
  const _OccasionDetail({required this.id, required this.name, this.slug, this.description, this.icon, this.imageUrl, this.displayOrder = 0, this.isActive = true});
  factory _OccasionDetail.fromJson(Map<String, dynamic> json) => _$OccasionDetailFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? slug;
@override final  String? description;
@override final  String? icon;
@override final  String? imageUrl;
@override@JsonKey() final  int displayOrder;
@override@JsonKey() final  bool isActive;

/// Create a copy of OccasionDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OccasionDetailCopyWith<_OccasionDetail> get copyWith => __$OccasionDetailCopyWithImpl<_OccasionDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OccasionDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OccasionDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,description,icon,imageUrl,displayOrder,isActive);

@override
String toString() {
  return 'OccasionDetail(id: $id, name: $name, slug: $slug, description: $description, icon: $icon, imageUrl: $imageUrl, displayOrder: $displayOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$OccasionDetailCopyWith<$Res> implements $OccasionDetailCopyWith<$Res> {
  factory _$OccasionDetailCopyWith(_OccasionDetail value, $Res Function(_OccasionDetail) _then) = __$OccasionDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? slug, String? description, String? icon, String? imageUrl, int displayOrder, bool isActive
});




}
/// @nodoc
class __$OccasionDetailCopyWithImpl<$Res>
    implements _$OccasionDetailCopyWith<$Res> {
  __$OccasionDetailCopyWithImpl(this._self, this._then);

  final _OccasionDetail _self;
  final $Res Function(_OccasionDetail) _then;

/// Create a copy of OccasionDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = freezed,Object? description = freezed,Object? icon = freezed,Object? imageUrl = freezed,Object? displayOrder = null,Object? isActive = null,}) {
  return _then(_OccasionDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$OccasionRequest {

 String get name; String? get slug; String? get description; String? get icon; int get displayOrder; bool get isActive;
/// Create a copy of OccasionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OccasionRequestCopyWith<OccasionRequest> get copyWith => _$OccasionRequestCopyWithImpl<OccasionRequest>(this as OccasionRequest, _$identity);

  /// Serializes this OccasionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,slug,description,icon,displayOrder,isActive);

@override
String toString() {
  return 'OccasionRequest(name: $name, slug: $slug, description: $description, icon: $icon, displayOrder: $displayOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $OccasionRequestCopyWith<$Res>  {
  factory $OccasionRequestCopyWith(OccasionRequest value, $Res Function(OccasionRequest) _then) = _$OccasionRequestCopyWithImpl;
@useResult
$Res call({
 String name, String? slug, String? description, String? icon, int displayOrder, bool isActive
});




}
/// @nodoc
class _$OccasionRequestCopyWithImpl<$Res>
    implements $OccasionRequestCopyWith<$Res> {
  _$OccasionRequestCopyWithImpl(this._self, this._then);

  final OccasionRequest _self;
  final $Res Function(OccasionRequest) _then;

/// Create a copy of OccasionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? slug = freezed,Object? description = freezed,Object? icon = freezed,Object? displayOrder = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OccasionRequest].
extension OccasionRequestPatterns on OccasionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OccasionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OccasionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OccasionRequest value)  $default,){
final _that = this;
switch (_that) {
case _OccasionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OccasionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _OccasionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? slug,  String? description,  String? icon,  int displayOrder,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OccasionRequest() when $default != null:
return $default(_that.name,_that.slug,_that.description,_that.icon,_that.displayOrder,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? slug,  String? description,  String? icon,  int displayOrder,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _OccasionRequest():
return $default(_that.name,_that.slug,_that.description,_that.icon,_that.displayOrder,_that.isActive);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? slug,  String? description,  String? icon,  int displayOrder,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _OccasionRequest() when $default != null:
return $default(_that.name,_that.slug,_that.description,_that.icon,_that.displayOrder,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OccasionRequest implements OccasionRequest {
  const _OccasionRequest({required this.name, this.slug, this.description, this.icon, this.displayOrder = 0, this.isActive = true});
  factory _OccasionRequest.fromJson(Map<String, dynamic> json) => _$OccasionRequestFromJson(json);

@override final  String name;
@override final  String? slug;
@override final  String? description;
@override final  String? icon;
@override@JsonKey() final  int displayOrder;
@override@JsonKey() final  bool isActive;

/// Create a copy of OccasionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OccasionRequestCopyWith<_OccasionRequest> get copyWith => __$OccasionRequestCopyWithImpl<_OccasionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OccasionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OccasionRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,slug,description,icon,displayOrder,isActive);

@override
String toString() {
  return 'OccasionRequest(name: $name, slug: $slug, description: $description, icon: $icon, displayOrder: $displayOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$OccasionRequestCopyWith<$Res> implements $OccasionRequestCopyWith<$Res> {
  factory _$OccasionRequestCopyWith(_OccasionRequest value, $Res Function(_OccasionRequest) _then) = __$OccasionRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String? slug, String? description, String? icon, int displayOrder, bool isActive
});




}
/// @nodoc
class __$OccasionRequestCopyWithImpl<$Res>
    implements _$OccasionRequestCopyWith<$Res> {
  __$OccasionRequestCopyWithImpl(this._self, this._then);

  final _OccasionRequest _self;
  final $Res Function(_OccasionRequest) _then;

/// Create a copy of OccasionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? slug = freezed,Object? description = freezed,Object? icon = freezed,Object? displayOrder = null,Object? isActive = null,}) {
  return _then(_OccasionRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
