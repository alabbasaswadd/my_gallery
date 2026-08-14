// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductsListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsListState()';
}


}

/// @nodoc
class $ProductsListStateCopyWith<$Res>  {
$ProductsListStateCopyWith(ProductsListState _, $Res Function(ProductsListState) __);
}


/// Adds pattern-matching-related methods to [ProductsListState].
extension ProductsListStatePatterns on ProductsListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductsListInitial value)?  initial,TResult Function( ProductsListLoading value)?  loading,TResult Function( ProductsListLoaded value)?  loaded,TResult Function( ProductsListError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductsListInitial() when initial != null:
return initial(_that);case ProductsListLoading() when loading != null:
return loading(_that);case ProductsListLoaded() when loaded != null:
return loaded(_that);case ProductsListError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductsListInitial value)  initial,required TResult Function( ProductsListLoading value)  loading,required TResult Function( ProductsListLoaded value)  loaded,required TResult Function( ProductsListError value)  error,}){
final _that = this;
switch (_that) {
case ProductsListInitial():
return initial(_that);case ProductsListLoading():
return loading(_that);case ProductsListLoaded():
return loaded(_that);case ProductsListError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductsListInitial value)?  initial,TResult? Function( ProductsListLoading value)?  loading,TResult? Function( ProductsListLoaded value)?  loaded,TResult? Function( ProductsListError value)?  error,}){
final _that = this;
switch (_that) {
case ProductsListInitial() when initial != null:
return initial(_that);case ProductsListLoading() when loading != null:
return loading(_that);case ProductsListLoaded() when loaded != null:
return loaded(_that);case ProductsListError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ProductListItem> items,  PaginationMeta pagination,  ProductFilter filter)?  loaded,TResult Function( String message,  ApiErrorKind? kind)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductsListInitial() when initial != null:
return initial();case ProductsListLoading() when loading != null:
return loading();case ProductsListLoaded() when loaded != null:
return loaded(_that.items,_that.pagination,_that.filter);case ProductsListError() when error != null:
return error(_that.message,_that.kind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ProductListItem> items,  PaginationMeta pagination,  ProductFilter filter)  loaded,required TResult Function( String message,  ApiErrorKind? kind)  error,}) {final _that = this;
switch (_that) {
case ProductsListInitial():
return initial();case ProductsListLoading():
return loading();case ProductsListLoaded():
return loaded(_that.items,_that.pagination,_that.filter);case ProductsListError():
return error(_that.message,_that.kind);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ProductListItem> items,  PaginationMeta pagination,  ProductFilter filter)?  loaded,TResult? Function( String message,  ApiErrorKind? kind)?  error,}) {final _that = this;
switch (_that) {
case ProductsListInitial() when initial != null:
return initial();case ProductsListLoading() when loading != null:
return loading();case ProductsListLoaded() when loaded != null:
return loaded(_that.items,_that.pagination,_that.filter);case ProductsListError() when error != null:
return error(_that.message,_that.kind);case _:
  return null;

}
}

}

/// @nodoc


class ProductsListInitial implements ProductsListState {
  const ProductsListInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsListInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsListState.initial()';
}


}




/// @nodoc


class ProductsListLoading implements ProductsListState {
  const ProductsListLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsListLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductsListState.loading()';
}


}




/// @nodoc


class ProductsListLoaded implements ProductsListState {
  const ProductsListLoaded({required final  List<ProductListItem> items, required this.pagination, required this.filter}): _items = items;
  

 final  List<ProductListItem> _items;
 List<ProductListItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  PaginationMeta pagination;
 final  ProductFilter filter;

/// Create a copy of ProductsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductsListLoadedCopyWith<ProductsListLoaded> get copyWith => _$ProductsListLoadedCopyWithImpl<ProductsListLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsListLoaded&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),pagination,filter);

@override
String toString() {
  return 'ProductsListState.loaded(items: $items, pagination: $pagination, filter: $filter)';
}


}

/// @nodoc
abstract mixin class $ProductsListLoadedCopyWith<$Res> implements $ProductsListStateCopyWith<$Res> {
  factory $ProductsListLoadedCopyWith(ProductsListLoaded value, $Res Function(ProductsListLoaded) _then) = _$ProductsListLoadedCopyWithImpl;
@useResult
$Res call({
 List<ProductListItem> items, PaginationMeta pagination, ProductFilter filter
});


$PaginationMetaCopyWith<$Res> get pagination;$ProductFilterCopyWith<$Res> get filter;

}
/// @nodoc
class _$ProductsListLoadedCopyWithImpl<$Res>
    implements $ProductsListLoadedCopyWith<$Res> {
  _$ProductsListLoadedCopyWithImpl(this._self, this._then);

  final ProductsListLoaded _self;
  final $Res Function(ProductsListLoaded) _then;

/// Create a copy of ProductsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? pagination = null,Object? filter = null,}) {
  return _then(ProductsListLoaded(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ProductListItem>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationMeta,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ProductFilter,
  ));
}

/// Create a copy of ProductsListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationMetaCopyWith<$Res> get pagination {
  
  return $PaginationMetaCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}/// Create a copy of ProductsListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductFilterCopyWith<$Res> get filter {
  
  return $ProductFilterCopyWith<$Res>(_self.filter, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}

/// @nodoc


class ProductsListError implements ProductsListState {
  const ProductsListError(this.message, [this.kind]);
  

 final  String message;
 final  ApiErrorKind? kind;

/// Create a copy of ProductsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductsListErrorCopyWith<ProductsListError> get copyWith => _$ProductsListErrorCopyWithImpl<ProductsListError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsListError&&(identical(other.message, message) || other.message == message)&&(identical(other.kind, kind) || other.kind == kind));
}


@override
int get hashCode => Object.hash(runtimeType,message,kind);

@override
String toString() {
  return 'ProductsListState.error(message: $message, kind: $kind)';
}


}

/// @nodoc
abstract mixin class $ProductsListErrorCopyWith<$Res> implements $ProductsListStateCopyWith<$Res> {
  factory $ProductsListErrorCopyWith(ProductsListError value, $Res Function(ProductsListError) _then) = _$ProductsListErrorCopyWithImpl;
@useResult
$Res call({
 String message, ApiErrorKind? kind
});




}
/// @nodoc
class _$ProductsListErrorCopyWithImpl<$Res>
    implements $ProductsListErrorCopyWith<$Res> {
  _$ProductsListErrorCopyWithImpl(this._self, this._then);

  final ProductsListError _self;
  final $Res Function(ProductsListError) _then;

/// Create a copy of ProductsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? kind = freezed,}) {
  return _then(ProductsListError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ApiErrorKind?,
  ));
}


}

// dart format on
