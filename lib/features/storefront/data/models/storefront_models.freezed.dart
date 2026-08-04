// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storefront_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StorefrontProduct {

 int get id; String get name; String? get categoryName; String? get imageUrl; double get price; double? get discountPrice; String? get shortDescription;
/// Create a copy of StorefrontProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorefrontProductCopyWith<StorefrontProduct> get copyWith => _$StorefrontProductCopyWithImpl<StorefrontProduct>(this as StorefrontProduct, _$identity);

  /// Serializes this StorefrontProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,categoryName,imageUrl,price,discountPrice,shortDescription);

@override
String toString() {
  return 'StorefrontProduct(id: $id, name: $name, categoryName: $categoryName, imageUrl: $imageUrl, price: $price, discountPrice: $discountPrice, shortDescription: $shortDescription)';
}


}

/// @nodoc
abstract mixin class $StorefrontProductCopyWith<$Res>  {
  factory $StorefrontProductCopyWith(StorefrontProduct value, $Res Function(StorefrontProduct) _then) = _$StorefrontProductCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? categoryName, String? imageUrl, double price, double? discountPrice, String? shortDescription
});




}
/// @nodoc
class _$StorefrontProductCopyWithImpl<$Res>
    implements $StorefrontProductCopyWith<$Res> {
  _$StorefrontProductCopyWithImpl(this._self, this._then);

  final StorefrontProduct _self;
  final $Res Function(StorefrontProduct) _then;

/// Create a copy of StorefrontProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? categoryName = freezed,Object? imageUrl = freezed,Object? price = null,Object? discountPrice = freezed,Object? shortDescription = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StorefrontProduct].
extension StorefrontProductPatterns on StorefrontProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorefrontProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorefrontProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorefrontProduct value)  $default,){
final _that = this;
switch (_that) {
case _StorefrontProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorefrontProduct value)?  $default,){
final _that = this;
switch (_that) {
case _StorefrontProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? categoryName,  String? imageUrl,  double price,  double? discountPrice,  String? shortDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorefrontProduct() when $default != null:
return $default(_that.id,_that.name,_that.categoryName,_that.imageUrl,_that.price,_that.discountPrice,_that.shortDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? categoryName,  String? imageUrl,  double price,  double? discountPrice,  String? shortDescription)  $default,) {final _that = this;
switch (_that) {
case _StorefrontProduct():
return $default(_that.id,_that.name,_that.categoryName,_that.imageUrl,_that.price,_that.discountPrice,_that.shortDescription);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? categoryName,  String? imageUrl,  double price,  double? discountPrice,  String? shortDescription)?  $default,) {final _that = this;
switch (_that) {
case _StorefrontProduct() when $default != null:
return $default(_that.id,_that.name,_that.categoryName,_that.imageUrl,_that.price,_that.discountPrice,_that.shortDescription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorefrontProduct implements StorefrontProduct {
  const _StorefrontProduct({required this.id, required this.name, this.categoryName, this.imageUrl, required this.price, this.discountPrice, this.shortDescription});
  factory _StorefrontProduct.fromJson(Map<String, dynamic> json) => _$StorefrontProductFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? categoryName;
@override final  String? imageUrl;
@override final  double price;
@override final  double? discountPrice;
@override final  String? shortDescription;

/// Create a copy of StorefrontProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorefrontProductCopyWith<_StorefrontProduct> get copyWith => __$StorefrontProductCopyWithImpl<_StorefrontProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorefrontProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorefrontProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,categoryName,imageUrl,price,discountPrice,shortDescription);

@override
String toString() {
  return 'StorefrontProduct(id: $id, name: $name, categoryName: $categoryName, imageUrl: $imageUrl, price: $price, discountPrice: $discountPrice, shortDescription: $shortDescription)';
}


}

/// @nodoc
abstract mixin class _$StorefrontProductCopyWith<$Res> implements $StorefrontProductCopyWith<$Res> {
  factory _$StorefrontProductCopyWith(_StorefrontProduct value, $Res Function(_StorefrontProduct) _then) = __$StorefrontProductCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? categoryName, String? imageUrl, double price, double? discountPrice, String? shortDescription
});




}
/// @nodoc
class __$StorefrontProductCopyWithImpl<$Res>
    implements _$StorefrontProductCopyWith<$Res> {
  __$StorefrontProductCopyWithImpl(this._self, this._then);

  final _StorefrontProduct _self;
  final $Res Function(_StorefrontProduct) _then;

/// Create a copy of StorefrontProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? categoryName = freezed,Object? imageUrl = freezed,Object? price = null,Object? discountPrice = freezed,Object? shortDescription = freezed,}) {
  return _then(_StorefrontProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StorefrontProductDetail {

 int get id; String get name; String? get shortDescription; String? get description; double get price; double? get discountPrice; String? get categoryName; List<StorefrontImage> get images;
/// Create a copy of StorefrontProductDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorefrontProductDetailCopyWith<StorefrontProductDetail> get copyWith => _$StorefrontProductDetailCopyWithImpl<StorefrontProductDetail>(this as StorefrontProductDetail, _$identity);

  /// Serializes this StorefrontProductDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontProductDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shortDescription,description,price,discountPrice,categoryName,const DeepCollectionEquality().hash(images));

@override
String toString() {
  return 'StorefrontProductDetail(id: $id, name: $name, shortDescription: $shortDescription, description: $description, price: $price, discountPrice: $discountPrice, categoryName: $categoryName, images: $images)';
}


}

/// @nodoc
abstract mixin class $StorefrontProductDetailCopyWith<$Res>  {
  factory $StorefrontProductDetailCopyWith(StorefrontProductDetail value, $Res Function(StorefrontProductDetail) _then) = _$StorefrontProductDetailCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? shortDescription, String? description, double price, double? discountPrice, String? categoryName, List<StorefrontImage> images
});




}
/// @nodoc
class _$StorefrontProductDetailCopyWithImpl<$Res>
    implements $StorefrontProductDetailCopyWith<$Res> {
  _$StorefrontProductDetailCopyWithImpl(this._self, this._then);

  final StorefrontProductDetail _self;
  final $Res Function(StorefrontProductDetail) _then;

/// Create a copy of StorefrontProductDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shortDescription = freezed,Object? description = freezed,Object? price = null,Object? discountPrice = freezed,Object? categoryName = freezed,Object? images = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<StorefrontImage>,
  ));
}

}


