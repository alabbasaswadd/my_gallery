// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductListItem {

 int get id; String get name; String? get categoryName; String? get imageUrl; double get price; double? get discountPrice; bool get isActive; String? get createdAt;
/// Create a copy of ProductListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductListItemCopyWith<ProductListItem> get copyWith => _$ProductListItemCopyWithImpl<ProductListItem>(this as ProductListItem, _$identity);

  /// Serializes this ProductListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,categoryName,imageUrl,price,discountPrice,isActive,createdAt);

@override
String toString() {
  return 'ProductListItem(id: $id, name: $name, categoryName: $categoryName, imageUrl: $imageUrl, price: $price, discountPrice: $discountPrice, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ProductListItemCopyWith<$Res>  {
  factory $ProductListItemCopyWith(ProductListItem value, $Res Function(ProductListItem) _then) = _$ProductListItemCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? categoryName, String? imageUrl, double price, double? discountPrice, bool isActive, String? createdAt
});




}
/// @nodoc
class _$ProductListItemCopyWithImpl<$Res>
    implements $ProductListItemCopyWith<$Res> {
  _$ProductListItemCopyWithImpl(this._self, this._then);

  final ProductListItem _self;
  final $Res Function(ProductListItem) _then;

/// Create a copy of ProductListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? categoryName = freezed,Object? imageUrl = freezed,Object? price = null,Object? discountPrice = freezed,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductListItem].
extension ProductListItemPatterns on ProductListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductListItem value)  $default,){
final _that = this;
switch (_that) {
case _ProductListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductListItem value)?  $default,){
final _that = this;
switch (_that) {
case _ProductListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? categoryName,  String? imageUrl,  double price,  double? discountPrice,  bool isActive,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductListItem() when $default != null:
return $default(_that.id,_that.name,_that.categoryName,_that.imageUrl,_that.price,_that.discountPrice,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? categoryName,  String? imageUrl,  double price,  double? discountPrice,  bool isActive,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ProductListItem():
return $default(_that.id,_that.name,_that.categoryName,_that.imageUrl,_that.price,_that.discountPrice,_that.isActive,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? categoryName,  String? imageUrl,  double price,  double? discountPrice,  bool isActive,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ProductListItem() when $default != null:
return $default(_that.id,_that.name,_that.categoryName,_that.imageUrl,_that.price,_that.discountPrice,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductListItem implements ProductListItem {
  const _ProductListItem({required this.id, required this.name, this.categoryName, this.imageUrl, required this.price, this.discountPrice, this.isActive = true, this.createdAt});
  factory _ProductListItem.fromJson(Map<String, dynamic> json) => _$ProductListItemFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? categoryName;
@override final  String? imageUrl;
@override final  double price;
@override final  double? discountPrice;
@override@JsonKey() final  bool isActive;
@override final  String? createdAt;

/// Create a copy of ProductListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductListItemCopyWith<_ProductListItem> get copyWith => __$ProductListItemCopyWithImpl<_ProductListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,categoryName,imageUrl,price,discountPrice,isActive,createdAt);

@override
String toString() {
  return 'ProductListItem(id: $id, name: $name, categoryName: $categoryName, imageUrl: $imageUrl, price: $price, discountPrice: $discountPrice, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ProductListItemCopyWith<$Res> implements $ProductListItemCopyWith<$Res> {
  factory _$ProductListItemCopyWith(_ProductListItem value, $Res Function(_ProductListItem) _then) = __$ProductListItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? categoryName, String? imageUrl, double price, double? discountPrice, bool isActive, String? createdAt
});




}
/// @nodoc
class __$ProductListItemCopyWithImpl<$Res>
    implements _$ProductListItemCopyWith<$Res> {
  __$ProductListItemCopyWithImpl(this._self, this._then);

  final _ProductListItem _self;
  final $Res Function(_ProductListItem) _then;

/// Create a copy of ProductListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? categoryName = freezed,Object? imageUrl = freezed,Object? price = null,Object? discountPrice = freezed,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_ProductListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProductDetail {

 int get id; String get name; String? get shortDescription; String? get description; String? get sku; String? get barcode; int? get categoryId; double get price; double? get discountPrice; int get stockQuantity; double? get weight; double? get width; double? get height; double? get length; bool get isFeatured; bool get isNew; bool get isAvailable; bool get isActive; List<int> get tagIds; List<int> get occasionIds; List<ProductImage> get images;
/// Create a copy of ProductDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailCopyWith<ProductDetail> get copyWith => _$ProductDetailCopyWithImpl<ProductDetail>(this as ProductDetail, _$identity);

  /// Serializes this ProductDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.length, length) || other.length == length)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.tagIds, tagIds)&&const DeepCollectionEquality().equals(other.occasionIds, occasionIds)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,shortDescription,description,sku,barcode,categoryId,price,discountPrice,stockQuantity,weight,width,height,length,isFeatured,isNew,isAvailable,isActive,const DeepCollectionEquality().hash(tagIds),const DeepCollectionEquality().hash(occasionIds),const DeepCollectionEquality().hash(images)]);

@override
String toString() {
  return 'ProductDetail(id: $id, name: $name, shortDescription: $shortDescription, description: $description, sku: $sku, barcode: $barcode, categoryId: $categoryId, price: $price, discountPrice: $discountPrice, stockQuantity: $stockQuantity, weight: $weight, width: $width, height: $height, length: $length, isFeatured: $isFeatured, isNew: $isNew, isAvailable: $isAvailable, isActive: $isActive, tagIds: $tagIds, occasionIds: $occasionIds, images: $images)';
}


}

/// @nodoc
abstract mixin class $ProductDetailCopyWith<$Res>  {
  factory $ProductDetailCopyWith(ProductDetail value, $Res Function(ProductDetail) _then) = _$ProductDetailCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? shortDescription, String? description, String? sku, String? barcode, int? categoryId, double price, double? discountPrice, int stockQuantity, double? weight, double? width, double? height, double? length, bool isFeatured, bool isNew, bool isAvailable, bool isActive, List<int> tagIds, List<int> occasionIds, List<ProductImage> images
});




}
/// @nodoc
class _$ProductDetailCopyWithImpl<$Res>
    implements $ProductDetailCopyWith<$Res> {
  _$ProductDetailCopyWithImpl(this._self, this._then);

  final ProductDetail _self;
  final $Res Function(ProductDetail) _then;

/// Create a copy of ProductDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shortDescription = freezed,Object? description = freezed,Object? sku = freezed,Object? barcode = freezed,Object? categoryId = freezed,Object? price = null,Object? discountPrice = freezed,Object? stockQuantity = null,Object? weight = freezed,Object? width = freezed,Object? height = freezed,Object? length = freezed,Object? isFeatured = null,Object? isNew = null,Object? isAvailable = null,Object? isActive = null,Object? tagIds = null,Object? occasionIds = null,Object? images = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,tagIds: null == tagIds ? _self.tagIds : tagIds // ignore: cast_nullable_to_non_nullable
as List<int>,occasionIds: null == occasionIds ? _self.occasionIds : occasionIds // ignore: cast_nullable_to_non_nullable
as List<int>,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<ProductImage>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDetail].
extension ProductDetailPatterns on ProductDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDetail value)  $default,){
final _that = this;
switch (_that) {
case _ProductDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? shortDescription,  String? description,  String? sku,  String? barcode,  int? categoryId,  double price,  double? discountPrice,  int stockQuantity,  double? weight,  double? width,  double? height,  double? length,  bool isFeatured,  bool isNew,  bool isAvailable,  bool isActive,  List<int> tagIds,  List<int> occasionIds,  List<ProductImage> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDetail() when $default != null:
return $default(_that.id,_that.name,_that.shortDescription,_that.description,_that.sku,_that.barcode,_that.categoryId,_that.price,_that.discountPrice,_that.stockQuantity,_that.weight,_that.width,_that.height,_that.length,_that.isFeatured,_that.isNew,_that.isAvailable,_that.isActive,_that.tagIds,_that.occasionIds,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? shortDescription,  String? description,  String? sku,  String? barcode,  int? categoryId,  double price,  double? discountPrice,  int stockQuantity,  double? weight,  double? width,  double? height,  double? length,  bool isFeatured,  bool isNew,  bool isAvailable,  bool isActive,  List<int> tagIds,  List<int> occasionIds,  List<ProductImage> images)  $default,) {final _that = this;
switch (_that) {
case _ProductDetail():
return $default(_that.id,_that.name,_that.shortDescription,_that.description,_that.sku,_that.barcode,_that.categoryId,_that.price,_that.discountPrice,_that.stockQuantity,_that.weight,_that.width,_that.height,_that.length,_that.isFeatured,_that.isNew,_that.isAvailable,_that.isActive,_that.tagIds,_that.occasionIds,_that.images);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? shortDescription,  String? description,  String? sku,  String? barcode,  int? categoryId,  double price,  double? discountPrice,  int stockQuantity,  double? weight,  double? width,  double? height,  double? length,  bool isFeatured,  bool isNew,  bool isAvailable,  bool isActive,  List<int> tagIds,  List<int> occasionIds,  List<ProductImage> images)?  $default,) {final _that = this;
switch (_that) {
case _ProductDetail() when $default != null:
return $default(_that.id,_that.name,_that.shortDescription,_that.description,_that.sku,_that.barcode,_that.categoryId,_that.price,_that.discountPrice,_that.stockQuantity,_that.weight,_that.width,_that.height,_that.length,_that.isFeatured,_that.isNew,_that.isAvailable,_that.isActive,_that.tagIds,_that.occasionIds,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductDetail implements ProductDetail {
  const _ProductDetail({required this.id, required this.name, this.shortDescription, this.description, this.sku, this.barcode, this.categoryId, required this.price, this.discountPrice, this.stockQuantity = 0, this.weight, this.width, this.height, this.length, this.isFeatured = false, this.isNew = false, this.isAvailable = true, this.isActive = true, final  List<int> tagIds = const [], final  List<int> occasionIds = const [], final  List<ProductImage> images = const []}): _tagIds = tagIds,_occasionIds = occasionIds,_images = images;
  factory _ProductDetail.fromJson(Map<String, dynamic> json) => _$ProductDetailFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? shortDescription;
@override final  String? description;
@override final  String? sku;
@override final  String? barcode;
@override final  int? categoryId;
@override final  double price;
@override final  double? discountPrice;
@override@JsonKey() final  int stockQuantity;
@override final  double? weight;
@override final  double? width;
@override final  double? height;
@override final  double? length;
@override@JsonKey() final  bool isFeatured;
@override@JsonKey() final  bool isNew;
@override@JsonKey() final  bool isAvailable;
@override@JsonKey() final  bool isActive;
 final  List<int> _tagIds;
@override@JsonKey() List<int> get tagIds {
  if (_tagIds is EqualUnmodifiableListView) return _tagIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagIds);
}

 final  List<int> _occasionIds;
@override@JsonKey() List<int> get occasionIds {
  if (_occasionIds is EqualUnmodifiableListView) return _occasionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_occasionIds);
}

 final  List<ProductImage> _images;
@override@JsonKey() List<ProductImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of ProductDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDetailCopyWith<_ProductDetail> get copyWith => __$ProductDetailCopyWithImpl<_ProductDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.price, price) || other.price == price)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.length, length) || other.length == length)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._tagIds, _tagIds)&&const DeepCollectionEquality().equals(other._occasionIds, _occasionIds)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,shortDescription,description,sku,barcode,categoryId,price,discountPrice,stockQuantity,weight,width,height,length,isFeatured,isNew,isAvailable,isActive,const DeepCollectionEquality().hash(_tagIds),const DeepCollectionEquality().hash(_occasionIds),const DeepCollectionEquality().hash(_images)]);

