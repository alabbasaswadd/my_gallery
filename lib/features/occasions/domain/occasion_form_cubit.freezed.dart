// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'occasion_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OccasionFormState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionFormState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OccasionFormState()';
}


}

/// @nodoc
class $OccasionFormStateCopyWith<$Res>  {
$OccasionFormStateCopyWith(OccasionFormState _, $Res Function(OccasionFormState) __);
}


/// Adds pattern-matching-related methods to [OccasionFormState].
extension OccasionFormStatePatterns on OccasionFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OccasionFormInitial value)?  initial,TResult Function( OccasionFormLoading value)?  loading,TResult Function( OccasionFormSuccess value)?  success,TResult Function( OccasionFormError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OccasionFormInitial() when initial != null:
return initial(_that);case OccasionFormLoading() when loading != null:
return loading(_that);case OccasionFormSuccess() when success != null:
return success(_that);case OccasionFormError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OccasionFormInitial value)  initial,required TResult Function( OccasionFormLoading value)  loading,required TResult Function( OccasionFormSuccess value)  success,required TResult Function( OccasionFormError value)  error,}){
final _that = this;
switch (_that) {
case OccasionFormInitial():
return initial(_that);case OccasionFormLoading():
return loading(_that);case OccasionFormSuccess():
return success(_that);case OccasionFormError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OccasionFormInitial value)?  initial,TResult? Function( OccasionFormLoading value)?  loading,TResult? Function( OccasionFormSuccess value)?  success,TResult? Function( OccasionFormError value)?  error,}){
final _that = this;
switch (_that) {
case OccasionFormInitial() when initial != null:
return initial(_that);case OccasionFormLoading() when loading != null:
return loading(_that);case OccasionFormSuccess() when success != null:
return success(_that);case OccasionFormError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( int occasionId)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OccasionFormInitial() when initial != null:
return initial();case OccasionFormLoading() when loading != null:
return loading();case OccasionFormSuccess() when success != null:
return success(_that.occasionId);case OccasionFormError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( int occasionId)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case OccasionFormInitial():
return initial();case OccasionFormLoading():
return loading();case OccasionFormSuccess():
return success(_that.occasionId);case OccasionFormError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( int occasionId)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case OccasionFormInitial() when initial != null:
return initial();case OccasionFormLoading() when loading != null:
return loading();case OccasionFormSuccess() when success != null:
return success(_that.occasionId);case OccasionFormError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class OccasionFormInitial implements OccasionFormState {
  const OccasionFormInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionFormInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OccasionFormState.initial()';
}


}




/// @nodoc


class OccasionFormLoading implements OccasionFormState {
  const OccasionFormLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionFormLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OccasionFormState.loading()';
}


}




/// @nodoc


class OccasionFormSuccess implements OccasionFormState {
  const OccasionFormSuccess(this.occasionId);
  

 final  int occasionId;

/// Create a copy of OccasionFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OccasionFormSuccessCopyWith<OccasionFormSuccess> get copyWith => _$OccasionFormSuccessCopyWithImpl<OccasionFormSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionFormSuccess&&(identical(other.occasionId, occasionId) || other.occasionId == occasionId));
}


@override
int get hashCode => Object.hash(runtimeType,occasionId);

@override
String toString() {
  return 'OccasionFormState.success(occasionId: $occasionId)';
}


}

/// @nodoc
abstract mixin class $OccasionFormSuccessCopyWith<$Res> implements $OccasionFormStateCopyWith<$Res> {
  factory $OccasionFormSuccessCopyWith(OccasionFormSuccess value, $Res Function(OccasionFormSuccess) _then) = _$OccasionFormSuccessCopyWithImpl;
@useResult
$Res call({
 int occasionId
});




}
/// @nodoc
class _$OccasionFormSuccessCopyWithImpl<$Res>
    implements $OccasionFormSuccessCopyWith<$Res> {
  _$OccasionFormSuccessCopyWithImpl(this._self, this._then);

  final OccasionFormSuccess _self;
  final $Res Function(OccasionFormSuccess) _then;

/// Create a copy of OccasionFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? occasionId = null,}) {
  return _then(OccasionFormSuccess(
null == occasionId ? _self.occasionId : occasionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OccasionFormError implements OccasionFormState {
  const OccasionFormError(this.message);
  

 final  String message;

/// Create a copy of OccasionFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OccasionFormErrorCopyWith<OccasionFormError> get copyWith => _$OccasionFormErrorCopyWithImpl<OccasionFormError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionFormError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OccasionFormState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $OccasionFormErrorCopyWith<$Res> implements $OccasionFormStateCopyWith<$Res> {
  factory $OccasionFormErrorCopyWith(OccasionFormError value, $Res Function(OccasionFormError) _then) = _$OccasionFormErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OccasionFormErrorCopyWithImpl<$Res>
    implements $OccasionFormErrorCopyWith<$Res> {
  _$OccasionFormErrorCopyWithImpl(this._self, this._then);

  final OccasionFormError _self;
  final $Res Function(OccasionFormError) _then;

/// Create a copy of OccasionFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OccasionFormError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