/// Adds pattern-matching-related methods to [StorefrontProductDetail].
extension StorefrontProductDetailPatterns on StorefrontProductDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorefrontProductDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorefrontProductDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorefrontProductDetail value)  $default,){
final _that = this;
switch (_that) {
case _StorefrontProductDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorefrontProductDetail value)?  $default,){
final _that = this;
switch (_that) {
case _StorefrontProductDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? shortDescription,  String? description,  double price,  double? discountPrice,  String? categoryName,  List<StorefrontImage> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorefrontProductDetail() when $default != null:
return $default(_that.id,_that.name,_that.shortDescription,_that.description,_that.price,_that.discountPrice,_that.categoryName,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? shortDescription,  String? description,  double price,  double? discountPrice,  String? categoryName,  List<StorefrontImage> images)  $default,) {final _that = this;
switch (_that) {
case _StorefrontProductDetail():
return $default(_that.id,_that.name,_that.shortDescription,_that.description,_that.price,_that.discountPrice,_that.categoryName,_that.images);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? shortDescription,  String? description,  double price,  double? discountPrice,  String? categoryName,  List<StorefrontImage> images)?  $default,) {final _that = this;
switch (_that) {
case _StorefrontProductDetail() when $default != null:
return $default(_that.id,_that.name,_that.shortDescription,_that.description,_that.price,_that.discountPrice,_that.categoryName,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorefrontProductDetail implements StorefrontProductDetail {
  const _StorefrontProductDetail({required this.id, required this.name, this.shortDescription, this.description, required this.price, this.discountPrice, this.categoryName, final  List<StorefrontImage> images = const []}): _images = images;
  factory _StorefrontProductDetail.fromJson(Map<String, dynamic> json) => _$StorefrontProductDetailFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? shortDescription;
@override final  String? description;
@override final  double price;
@override final  double? discountPrice;
@override final  String? categoryName;
 final  List<StorefrontImage> _images;
@override@JsonKey() List<StorefrontImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of StorefrontProductDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorefrontProductDetailCopyWith<_StorefrontProductDetail> get copyWith => __$StorefrontProductDetailCopyWithImpl<_StorefrontProductDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorefrontProductDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorefrontProductDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shortDescription,description,price,discountPrice,categoryName,const DeepCollectionEquality().hash(_images));

@override
String toString() {
  return 'StorefrontProductDetail(id: $id, name: $name, shortDescription: $shortDescription, description: $description, price: $price, discountPrice: $discountPrice, categoryName: $categoryName, images: $images)';
}


}

/// @nodoc
abstract mixin class _$StorefrontProductDetailCopyWith<$Res> implements $StorefrontProductDetailCopyWith<$Res> {
  factory _$StorefrontProductDetailCopyWith(_StorefrontProductDetail value, $Res Function(_StorefrontProductDetail) _then) = __$StorefrontProductDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? shortDescription, String? description, double price, double? discountPrice, String? categoryName, List<StorefrontImage> images
});




}
/// @nodoc
class __$StorefrontProductDetailCopyWithImpl<$Res>
    implements _$StorefrontProductDetailCopyWith<$Res> {
  __$StorefrontProductDetailCopyWithImpl(this._self, this._then);

  final _StorefrontProductDetail _self;
  final $Res Function(_StorefrontProductDetail) _then;

/// Create a copy of StorefrontProductDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shortDescription = freezed,Object? description = freezed,Object? price = null,Object? discountPrice = freezed,Object? categoryName = freezed,Object? images = null,}) {
  return _then(_StorefrontProductDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<StorefrontImage>,
  ));
}


}


