// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductFormState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductFormState()';
}


}

/// @nodoc
class $ProductFormStateCopyWith<$Res>  {
$ProductFormStateCopyWith(ProductFormState _, $Res Function(ProductFormState) __);
}


/// Adds pattern-matching-related methods to [ProductFormState].
extension ProductFormStatePatterns on ProductFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductFormInitial value)?  initial,TResult Function( ProductFormLoading value)?  loading,TResult Function( ProductFormSuccess value)?  success,TResult Function( ProductFormError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductFormInitial() when initial != null:
return initial(_that);case ProductFormLoading() when loading != null:
return loading(_that);case ProductFormSuccess() when success != null:
return success(_that);case ProductFormError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductFormInitial value)  initial,required TResult Function( ProductFormLoading value)  loading,required TResult Function( ProductFormSuccess value)  success,required TResult Function( ProductFormError value)  error,}){
final _that = this;
switch (_that) {
case ProductFormInitial():
return initial(_that);case ProductFormLoading():
return loading(_that);case ProductFormSuccess():
return success(_that);case ProductFormError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductFormInitial value)?  initial,TResult? Function( ProductFormLoading value)?  loading,TResult? Function( ProductFormSuccess value)?  success,TResult? Function( ProductFormError value)?  error,}){
final _that = this;
switch (_that) {
case ProductFormInitial() when initial != null:
return initial(_that);case ProductFormLoading() when loading != null:
return loading(_that);case ProductFormSuccess() when success != null:
return success(_that);case ProductFormError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( int productId)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductFormInitial() when initial != null:
return initial();case ProductFormLoading() when loading != null:
return loading();case ProductFormSuccess() when success != null:
return success(_that.productId);case ProductFormError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( int productId)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ProductFormInitial():
return initial();case ProductFormLoading():
return loading();case ProductFormSuccess():
return success(_that.productId);case ProductFormError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( int productId)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ProductFormInitial() when initial != null:
return initial();case ProductFormLoading() when loading != null:
return loading();case ProductFormSuccess() when success != null:
return success(_that.productId);case ProductFormError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ProductFormInitial implements ProductFormState {
  const ProductFormInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductFormState.initial()';
}


}




/// @nodoc


class ProductFormLoading implements ProductFormState {
  const ProductFormLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductFormState.loading()';
}


}




/// @nodoc


class ProductFormSuccess implements ProductFormState {
  const ProductFormSuccess(this.productId);
  

 final  int productId;

/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFormSuccessCopyWith<ProductFormSuccess> get copyWith => _$ProductFormSuccessCopyWithImpl<ProductFormSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormSuccess&&(identical(other.productId, productId) || other.productId == productId));
}


@override
int get hashCode => Object.hash(runtimeType,productId);

@override
String toString() {
  return 'ProductFormState.success(productId: $productId)';
}


}

/// @nodoc
abstract mixin class $ProductFormSuccessCopyWith<$Res> implements $ProductFormStateCopyWith<$Res> {
  factory $ProductFormSuccessCopyWith(ProductFormSuccess value, $Res Function(ProductFormSuccess) _then) = _$ProductFormSuccessCopyWithImpl;
@useResult
$Res call({
 int productId
});




}
/// @nodoc
class _$ProductFormSuccessCopyWithImpl<$Res>
    implements $ProductFormSuccessCopyWith<$Res> {
  _$ProductFormSuccessCopyWithImpl(this._self, this._then);

  final ProductFormSuccess _self;
  final $Res Function(ProductFormSuccess) _then;

/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,}) {
  return _then(ProductFormSuccess(
null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ProductFormError implements ProductFormState {
  const ProductFormError(this.message);
  

 final  String message;

/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFormErrorCopyWith<ProductFormError> get copyWith => _$ProductFormErrorCopyWithImpl<ProductFormError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProductFormState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ProductFormErrorCopyWith<$Res> implements $ProductFormStateCopyWith<$Res> {
  factory $ProductFormErrorCopyWith(ProductFormError value, $Res Function(ProductFormError) _then) = _$ProductFormErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ProductFormErrorCopyWithImpl<$Res>
    implements $ProductFormErrorCopyWith<$Res> {
  _$ProductFormErrorCopyWithImpl(this._self, this._then);

  final ProductFormError _self;
  final $Res Function(ProductFormError) _then;

/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ProductFormError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