@override
String toString() {
  return 'ProductDetail(id: $id, name: $name, shortDescription: $shortDescription, description: $description, sku: $sku, barcode: $barcode, categoryId: $categoryId, price: $price, discountPrice: $discountPrice, stockQuantity: $stockQuantity, weight: $weight, width: $width, height: $height, length: $length, isFeatured: $isFeatured, isNew: $isNew, isAvailable: $isAvailable, isActive: $isActive, tagIds: $tagIds, occasionIds: $occasionIds, images: $images)';
}


}

/// @nodoc
abstract mixin class _$ProductDetailCopyWith<$Res> implements $ProductDetailCopyWith<$Res> {
  factory _$ProductDetailCopyWith(_ProductDetail value, $Res Function(_ProductDetail) _then) = __$ProductDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? shortDescription, String? description, String? sku, String? barcode, int? categoryId, double price, double? discountPrice, int stockQuantity, double? weight, double? width, double? height, double? length, bool isFeatured, bool isNew, bool isAvailable, bool isActive, List<int> tagIds, List<int> occasionIds, List<ProductImage> images
});




}
/// @nodoc
class __$ProductDetailCopyWithImpl<$Res>
    implements _$ProductDetailCopyWith<$Res> {
  __$ProductDetailCopyWithImpl(this._self, this._then);

  final _ProductDetail _self;
  final $Res Function(_ProductDetail) _then;

/// Create a copy of ProductDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shortDescription = freezed,Object? description = freezed,Object? sku = freezed,Object? barcode = freezed,Object? categoryId = freezed,Object? price = null,Object? discountPrice = freezed,Object? stockQuantity = null,Object? weight = freezed,Object? width = freezed,Object? height = freezed,Object? length = freezed,Object? isFeatured = null,Object? isNew = null,Object? isAvailable = null,Object? isActive = null,Object? tagIds = null,Object? occasionIds = null,Object? images = null,}) {
  return _then(_ProductDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,tagIds: null == tagIds ? _self._tagIds : tagIds // ignore: cast_nullable_to_non_nullable
as List<int>,occasionIds: null == occasionIds ? _self._occasionIds : occasionIds // ignore: cast_nullable_to_non_nullable
as List<int>,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<ProductImage>,
  ));
}


}