/// @nodoc
mixin _$StorefrontImage {

 int get id; String get url; bool get isCover; int get sortOrder;
/// Create a copy of StorefrontImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorefrontImageCopyWith<StorefrontImage> get copyWith => _$StorefrontImageCopyWithImpl<StorefrontImage>(this as StorefrontImage, _$identity);

  /// Serializes this StorefrontImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontImage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.isCover, isCover) || other.isCover == isCover)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,isCover,sortOrder);

@override
String toString() {
  return 'StorefrontImage(id: $id, url: $url, isCover: $isCover, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $StorefrontImageCopyWith<$Res>  {
  factory $StorefrontImageCopyWith(StorefrontImage value, $Res Function(StorefrontImage) _then) = _$StorefrontImageCopyWithImpl;
@useResult
$Res call({
 int id, String url, bool isCover, int sortOrder
});




}
/// @nodoc
class _$StorefrontImageCopyWithImpl<$Res>
    implements $StorefrontImageCopyWith<$Res> {
  _$StorefrontImageCopyWithImpl(this._self, this._then);

  final StorefrontImage _self;
  final $Res Function(StorefrontImage) _then;

/// Create a copy of StorefrontImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,Object? isCover = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,isCover: null == isCover ? _self.isCover : isCover // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StorefrontImage].
extension StorefrontImagePatterns on StorefrontImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorefrontImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorefrontImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorefrontImage value)  $default,){
final _that = this;
switch (_that) {
case _StorefrontImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorefrontImage value)?  $default,){
final _that = this;
switch (_that) {
case _StorefrontImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String url,  bool isCover,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorefrontImage() when $default != null:
return $default(_that.id,_that.url,_that.isCover,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String url,  bool isCover,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _StorefrontImage():
return $default(_that.id,_that.url,_that.isCover,_that.sortOrder);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String url,  bool isCover,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _StorefrontImage() when $default != null:
return $default(_that.id,_that.url,_that.isCover,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorefrontImage implements StorefrontImage {
  const _StorefrontImage({required this.id, required this.url, this.isCover = false, this.sortOrder = 0});
  factory _StorefrontImage.fromJson(Map<String, dynamic> json) => _$StorefrontImageFromJson(json);

@override final  int id;
@override final  String url;
@override@JsonKey() final  bool isCover;
@override@JsonKey() final  int sortOrder;

/// Create a copy of StorefrontImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorefrontImageCopyWith<_StorefrontImage> get copyWith => __$StorefrontImageCopyWithImpl<_StorefrontImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorefrontImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorefrontImage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.isCover, isCover) || other.isCover == isCover)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,isCover,sortOrder);

@override
String toString() {
  return 'StorefrontImage(id: $id, url: $url, isCover: $isCover, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$StorefrontImageCopyWith<$Res> implements $StorefrontImageCopyWith<$Res> {
  factory _$StorefrontImageCopyWith(_StorefrontImage value, $Res Function(_StorefrontImage) _then) = __$StorefrontImageCopyWithImpl;
@override @useResult
$Res call({
 int id, String url, bool isCover, int sortOrder
});




}
/// @nodoc
class __$StorefrontImageCopyWithImpl<$Res>
    implements _$StorefrontImageCopyWith<$Res> {
  __$StorefrontImageCopyWithImpl(this._self, this._then);

  final _StorefrontImage _self;
  final $Res Function(_StorefrontImage) _then;

/// Create a copy of StorefrontImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? isCover = null,Object? sortOrder = null,}) {
  return _then(_StorefrontImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,isCover: null == isCover ? _self.isCover : isCover // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StorefrontCategory {

 int get id; String get name; String? get imageUrl;
/// Create a copy of StorefrontCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorefrontCategoryCopyWith<StorefrontCategory> get copyWith => _$StorefrontCategoryCopyWithImpl<StorefrontCategory>(this as StorefrontCategory, _$identity);

  /// Serializes this StorefrontCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl);

@override
String toString() {
  return 'StorefrontCategory(id: $id, name: $name, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $StorefrontCategoryCopyWith<$Res>  {
  factory $StorefrontCategoryCopyWith(StorefrontCategory value, $Res Function(StorefrontCategory) _then) = _$StorefrontCategoryCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? imageUrl
});




}
/// @nodoc
class _$StorefrontCategoryCopyWithImpl<$Res>
    implements $StorefrontCategoryCopyWith<$Res> {
  _$StorefrontCategoryCopyWithImpl(this._self, this._then);

  final StorefrontCategory _self;
  final $Res Function(StorefrontCategory) _then;

/// Create a copy of StorefrontCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StorefrontCategory].
extension StorefrontCategoryPatterns on StorefrontCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorefrontCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorefrontCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorefrontCategory value)  $default,){
final _that = this;
switch (_that) {
case _StorefrontCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorefrontCategory value)?  $default,){
final _that = this;
switch (_that) {
case _StorefrontCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorefrontCategory() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _StorefrontCategory():
return $default(_that.id,_that.name,_that.imageUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _StorefrontCategory() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorefrontCategory implements StorefrontCategory {
  const _StorefrontCategory({required this.id, required this.name, this.imageUrl});
  factory _StorefrontCategory.fromJson(Map<String, dynamic> json) => _$StorefrontCategoryFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? imageUrl;

/// Create a copy of StorefrontCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorefrontCategoryCopyWith<_StorefrontCategory> get copyWith => __$StorefrontCategoryCopyWithImpl<_StorefrontCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorefrontCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorefrontCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl);

@override
String toString() {
  return 'StorefrontCategory(id: $id, name: $name, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$StorefrontCategoryCopyWith<$Res> implements $StorefrontCategoryCopyWith<$Res> {
  factory _$StorefrontCategoryCopyWith(_StorefrontCategory value, $Res Function(_StorefrontCategory) _then) = __$StorefrontCategoryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? imageUrl
});




}
/// @nodoc
class __$StorefrontCategoryCopyWithImpl<$Res>
    implements _$StorefrontCategoryCopyWith<$Res> {
  __$StorefrontCategoryCopyWithImpl(this._self, this._then);

  final _StorefrontCategory _self;
  final $Res Function(_StorefrontCategory) _then;

/// Create a copy of StorefrontCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = freezed,}) {
  return _then(_StorefrontCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PlaceOrderRequest {

 String get customerWhatsApp; String? get customerName; String? get notes; List<OrderItemRequest> get items;
/// Create a copy of PlaceOrderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceOrderRequestCopyWith<PlaceOrderRequest> get copyWith => _$PlaceOrderRequestCopyWithImpl<PlaceOrderRequest>(this as PlaceOrderRequest, _$identity);

  /// Serializes this PlaceOrderRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceOrderRequest&&(identical(other.customerWhatsApp, customerWhatsApp) || other.customerWhatsApp == customerWhatsApp)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customerWhatsApp,customerName,notes,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'PlaceOrderRequest(customerWhatsApp: $customerWhatsApp, customerName: $customerName, notes: $notes, items: $items)';
}


}

/// @nodoc
abstract mixin class $PlaceOrderRequestCopyWith<$Res>  {
  factory $PlaceOrderRequestCopyWith(PlaceOrderRequest value, $Res Function(PlaceOrderRequest) _then) = _$PlaceOrderRequestCopyWithImpl;
@useResult
$Res call({
 String customerWhatsApp, String? customerName, String? notes, List<OrderItemRequest> items
});




}
/// @nodoc
class _$PlaceOrderRequestCopyWithImpl<$Res>
    implements $PlaceOrderRequestCopyWith<$Res> {
  _$PlaceOrderRequestCopyWithImpl(this._self, this._then);

  final PlaceOrderRequest _self;
  final $Res Function(PlaceOrderRequest) _then;

/// Create a copy of PlaceOrderRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerWhatsApp = null,Object? customerName = freezed,Object? notes = freezed,Object? items = null,}) {
  return _then(_self.copyWith(
customerWhatsApp: null == customerWhatsApp ? _self.customerWhatsApp : customerWhatsApp // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItemRequest>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceOrderRequest].
extension PlaceOrderRequestPatterns on PlaceOrderRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceOrderRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceOrderRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceOrderRequest value)  $default,){
final _that = this;
switch (_that) {
case _PlaceOrderRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceOrderRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceOrderRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String customerWhatsApp,  String? customerName,  String? notes,  List<OrderItemRequest> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceOrderRequest() when $default != null:
return $default(_that.customerWhatsApp,_that.customerName,_that.notes,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String customerWhatsApp,  String? customerName,  String? notes,  List<OrderItemRequest> items)  $default,) {final _that = this;
switch (_that) {
case _PlaceOrderRequest():
return $default(_that.customerWhatsApp,_that.customerName,_that.notes,_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String customerWhatsApp,  String? customerName,  String? notes,  List<OrderItemRequest> items)?  $default,) {final _that = this;
switch (_that) {
case _PlaceOrderRequest() when $default != null:
return $default(_that.customerWhatsApp,_that.customerName,_that.notes,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceOrderRequest implements PlaceOrderRequest {
  const _PlaceOrderRequest({required this.customerWhatsApp, this.customerName, this.notes, required final  List<OrderItemRequest> items}): _items = items;
  factory _PlaceOrderRequest.fromJson(Map<String, dynamic> json) => _$PlaceOrderRequestFromJson(json);

@override final  String customerWhatsApp;
@override final  String? customerName;
@override final  String? notes;
 final  List<OrderItemRequest> _items;
@override List<OrderItemRequest> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of PlaceOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceOrderRequestCopyWith<_PlaceOrderRequest> get copyWith => __$PlaceOrderRequestCopyWithImpl<_PlaceOrderRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceOrderRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceOrderRequest&&(identical(other.customerWhatsApp, customerWhatsApp) || other.customerWhatsApp == customerWhatsApp)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customerWhatsApp,customerName,notes,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'PlaceOrderRequest(customerWhatsApp: $customerWhatsApp, customerName: $customerName, notes: $notes, items: $items)';
}


}

/// @nodoc
abstract mixin class _$PlaceOrderRequestCopyWith<$Res> implements $PlaceOrderRequestCopyWith<$Res> {
  factory _$PlaceOrderRequestCopyWith(_PlaceOrderRequest value, $Res Function(_PlaceOrderRequest) _then) = __$PlaceOrderRequestCopyWithImpl;
@override @useResult
$Res call({
 String customerWhatsApp, String? customerName, String? notes, List<OrderItemRequest> items
});




}
/// @nodoc
class __$PlaceOrderRequestCopyWithImpl<$Res>
    implements _$PlaceOrderRequestCopyWith<$Res> {
  __$PlaceOrderRequestCopyWithImpl(this._self, this._then);

  final _PlaceOrderRequest _self;
  final $Res Function(_PlaceOrderRequest) _then;

/// Create a copy of PlaceOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customerWhatsApp = null,Object? customerName = freezed,Object? notes = freezed,Object? items = null,}) {
  return _then(_PlaceOrderRequest(
customerWhatsApp: null == customerWhatsApp ? _self.customerWhatsApp : customerWhatsApp // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItemRequest>,
  ));
}


}


/// @nodoc
mixin _$OrderItemRequest {

 int get productId; int get quantity;
/// Create a copy of OrderItemRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemRequestCopyWith<OrderItemRequest> get copyWith => _$OrderItemRequestCopyWithImpl<OrderItemRequest>(this as OrderItemRequest, _$identity);

  /// Serializes this OrderItemRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItemRequest&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,quantity);

@override
String toString() {
  return 'OrderItemRequest(productId: $productId, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $OrderItemRequestCopyWith<$Res>  {
  factory $OrderItemRequestCopyWith(OrderItemRequest value, $Res Function(OrderItemRequest) _then) = _$OrderItemRequestCopyWithImpl;
@useResult
$Res call({
 int productId, int quantity
});




}
/// @nodoc
class _$OrderItemRequestCopyWithImpl<$Res>
    implements $OrderItemRequestCopyWith<$Res> {
  _$OrderItemRequestCopyWithImpl(this._self, this._then);

  final OrderItemRequest _self;
  final $Res Function(OrderItemRequest) _then;

/// Create a copy of OrderItemRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? quantity = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderItemRequest].
extension OrderItemRequestPatterns on OrderItemRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderItemRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderItemRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderItemRequest value)  $default,){
final _that = this;
switch (_that) {
case _OrderItemRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderItemRequest value)?  $default,){
final _that = this;
switch (_that) {
case _OrderItemRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int productId,  int quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderItemRequest() when $default != null:
return $default(_that.productId,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int productId,  int quantity)  $default,) {final _that = this;
switch (_that) {
case _OrderItemRequest():
return $default(_that.productId,_that.quantity);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int productId,  int quantity)?  $default,) {final _that = this;
switch (_that) {
case _OrderItemRequest() when $default != null:
return $default(_that.productId,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderItemRequest implements OrderItemRequest {
  const _OrderItemRequest({required this.productId, required this.quantity});
  factory _OrderItemRequest.fromJson(Map<String, dynamic> json) => _$OrderItemRequestFromJson(json);

@override final  int productId;
@override final  int quantity;

/// Create a copy of OrderItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemRequestCopyWith<_OrderItemRequest> get copyWith => __$OrderItemRequestCopyWithImpl<_OrderItemRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderItemRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItemRequest&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,quantity);

@override
String toString() {
  return 'OrderItemRequest(productId: $productId, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$OrderItemRequestCopyWith<$Res> implements $OrderItemRequestCopyWith<$Res> {
  factory _$OrderItemRequestCopyWith(_OrderItemRequest value, $Res Function(_OrderItemRequest) _then) = __$OrderItemRequestCopyWithImpl;
@override @useResult
$Res call({
 int productId, int quantity
});




}
/// @nodoc
class __$OrderItemRequestCopyWithImpl<$Res>
    implements _$OrderItemRequestCopyWith<$Res> {
  __$OrderItemRequestCopyWithImpl(this._self, this._then);

  final _OrderItemRequest _self;
  final $Res Function(_OrderItemRequest) _then;

/// Create a copy of OrderItemRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? quantity = null,}) {
  return _then(_OrderItemRequest(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PlaceOrderResult {

 int get id; String get orderNumber; double get totalAmount;
/// Create a copy of PlaceOrderResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceOrderResultCopyWith<PlaceOrderResult> get copyWith => _$PlaceOrderResultCopyWithImpl<PlaceOrderResult>(this as PlaceOrderResult, _$identity);

  /// Serializes this PlaceOrderResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceOrderResult&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,totalAmount);

@override
String toString() {
  return 'PlaceOrderResult(id: $id, orderNumber: $orderNumber, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class $PlaceOrderResultCopyWith<$Res>  {
  factory $PlaceOrderResultCopyWith(PlaceOrderResult value, $Res Function(PlaceOrderResult) _then) = _$PlaceOrderResultCopyWithImpl;
@useResult
$Res call({
 int id, String orderNumber, double totalAmount
});




}
/// @nodoc
class _$PlaceOrderResultCopyWithImpl<$Res>
    implements $PlaceOrderResultCopyWith<$Res> {
  _$PlaceOrderResultCopyWithImpl(this._self, this._then);

  final PlaceOrderResult _self;
  final $Res Function(PlaceOrderResult) _then;

/// Create a copy of PlaceOrderResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNumber = null,Object? totalAmount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceOrderResult].
extension PlaceOrderResultPatterns on PlaceOrderResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceOrderResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceOrderResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceOrderResult value)  $default,){
final _that = this;
switch (_that) {
case _PlaceOrderResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceOrderResult value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceOrderResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String orderNumber,  double totalAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceOrderResult() when $default != null:
return $default(_that.id,_that.orderNumber,_that.totalAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String orderNumber,  double totalAmount)  $default,) {final _that = this;
switch (_that) {
case _PlaceOrderResult():
return $default(_that.id,_that.orderNumber,_that.totalAmount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String orderNumber,  double totalAmount)?  $default,) {final _that = this;
switch (_that) {
case _PlaceOrderResult() when $default != null:
return $default(_that.id,_that.orderNumber,_that.totalAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceOrderResult implements PlaceOrderResult {
  const _PlaceOrderResult({required this.id, required this.orderNumber, required this.totalAmount});
  factory _PlaceOrderResult.fromJson(Map<String, dynamic> json) => _$PlaceOrderResultFromJson(json);

@override final  int id;
@override final  String orderNumber;
@override final  double totalAmount;

/// Create a copy of PlaceOrderResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceOrderResultCopyWith<_PlaceOrderResult> get copyWith => __$PlaceOrderResultCopyWithImpl<_PlaceOrderResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceOrderResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceOrderResult&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,totalAmount);

@override
String toString() {
  return 'PlaceOrderResult(id: $id, orderNumber: $orderNumber, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class _$PlaceOrderResultCopyWith<$Res> implements $PlaceOrderResultCopyWith<$Res> {
  factory _$PlaceOrderResultCopyWith(_PlaceOrderResult value, $Res Function(_PlaceOrderResult) _then) = __$PlaceOrderResultCopyWithImpl;
@override @useResult
$Res call({
 int id, String orderNumber, double totalAmount
});




}
/// @nodoc
class __$PlaceOrderResultCopyWithImpl<$Res>
    implements _$PlaceOrderResultCopyWith<$Res> {
  __$PlaceOrderResultCopyWithImpl(this._self, this._then);

  final _PlaceOrderResult _self;
  final $Res Function(_PlaceOrderResult) _then;

/// Create a copy of PlaceOrderResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? totalAmount = null,}) {
  return _then(_PlaceOrderResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
