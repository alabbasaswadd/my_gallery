// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryFormState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryFormState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryFormState()';
}


}

/// @nodoc
class $CategoryFormStateCopyWith<$Res>  {
$CategoryFormStateCopyWith(CategoryFormState _, $Res Function(CategoryFormState) __);
}


/// Adds pattern-matching-related methods to [CategoryFormState].
extension CategoryFormStatePatterns on CategoryFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CategoryFormInitial value)?  initial,TResult Function( CategoryFormLoading value)?  loading,TResult Function( CategoryFormSuccess value)?  success,TResult Function( CategoryFormSuccessWithImageWarning value)?  successWithImageWarning,TResult Function( CategoryFormError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CategoryFormInitial() when initial != null:
return initial(_that);case CategoryFormLoading() when loading != null:
return loading(_that);case CategoryFormSuccess() when success != null:
return success(_that);case CategoryFormSuccessWithImageWarning() when successWithImageWarning != null:
return successWithImageWarning(_that);case CategoryFormError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CategoryFormInitial value)  initial,required TResult Function( CategoryFormLoading value)  loading,required TResult Function( CategoryFormSuccess value)  success,required TResult Function( CategoryFormSuccessWithImageWarning value)  successWithImageWarning,required TResult Function( CategoryFormError value)  error,}){
final _that = this;
switch (_that) {
case CategoryFormInitial():
return initial(_that);case CategoryFormLoading():
return loading(_that);case CategoryFormSuccess():
return success(_that);case CategoryFormSuccessWithImageWarning():
return successWithImageWarning(_that);case CategoryFormError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CategoryFormInitial value)?  initial,TResult? Function( CategoryFormLoading value)?  loading,TResult? Function( CategoryFormSuccess value)?  success,TResult? Function( CategoryFormSuccessWithImageWarning value)?  successWithImageWarning,TResult? Function( CategoryFormError value)?  error,}){
final _that = this;
switch (_that) {
case CategoryFormInitial() when initial != null:
return initial(_that);case CategoryFormLoading() when loading != null:
return loading(_that);case CategoryFormSuccess() when success != null:
return success(_that);case CategoryFormSuccessWithImageWarning() when successWithImageWarning != null:
return successWithImageWarning(_that);case CategoryFormError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( int categoryId)?  success,TResult Function( int categoryId)?  successWithImageWarning,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CategoryFormInitial() when initial != null:
return initial();case CategoryFormLoading() when loading != null:
return loading();case CategoryFormSuccess() when success != null:
return success(_that.categoryId);case CategoryFormSuccessWithImageWarning() when successWithImageWarning != null:
return successWithImageWarning(_that.categoryId);case CategoryFormError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( int categoryId)  success,required TResult Function( int categoryId)  successWithImageWarning,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case CategoryFormInitial():
return initial();case CategoryFormLoading():
return loading();case CategoryFormSuccess():
return success(_that.categoryId);case CategoryFormSuccessWithImageWarning():
return successWithImageWarning(_that.categoryId);case CategoryFormError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( int categoryId)?  success,TResult? Function( int categoryId)?  successWithImageWarning,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case CategoryFormInitial() when initial != null:
return initial();case CategoryFormLoading() when loading != null:
return loading();case CategoryFormSuccess() when success != null:
return success(_that.categoryId);case CategoryFormSuccessWithImageWarning() when successWithImageWarning != null:
return successWithImageWarning(_that.categoryId);case CategoryFormError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CategoryFormInitial implements CategoryFormState {
  const CategoryFormInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryFormInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryFormState.initial()';
}


}




/// @nodoc


class CategoryFormLoading implements CategoryFormState {
  const CategoryFormLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryFormLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryFormState.loading()';
}


}




/// @nodoc


class CategoryFormSuccess implements CategoryFormState {
  const CategoryFormSuccess(this.categoryId);
  

 final  int categoryId;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryFormSuccessCopyWith<CategoryFormSuccess> get copyWith => _$CategoryFormSuccessCopyWithImpl<CategoryFormSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryFormSuccess&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId);

@override
String toString() {
  return 'CategoryFormState.success(categoryId: $categoryId)';
}


}

/// @nodoc
abstract mixin class $CategoryFormSuccessCopyWith<$Res> implements $CategoryFormStateCopyWith<$Res> {
  factory $CategoryFormSuccessCopyWith(CategoryFormSuccess value, $Res Function(CategoryFormSuccess) _then) = _$CategoryFormSuccessCopyWithImpl;
@useResult
$Res call({
 int categoryId
});




}
/// @nodoc
class _$CategoryFormSuccessCopyWithImpl<$Res>
    implements $CategoryFormSuccessCopyWith<$Res> {
  _$CategoryFormSuccessCopyWithImpl(this._self, this._then);

  final CategoryFormSuccess _self;
  final $Res Function(CategoryFormSuccess) _then;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categoryId = null,}) {
  return _then(CategoryFormSuccess(
null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CategoryFormSuccessWithImageWarning implements CategoryFormState {
  const CategoryFormSuccessWithImageWarning(this.categoryId);
  

 final  int categoryId;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryFormSuccessWithImageWarningCopyWith<CategoryFormSuccessWithImageWarning> get copyWith => _$CategoryFormSuccessWithImageWarningCopyWithImpl<CategoryFormSuccessWithImageWarning>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryFormSuccessWithImageWarning&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId);

@override
String toString() {
  return 'CategoryFormState.successWithImageWarning(categoryId: $categoryId)';
}


}

/// @nodoc
abstract mixin class $CategoryFormSuccessWithImageWarningCopyWith<$Res> implements $CategoryFormStateCopyWith<$Res> {
  factory $CategoryFormSuccessWithImageWarningCopyWith(CategoryFormSuccessWithImageWarning value, $Res Function(CategoryFormSuccessWithImageWarning) _then) = _$CategoryFormSuccessWithImageWarningCopyWithImpl;
@useResult
$Res call({
 int categoryId
});




}
/// @nodoc
class _$CategoryFormSuccessWithImageWarningCopyWithImpl<$Res>
    implements $CategoryFormSuccessWithImageWarningCopyWith<$Res> {
  _$CategoryFormSuccessWithImageWarningCopyWithImpl(this._self, this._then);

  final CategoryFormSuccessWithImageWarning _self;
  final $Res Function(CategoryFormSuccessWithImageWarning) _then;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categoryId = null,}) {
  return _then(CategoryFormSuccessWithImageWarning(
null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CategoryFormError implements CategoryFormState {
  const CategoryFormError(this.message);
  

 final  String message;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryFormErrorCopyWith<CategoryFormError> get copyWith => _$CategoryFormErrorCopyWithImpl<CategoryFormError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryFormError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CategoryFormState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CategoryFormErrorCopyWith<$Res> implements $CategoryFormStateCopyWith<$Res> {
  factory $CategoryFormErrorCopyWith(CategoryFormError value, $Res Function(CategoryFormError) _then) = _$CategoryFormErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CategoryFormErrorCopyWithImpl<$Res>
    implements $CategoryFormErrorCopyWith<$Res> {
  _$CategoryFormErrorCopyWithImpl(this._self, this._then);

  final CategoryFormError _self;
  final $Res Function(CategoryFormError) _then;

/// Create a copy of CategoryFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CategoryFormError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
