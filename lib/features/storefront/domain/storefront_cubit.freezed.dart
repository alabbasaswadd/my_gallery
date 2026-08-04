// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storefront_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StorefrontState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StorefrontState()';
}


}

/// @nodoc
class $StorefrontStateCopyWith<$Res>  {
$StorefrontStateCopyWith(StorefrontState _, $Res Function(StorefrontState) __);
}


/// Adds pattern-matching-related methods to [StorefrontState].
extension StorefrontStatePatterns on StorefrontState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StorefrontInitial value)?  initial,TResult Function( StorefrontLoading value)?  loading,TResult Function( StorefrontLoaded value)?  loaded,TResult Function( StorefrontError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StorefrontInitial() when initial != null:
return initial(_that);case StorefrontLoading() when loading != null:
return loading(_that);case StorefrontLoaded() when loaded != null:
return loaded(_that);case StorefrontError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StorefrontInitial value)  initial,required TResult Function( StorefrontLoading value)  loading,required TResult Function( StorefrontLoaded value)  loaded,required TResult Function( StorefrontError value)  error,}){
final _that = this;
switch (_that) {
case StorefrontInitial():
return initial(_that);case StorefrontLoading():
return loading(_that);case StorefrontLoaded():
return loaded(_that);case StorefrontError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StorefrontInitial value)?  initial,TResult? Function( StorefrontLoading value)?  loading,TResult? Function( StorefrontLoaded value)?  loaded,TResult? Function( StorefrontError value)?  error,}){
final _that = this;
switch (_that) {
case StorefrontInitial() when initial != null:
return initial(_that);case StorefrontLoading() when loading != null:
return loading(_that);case StorefrontLoaded() when loaded != null:
return loaded(_that);case StorefrontError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<StorefrontProduct> products,  PaginationMeta pagination,  List<StorefrontCategory> categories,  int? selectedCategoryId,  String? search)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StorefrontInitial() when initial != null:
return initial();case StorefrontLoading() when loading != null:
return loading();case StorefrontLoaded() when loaded != null:
return loaded(_that.products,_that.pagination,_that.categories,_that.selectedCategoryId,_that.search);case StorefrontError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<StorefrontProduct> products,  PaginationMeta pagination,  List<StorefrontCategory> categories,  int? selectedCategoryId,  String? search)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case StorefrontInitial():
return initial();case StorefrontLoading():
return loading();case StorefrontLoaded():
return loaded(_that.products,_that.pagination,_that.categories,_that.selectedCategoryId,_that.search);case StorefrontError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<StorefrontProduct> products,  PaginationMeta pagination,  List<StorefrontCategory> categories,  int? selectedCategoryId,  String? search)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case StorefrontInitial() when initial != null:
return initial();case StorefrontLoading() when loading != null:
return loading();case StorefrontLoaded() when loaded != null:
return loaded(_that.products,_that.pagination,_that.categories,_that.selectedCategoryId,_that.search);case StorefrontError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class StorefrontInitial implements StorefrontState {
  const StorefrontInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StorefrontState.initial()';
}


}




/// @nodoc


class StorefrontLoading implements StorefrontState {
  const StorefrontLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StorefrontState.loading()';
}


}




/// @nodoc


class StorefrontLoaded implements StorefrontState {
  const StorefrontLoaded({required final  List<StorefrontProduct> products, required this.pagination, required final  List<StorefrontCategory> categories, this.selectedCategoryId, this.search}): _products = products,_categories = categories;
  

 final  List<StorefrontProduct> _products;
 List<StorefrontProduct> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  PaginationMeta pagination;
 final  List<StorefrontCategory> _categories;
 List<StorefrontCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  int? selectedCategoryId;
 final  String? search;

/// Create a copy of StorefrontState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorefrontLoadedCopyWith<StorefrontLoaded> get copyWith => _$StorefrontLoadedCopyWithImpl<StorefrontLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontLoaded&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),pagination,const DeepCollectionEquality().hash(_categories),selectedCategoryId,search);

@override
String toString() {
  return 'StorefrontState.loaded(products: $products, pagination: $pagination, categories: $categories, selectedCategoryId: $selectedCategoryId, search: $search)';
}


}

/// @nodoc
abstract mixin class $StorefrontLoadedCopyWith<$Res> implements $StorefrontStateCopyWith<$Res> {
  factory $StorefrontLoadedCopyWith(StorefrontLoaded value, $Res Function(StorefrontLoaded) _then) = _$StorefrontLoadedCopyWithImpl;
@useResult
$Res call({
 List<StorefrontProduct> products, PaginationMeta pagination, List<StorefrontCategory> categories, int? selectedCategoryId, String? search
});


$PaginationMetaCopyWith<$Res> get pagination;

}
/// @nodoc
class _$StorefrontLoadedCopyWithImpl<$Res>
    implements $StorefrontLoadedCopyWith<$Res> {
  _$StorefrontLoadedCopyWithImpl(this._self, this._then);

  final StorefrontLoaded _self;
  final $Res Function(StorefrontLoaded) _then;

/// Create a copy of StorefrontState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? pagination = null,Object? categories = null,Object? selectedCategoryId = freezed,Object? search = freezed,}) {
  return _then(StorefrontLoaded(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<StorefrontProduct>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationMeta,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<StorefrontCategory>,selectedCategoryId: freezed == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as int?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of StorefrontState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationMetaCopyWith<$Res> get pagination {
  
  return $PaginationMetaCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}

/// @nodoc


class StorefrontError implements StorefrontState {
  const StorefrontError(this.message);
  

 final  String message;

/// Create a copy of StorefrontState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorefrontErrorCopyWith<StorefrontError> get copyWith => _$StorefrontErrorCopyWithImpl<StorefrontError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorefrontError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'StorefrontState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $StorefrontErrorCopyWith<$Res> implements $StorefrontStateCopyWith<$Res> {
  factory $StorefrontErrorCopyWith(StorefrontError value, $Res Function(StorefrontError) _then) = _$StorefrontErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$StorefrontErrorCopyWithImpl<$Res>
    implements $StorefrontErrorCopyWith<$Res> {
  _$StorefrontErrorCopyWithImpl(this._self, this._then);

  final StorefrontError _self;
  final $Res Function(StorefrontError) _then;

/// Create a copy of StorefrontState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(StorefrontError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