/// @nodoc
mixin _$ProductImage {

 int get id; String get url; bool get isCover; int get sortOrder;
/// Create a copy of ProductImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductImageCopyWith<ProductImage> get copyWith => _$ProductImageCopyWithImpl<ProductImage>(this as ProductImage, _$identity);

  /// Serializes this ProductImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductImage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.isCover, isCover) || other.isCover == isCover)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,isCover,sortOrder);

@override
String toString() {
  return 'ProductImage(id: $id, url: $url, isCover: $isCover, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $ProductImageCopyWith<$Res>  {
  factory $ProductImageCopyWith(ProductImage value, $Res Function(ProductImage) _then) = _$ProductImageCopyWithImpl;
@useResult
$Res call({
 int id, String url, bool isCover, int sortOrder
});




}
/// @nodoc
class _$ProductImageCopyWithImpl<$Res>
    implements $ProductImageCopyWith<$Res> {
  _$ProductImageCopyWithImpl(this._self, this._then);

  final ProductImage _self;
  final $Res Function(ProductImage) _then;

/// Create a copy of ProductImage
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


/// Adds pattern-matching-related methods to [ProductImage].
extension ProductImagePatterns on ProductImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductImage value)  $default,){
final _that = this;
switch (_that) {
case _ProductImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductImage value)?  $default,){
final _that = this;
switch (_that) {
case _ProductImage() when $default != null:
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
case _ProductImage() when $default != null:
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
case _ProductImage():
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
case _ProductImage() when $default != null:
return $default(_that.id,_that.url,_that.isCover,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductImage implements ProductImage {
  const _ProductImage({required this.id, required this.url, this.isCover = false, this.sortOrder = 0});
  factory _ProductImage.fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);

@override final  int id;
@override final  String url;
@override@JsonKey() final  bool isCover;
@override@JsonKey() final  int sortOrder;

/// Create a copy of ProductImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductImageCopyWith<_ProductImage> get copyWith => __$ProductImageCopyWithImpl<_ProductImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductImage&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.isCover, isCover) || other.isCover == isCover)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url,isCover,sortOrder);

@override
String toString() {
  return 'ProductImage(id: $id, url: $url, isCover: $isCover, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$ProductImageCopyWith<$Res> implements $ProductImageCopyWith<$Res> {
  factory _$ProductImageCopyWith(_ProductImage value, $Res Function(_ProductImage) _then) = __$ProductImageCopyWithImpl;
@override @useResult
$Res call({
 int id, String url, bool isCover, int sortOrder
});




}
/// @nodoc
class __$ProductImageCopyWithImpl<$Res>
    implements _$ProductImageCopyWith<$Res> {
  __$ProductImageCopyWithImpl(this._self, this._then);

  final _ProductImage _self;
  final $Res Function(_ProductImage) _then;

/// Create a copy of ProductImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = null,Object? isCover = null,Object? sortOrder = null,}) {
  return _then(_ProductImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,isCover: null == isCover ? _self.isCover : isCover // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ProductRequest {

 String get name; int get categoryId; double get price; String? get shortDescription; String? get description; String? get sku; String? get barcode; double? get discountPrice; int get stockQuantity; double? get weight; double? get width; double? get height; double? get length; bool get isFeatured; bool get isNew; bool get isAvailable; bool get isActive; List<int> get tagIds; List<int> get occasionIds; List<int> get removeImageIds; int? get coverImageId;
/// Create a copy of ProductRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductRequestCopyWith<ProductRequest> get copyWith => _$ProductRequestCopyWithImpl<ProductRequest>(this as ProductRequest, _$identity);

  /// Serializes this ProductRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.price, price) || other.price == price)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.length, length) || other.length == length)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.tagIds, tagIds)&&const DeepCollectionEquality().equals(other.occasionIds, occasionIds)&&const DeepCollectionEquality().equals(other.removeImageIds, removeImageIds)&&(identical(other.coverImageId, coverImageId) || other.coverImageId == coverImageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,name,categoryId,price,shortDescription,description,sku,barcode,discountPrice,stockQuantity,weight,width,height,length,isFeatured,isNew,isAvailable,isActive,const DeepCollectionEquality().hash(tagIds),const DeepCollectionEquality().hash(occasionIds),const DeepCollectionEquality().hash(removeImageIds),coverImageId]);

@override
String toString() {
  return 'ProductRequest(name: $name, categoryId: $categoryId, price: $price, shortDescription: $shortDescription, description: $description, sku: $sku, barcode: $barcode, discountPrice: $discountPrice, stockQuantity: $stockQuantity, weight: $weight, width: $width, height: $height, length: $length, isFeatured: $isFeatured, isNew: $isNew, isAvailable: $isAvailable, isActive: $isActive, tagIds: $tagIds, occasionIds: $occasionIds, removeImageIds: $removeImageIds, coverImageId: $coverImageId)';
}


}

/// @nodoc
abstract mixin class $ProductRequestCopyWith<$Res>  {
  factory $ProductRequestCopyWith(ProductRequest value, $Res Function(ProductRequest) _then) = _$ProductRequestCopyWithImpl;
@useResult
$Res call({
 String name, int categoryId, double price, String? shortDescription, String? description, String? sku, String? barcode, double? discountPrice, int stockQuantity, double? weight, double? width, double? height, double? length, bool isFeatured, bool isNew, bool isAvailable, bool isActive, List<int> tagIds, List<int> occasionIds, List<int> removeImageIds, int? coverImageId
});




}
/// @nodoc
class _$ProductRequestCopyWithImpl<$Res>
    implements $ProductRequestCopyWith<$Res> {
  _$ProductRequestCopyWithImpl(this._self, this._then);

  final ProductRequest _self;
  final $Res Function(ProductRequest) _then;

/// Create a copy of ProductRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? categoryId = null,Object? price = null,Object? shortDescription = freezed,Object? description = freezed,Object? sku = freezed,Object? barcode = freezed,Object? discountPrice = freezed,Object? stockQuantity = null,Object? weight = freezed,Object? width = freezed,Object? height = freezed,Object? length = freezed,Object? isFeatured = null,Object? isNew = null,Object? isAvailable = null,Object? isActive = null,Object? tagIds = null,Object? occasionIds = null,Object? removeImageIds = null,Object? coverImageId = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,tagIds: null == tagIds ? _self.tagIds : tagIds // ignore: cast_nullable_to_non_nullable
as List<int>,occasionIds: null == occasionIds ? _self.occasionIds : occasionIds // ignore: cast_nullable_to_non_nullable
as List<int>,removeImageIds: null == removeImageIds ? _self.removeImageIds : removeImageIds // ignore: cast_nullable_to_non_nullable
as List<int>,coverImageId: freezed == coverImageId ? _self.coverImageId : coverImageId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductRequest].
extension ProductRequestPatterns on ProductRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductRequest value)  $default,){
final _that = this;
switch (_that) {
case _ProductRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ProductRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int categoryId,  double price,  String? shortDescription,  String? description,  String? sku,  String? barcode,  double? discountPrice,  int stockQuantity,  double? weight,  double? width,  double? height,  double? length,  bool isFeatured,  bool isNew,  bool isAvailable,  bool isActive,  List<int> tagIds,  List<int> occasionIds,  List<int> removeImageIds,  int? coverImageId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductRequest() when $default != null:
return $default(_that.name,_that.categoryId,_that.price,_that.shortDescription,_that.description,_that.sku,_that.barcode,_that.discountPrice,_that.stockQuantity,_that.weight,_that.width,_that.height,_that.length,_that.isFeatured,_that.isNew,_that.isAvailable,_that.isActive,_that.tagIds,_that.occasionIds,_that.removeImageIds,_that.coverImageId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int categoryId,  double price,  String? shortDescription,  String? description,  String? sku,  String? barcode,  double? discountPrice,  int stockQuantity,  double? weight,  double? width,  double? height,  double? length,  bool isFeatured,  bool isNew,  bool isAvailable,  bool isActive,  List<int> tagIds,  List<int> occasionIds,  List<int> removeImageIds,  int? coverImageId)  $default,) {final _that = this;
switch (_that) {
case _ProductRequest():
return $default(_that.name,_that.categoryId,_that.price,_that.shortDescription,_that.description,_that.sku,_that.barcode,_that.discountPrice,_that.stockQuantity,_that.weight,_that.width,_that.height,_that.length,_that.isFeatured,_that.isNew,_that.isAvailable,_that.isActive,_that.tagIds,_that.occasionIds,_that.removeImageIds,_that.coverImageId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int categoryId,  double price,  String? shortDescription,  String? description,  String? sku,  String? barcode,  double? discountPrice,  int stockQuantity,  double? weight,  double? width,  double? height,  double? length,  bool isFeatured,  bool isNew,  bool isAvailable,  bool isActive,  List<int> tagIds,  List<int> occasionIds,  List<int> removeImageIds,  int? coverImageId)?  $default,) {final _that = this;
switch (_that) {
case _ProductRequest() when $default != null:
return $default(_that.name,_that.categoryId,_that.price,_that.shortDescription,_that.description,_that.sku,_that.barcode,_that.discountPrice,_that.stockQuantity,_that.weight,_that.width,_that.height,_that.length,_that.isFeatured,_that.isNew,_that.isAvailable,_that.isActive,_that.tagIds,_that.occasionIds,_that.removeImageIds,_that.coverImageId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductRequest implements ProductRequest {
  const _ProductRequest({required this.name, required this.categoryId, required this.price, this.shortDescription, this.description, this.sku, this.barcode, this.discountPrice, this.stockQuantity = 0, this.weight, this.width, this.height, this.length, this.isFeatured = false, this.isNew = false, this.isAvailable = true, this.isActive = true, final  List<int> tagIds = const [], final  List<int> occasionIds = const [], final  List<int> removeImageIds = const [], this.coverImageId}): _tagIds = tagIds,_occasionIds = occasionIds,_removeImageIds = removeImageIds;
  factory _ProductRequest.fromJson(Map<String, dynamic> json) => _$ProductRequestFromJson(json);

@override final  String name;
@override final  int categoryId;
@override final  double price;
@override final  String? shortDescription;
@override final  String? description;
@override final  String? sku;
@override final  String? barcode;
@override final  double? discountPrice;
@override@JsonKey() final  int stockQuantity;
@override final  double? weight;
@override final  double? width;
@override final  double? height;
@override final  double? length;
@override@JsonKey() final  bool isFeatured;
@override@JsonKey() final  bool isNew;
@override@JsonKey() final  bool isAvailable;
@override@JsonKey() final  bool isActive;
 final  List<int> _tagIds;
@override@JsonKey() List<int> get tagIds {
  if (_tagIds is EqualUnmodifiableListView) return _tagIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagIds);
}

 final  List<int> _occasionIds;
@override@JsonKey() List<int> get occasionIds {
  if (_occasionIds is EqualUnmodifiableListView) return _occasionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_occasionIds);
}

 final  List<int> _removeImageIds;
@override@JsonKey() List<int> get removeImageIds {
  if (_removeImageIds is EqualUnmodifiableListView) return _removeImageIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_removeImageIds);
}

@override final  int? coverImageId;

/// Create a copy of ProductRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductRequestCopyWith<_ProductRequest> get copyWith => __$ProductRequestCopyWithImpl<_ProductRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.price, price) || other.price == price)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.length, length) || other.length == length)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._tagIds, _tagIds)&&const DeepCollectionEquality().equals(other._occasionIds, _occasionIds)&&const DeepCollectionEquality().equals(other._removeImageIds, _removeImageIds)&&(identical(other.coverImageId, coverImageId) || other.coverImageId == coverImageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,name,categoryId,price,shortDescription,description,sku,barcode,discountPrice,stockQuantity,weight,width,height,length,isFeatured,isNew,isAvailable,isActive,const DeepCollectionEquality().hash(_tagIds),const DeepCollectionEquality().hash(_occasionIds),const DeepCollectionEquality().hash(_removeImageIds),coverImageId]);

@override
String toString() {
  return 'ProductRequest(name: $name, categoryId: $categoryId, price: $price, shortDescription: $shortDescription, description: $description, sku: $sku, barcode: $barcode, discountPrice: $discountPrice, stockQuantity: $stockQuantity, weight: $weight, width: $width, height: $height, length: $length, isFeatured: $isFeatured, isNew: $isNew, isAvailable: $isAvailable, isActive: $isActive, tagIds: $tagIds, occasionIds: $occasionIds, removeImageIds: $removeImageIds, coverImageId: $coverImageId)';
}


}

/// @nodoc
abstract mixin class _$ProductRequestCopyWith<$Res> implements $ProductRequestCopyWith<$Res> {
  factory _$ProductRequestCopyWith(_ProductRequest value, $Res Function(_ProductRequest) _then) = __$ProductRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, int categoryId, double price, String? shortDescription, String? description, String? sku, String? barcode, double? discountPrice, int stockQuantity, double? weight, double? width, double? height, double? length, bool isFeatured, bool isNew, bool isAvailable, bool isActive, List<int> tagIds, List<int> occasionIds, List<int> removeImageIds, int? coverImageId
});




}
/// @nodoc
class __$ProductRequestCopyWithImpl<$Res>
    implements _$ProductRequestCopyWith<$Res> {
  __$ProductRequestCopyWithImpl(this._self, this._then);

  final _ProductRequest _self;
  final $Res Function(_ProductRequest) _then;

/// Create a copy of ProductRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? categoryId = null,Object? price = null,Object? shortDescription = freezed,Object? description = freezed,Object? sku = freezed,Object? barcode = freezed,Object? discountPrice = freezed,Object? stockQuantity = null,Object? weight = freezed,Object? width = freezed,Object? height = freezed,Object? length = freezed,Object? isFeatured = null,Object? isNew = null,Object? isAvailable = null,Object? isActive = null,Object? tagIds = null,Object? occasionIds = null,Object? removeImageIds = null,Object? coverImageId = freezed,}) {
  return _then(_ProductRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,barcode: freezed == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String?,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,tagIds: null == tagIds ? _self._tagIds : tagIds // ignore: cast_nullable_to_non_nullable
as List<int>,occasionIds: null == occasionIds ? _self._occasionIds : occasionIds // ignore: cast_nullable_to_non_nullable
as List<int>,removeImageIds: null == removeImageIds ? _self._removeImageIds : removeImageIds // ignore: cast_nullable_to_non_nullable
as List<int>,coverImageId: freezed == coverImageId ? _self.coverImageId : coverImageId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$ProductFilter {

 String? get search; int? get categoryId; double? get minPrice; double? get maxPrice; bool? get isActive; String get sort; int get page; int get pageSize;
/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFilterCopyWith<ProductFilter> get copyWith => _$ProductFilterCopyWithImpl<ProductFilter>(this as ProductFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFilter&&(identical(other.search, search) || other.search == search)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,search,categoryId,minPrice,maxPrice,isActive,sort,page,pageSize);

@override
String toString() {
  return 'ProductFilter(search: $search, categoryId: $categoryId, minPrice: $minPrice, maxPrice: $maxPrice, isActive: $isActive, sort: $sort, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $ProductFilterCopyWith<$Res>  {
  factory $ProductFilterCopyWith(ProductFilter value, $Res Function(ProductFilter) _then) = _$ProductFilterCopyWithImpl;
@useResult
$Res call({
 String? search, int? categoryId, double? minPrice, double? maxPrice, bool? isActive, String sort, int page, int pageSize
});




}
/// @nodoc
class _$ProductFilterCopyWithImpl<$Res>
    implements $ProductFilterCopyWith<$Res> {
  _$ProductFilterCopyWithImpl(this._self, this._then);

  final ProductFilter _self;
  final $Res Function(ProductFilter) _then;

/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? search = freezed,Object? categoryId = freezed,Object? minPrice = freezed,Object? maxPrice = freezed,Object? isActive = freezed,Object? sort = null,Object? page = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductFilter].
extension ProductFilterPatterns on ProductFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductFilter value)  $default,){
final _that = this;
switch (_that) {
case _ProductFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductFilter value)?  $default,){
final _that = this;
switch (_that) {
case _ProductFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? search,  int? categoryId,  double? minPrice,  double? maxPrice,  bool? isActive,  String sort,  int page,  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductFilter() when $default != null:
return $default(_that.search,_that.categoryId,_that.minPrice,_that.maxPrice,_that.isActive,_that.sort,_that.page,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? search,  int? categoryId,  double? minPrice,  double? maxPrice,  bool? isActive,  String sort,  int page,  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _ProductFilter():
return $default(_that.search,_that.categoryId,_that.minPrice,_that.maxPrice,_that.isActive,_that.sort,_that.page,_that.pageSize);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? search,  int? categoryId,  double? minPrice,  double? maxPrice,  bool? isActive,  String sort,  int page,  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _ProductFilter() when $default != null:
return $default(_that.search,_that.categoryId,_that.minPrice,_that.maxPrice,_that.isActive,_that.sort,_that.page,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc


class _ProductFilter implements ProductFilter {
  const _ProductFilter({this.search, this.categoryId, this.minPrice, this.maxPrice, this.isActive, this.sort = 'Newest', this.page = 1, this.pageSize = 12});
  

@override final  String? search;
@override final  int? categoryId;
@override final  double? minPrice;
@override final  double? maxPrice;
@override final  bool? isActive;
@override@JsonKey() final  String sort;
@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;

/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductFilterCopyWith<_ProductFilter> get copyWith => __$ProductFilterCopyWithImpl<_ProductFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductFilter&&(identical(other.search, search) || other.search == search)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,search,categoryId,minPrice,maxPrice,isActive,sort,page,pageSize);

@override
String toString() {
  return 'ProductFilter(search: $search, categoryId: $categoryId, minPrice: $minPrice, maxPrice: $maxPrice, isActive: $isActive, sort: $sort, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$ProductFilterCopyWith<$Res> implements $ProductFilterCopyWith<$Res> {
  factory _$ProductFilterCopyWith(_ProductFilter value, $Res Function(_ProductFilter) _then) = __$ProductFilterCopyWithImpl;
@override @useResult
$Res call({
 String? search, int? categoryId, double? minPrice, double? maxPrice, bool? isActive, String sort, int page, int pageSize
});




}
/// @nodoc
class __$ProductFilterCopyWithImpl<$Res>
    implements _$ProductFilterCopyWith<$Res> {
  __$ProductFilterCopyWithImpl(this._self, this._then);

  final _ProductFilter _self;
  final $Res Function(_ProductFilter) _then;

/// Create a copy of ProductFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? search = freezed,Object? categoryId = freezed,Object? minPrice = freezed,Object? maxPrice = freezed,Object? isActive = freezed,Object? sort = null,Object? page = null,Object? pageSize = null,}) {
  return _then(_ProductFilter(
search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
