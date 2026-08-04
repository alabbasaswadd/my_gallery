// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryListItem {

 int get id; String get name; String? get parentName; String? get imageUrl; int get productCount; int get displayOrder; bool get isActive;
/// Create a copy of CategoryListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryListItemCopyWith<CategoryListItem> get copyWith => _$CategoryListItemCopyWithImpl<CategoryListItem>(this as CategoryListItem, _$identity);

  /// Serializes this CategoryListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.parentName, parentName) || other.parentName == parentName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.productCount, productCount) || other.productCount == productCount)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,parentName,imageUrl,productCount,displayOrder,isActive);

@override
String toString() {
  return 'CategoryListItem(id: $id, name: $name, parentName: $parentName, imageUrl: $imageUrl, productCount: $productCount, displayOrder: $displayOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $CategoryListItemCopyWith<$Res>  {
  factory $CategoryListItemCopyWith(CategoryListItem value, $Res Function(CategoryListItem) _then) = _$CategoryListItemCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? parentName, String? imageUrl, int productCount, int displayOrder, bool isActive
});




}
/// @nodoc
class _$CategoryListItemCopyWithImpl<$Res>
    implements $CategoryListItemCopyWith<$Res> {
  _$CategoryListItemCopyWithImpl(this._self, this._then);

  final CategoryListItem _self;
  final $Res Function(CategoryListItem) _then;

/// Create a copy of CategoryListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? parentName = freezed,Object? imageUrl = freezed,Object? productCount = null,Object? displayOrder = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,parentName: freezed == parentName ? _self.parentName : parentName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,productCount: null == productCount ? _self.productCount : productCount // ignore: cast_nullable_to_non_nullable
as int,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryListItem].
extension CategoryListItemPatterns on CategoryListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryListItem value)  $default,){
final _that = this;
switch (_that) {
case _CategoryListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryListItem value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? parentName,  String? imageUrl,  int productCount,  int displayOrder,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryListItem() when $default != null:
return $default(_that.id,_that.name,_that.parentName,_that.imageUrl,_that.productCount,_that.displayOrder,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? parentName,  String? imageUrl,  int productCount,  int displayOrder,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _CategoryListItem():
return $default(_that.id,_that.name,_that.parentName,_that.imageUrl,_that.productCount,_that.displayOrder,_that.isActive);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? parentName,  String? imageUrl,  int productCount,  int displayOrder,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _CategoryListItem() when $default != null:
return $default(_that.id,_that.name,_that.parentName,_that.imageUrl,_that.productCount,_that.displayOrder,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryListItem implements CategoryListItem {
  const _CategoryListItem({required this.id, required this.name, this.parentName, this.imageUrl, this.productCount = 0, this.displayOrder = 0, this.isActive = true});
  factory _CategoryListItem.fromJson(Map<String, dynamic> json) => _$CategoryListItemFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? parentName;
@override final  String? imageUrl;
@override@JsonKey() final  int productCount;
@override@JsonKey() final  int displayOrder;
@override@JsonKey() final  bool isActive;

/// Create a copy of CategoryListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryListItemCopyWith<_CategoryListItem> get copyWith => __$CategoryListItemCopyWithImpl<_CategoryListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.parentName, parentName) || other.parentName == parentName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.productCount, productCount) || other.productCount == productCount)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,parentName,imageUrl,productCount,displayOrder,isActive);

@override
String toString() {
  return 'CategoryListItem(id: $id, name: $name, parentName: $parentName, imageUrl: $imageUrl, productCount: $productCount, displayOrder: $displayOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$CategoryListItemCopyWith<$Res> implements $CategoryListItemCopyWith<$Res> {
  factory _$CategoryListItemCopyWith(_CategoryListItem value, $Res Function(_CategoryListItem) _then) = __$CategoryListItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? parentName, String? imageUrl, int productCount, int displayOrder, bool isActive
});




}
/// @nodoc
class __$CategoryListItemCopyWithImpl<$Res>
    implements _$CategoryListItemCopyWith<$Res> {
  __$CategoryListItemCopyWithImpl(this._self, this._then);

  final _CategoryListItem _self;
  final $Res Function(_CategoryListItem) _then;

/// Create a copy of CategoryListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? parentName = freezed,Object? imageUrl = freezed,Object? productCount = null,Object? displayOrder = null,Object? isActive = null,}) {
  return _then(_CategoryListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,parentName: freezed == parentName ? _self.parentName : parentName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,productCount: null == productCount ? _self.productCount : productCount // ignore: cast_nullable_to_non_nullable
as int,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CategoryDetail {

 int get id; String get name; String? get description; int? get parentId; int get displayOrder; bool get isActive; String? get imageUrl;
/// Create a copy of CategoryDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryDetailCopyWith<CategoryDetail> get copyWith => _$CategoryDetailCopyWithImpl<CategoryDetail>(this as CategoryDetail, _$identity);

  /// Serializes this CategoryDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,parentId,displayOrder,isActive,imageUrl);

@override
String toString() {
  return 'CategoryDetail(id: $id, name: $name, description: $description, parentId: $parentId, displayOrder: $displayOrder, isActive: $isActive, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $CategoryDetailCopyWith<$Res>  {
  factory $CategoryDetailCopyWith(CategoryDetail value, $Res Function(CategoryDetail) _then) = _$CategoryDetailCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, int? parentId, int displayOrder, bool isActive, String? imageUrl
});




}
/// @nodoc
class _$CategoryDetailCopyWithImpl<$Res>
    implements $CategoryDetailCopyWith<$Res> {
  _$CategoryDetailCopyWithImpl(this._self, this._then);

  final CategoryDetail _self;
  final $Res Function(CategoryDetail) _then;

/// Create a copy of CategoryDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? parentId = freezed,Object? displayOrder = null,Object? isActive = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryDetail].
extension CategoryDetailPatterns on CategoryDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryDetail value)  $default,){
final _that = this;
switch (_that) {
case _CategoryDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryDetail value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  int? parentId,  int displayOrder,  bool isActive,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryDetail() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.parentId,_that.displayOrder,_that.isActive,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  int? parentId,  int displayOrder,  bool isActive,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _CategoryDetail():
return $default(_that.id,_that.name,_that.description,_that.parentId,_that.displayOrder,_that.isActive,_that.imageUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  int? parentId,  int displayOrder,  bool isActive,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _CategoryDetail() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.parentId,_that.displayOrder,_that.isActive,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryDetail implements CategoryDetail {
  const _CategoryDetail({required this.id, required this.name, this.description, this.parentId, this.displayOrder = 0, this.isActive = true, this.imageUrl});
  factory _CategoryDetail.fromJson(Map<String, dynamic> json) => _$CategoryDetailFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override final  int? parentId;
@override@JsonKey() final  int displayOrder;
@override@JsonKey() final  bool isActive;
@override final  String? imageUrl;

/// Create a copy of CategoryDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryDetailCopyWith<_CategoryDetail> get copyWith => __$CategoryDetailCopyWithImpl<_CategoryDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,parentId,displayOrder,isActive,imageUrl);

@override
String toString() {
  return 'CategoryDetail(id: $id, name: $name, description: $description, parentId: $parentId, displayOrder: $displayOrder, isActive: $isActive, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$CategoryDetailCopyWith<$Res> implements $CategoryDetailCopyWith<$Res> {
  factory _$CategoryDetailCopyWith(_CategoryDetail value, $Res Function(_CategoryDetail) _then) = __$CategoryDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, int? parentId, int displayOrder, bool isActive, String? imageUrl
});




}
/// @nodoc
class __$CategoryDetailCopyWithImpl<$Res>
    implements _$CategoryDetailCopyWith<$Res> {
  __$CategoryDetailCopyWithImpl(this._self, this._then);

  final _CategoryDetail _self;
  final $Res Function(_CategoryDetail) _then;

/// Create a copy of CategoryDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? parentId = freezed,Object? displayOrder = null,Object? isActive = null,Object? imageUrl = freezed,}) {
  return _then(_CategoryDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CategoryRequest {

 String get name; String? get description; int? get parentId; int get displayOrder; bool get isActive; bool get removeImage;
/// Create a copy of CategoryRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryRequestCopyWith<CategoryRequest> get copyWith => _$CategoryRequestCopyWithImpl<CategoryRequest>(this as CategoryRequest, _$identity);

  /// Serializes this CategoryRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.removeImage, removeImage) || other.removeImage == removeImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,parentId,displayOrder,isActive,removeImage);

@override
String toString() {
  return 'CategoryRequest(name: $name, description: $description, parentId: $parentId, displayOrder: $displayOrder, isActive: $isActive, removeImage: $removeImage)';
}


}

/// @nodoc
abstract mixin class $CategoryRequestCopyWith<$Res>  {
  factory $CategoryRequestCopyWith(CategoryRequest value, $Res Function(CategoryRequest) _then) = _$CategoryRequestCopyWithImpl;
@useResult
$Res call({
 String name, String? description, int? parentId, int displayOrder, bool isActive, bool removeImage
});




}
/// @nodoc
class _$CategoryRequestCopyWithImpl<$Res>
    implements $CategoryRequestCopyWith<$Res> {
  _$CategoryRequestCopyWithImpl(this._self, this._then);

  final CategoryRequest _self;
  final $Res Function(CategoryRequest) _then;

/// Create a copy of CategoryRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = freezed,Object? parentId = freezed,Object? displayOrder = null,Object? isActive = null,Object? removeImage = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,removeImage: null == removeImage ? _self.removeImage : removeImage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryRequest].
extension CategoryRequestPatterns on CategoryRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryRequest value)  $default,){
final _that = this;
switch (_that) {
case _CategoryRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? description,  int? parentId,  int displayOrder,  bool isActive,  bool removeImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryRequest() when $default != null:
return $default(_that.name,_that.description,_that.parentId,_that.displayOrder,_that.isActive,_that.removeImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? description,  int? parentId,  int displayOrder,  bool isActive,  bool removeImage)  $default,) {final _that = this;
switch (_that) {
case _CategoryRequest():
return $default(_that.name,_that.description,_that.parentId,_that.displayOrder,_that.isActive,_that.removeImage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? description,  int? parentId,  int displayOrder,  bool isActive,  bool removeImage)?  $default,) {final _that = this;
switch (_that) {
case _CategoryRequest() when $default != null:
return $default(_that.name,_that.description,_that.parentId,_that.displayOrder,_that.isActive,_that.removeImage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryRequest implements CategoryRequest {
  const _CategoryRequest({required this.name, this.description, this.parentId, this.displayOrder = 0, this.isActive = true, this.removeImage = false});
  factory _CategoryRequest.fromJson(Map<String, dynamic> json) => _$CategoryRequestFromJson(json);

@override final  String name;
@override final  String? description;
@override final  int? parentId;
@override@JsonKey() final  int displayOrder;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool removeImage;

/// Create a copy of CategoryRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryRequestCopyWith<_CategoryRequest> get copyWith => __$CategoryRequestCopyWithImpl<_CategoryRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.removeImage, removeImage) || other.removeImage == removeImage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,parentId,displayOrder,isActive,removeImage);

@override
String toString() {
  return 'CategoryRequest(name: $name, description: $description, parentId: $parentId, displayOrder: $displayOrder, isActive: $isActive, removeImage: $removeImage)';
}


}

/// @nodoc
abstract mixin class _$CategoryRequestCopyWith<$Res> implements $CategoryRequestCopyWith<$Res> {
  factory _$CategoryRequestCopyWith(_CategoryRequest value, $Res Function(_CategoryRequest) _then) = __$CategoryRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String? description, int? parentId, int displayOrder, bool isActive, bool removeImage
});




}
/// @nodoc
class __$CategoryRequestCopyWithImpl<$Res>
    implements _$CategoryRequestCopyWith<$Res> {
  __$CategoryRequestCopyWithImpl(this._self, this._then);

  final _CategoryRequest _self;
  final $Res Function(_CategoryRequest) _then;

/// Create a copy of CategoryRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = freezed,Object? parentId = freezed,Object? displayOrder = null,Object? isActive = null,Object? removeImage = null,}) {
  return _then(_CategoryRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,removeImage: null == removeImage ? _self.removeImage : removeImage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
