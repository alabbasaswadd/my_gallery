// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'occasions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OccasionsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OccasionsState()';
}


}

/// @nodoc
class $OccasionsStateCopyWith<$Res>  {
$OccasionsStateCopyWith(OccasionsState _, $Res Function(OccasionsState) __);
}


/// Adds pattern-matching-related methods to [OccasionsState].
extension OccasionsStatePatterns on OccasionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OccasionsInitial value)?  initial,TResult Function( OccasionsLoading value)?  loading,TResult Function( OccasionsLoaded value)?  loaded,TResult Function( OccasionsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OccasionsInitial() when initial != null:
return initial(_that);case OccasionsLoading() when loading != null:
return loading(_that);case OccasionsLoaded() when loaded != null:
return loaded(_that);case OccasionsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OccasionsInitial value)  initial,required TResult Function( OccasionsLoading value)  loading,required TResult Function( OccasionsLoaded value)  loaded,required TResult Function( OccasionsError value)  error,}){
final _that = this;
switch (_that) {
case OccasionsInitial():
return initial(_that);case OccasionsLoading():
return loading(_that);case OccasionsLoaded():
return loaded(_that);case OccasionsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OccasionsInitial value)?  initial,TResult? Function( OccasionsLoading value)?  loading,TResult? Function( OccasionsLoaded value)?  loaded,TResult? Function( OccasionsError value)?  error,}){
final _that = this;
switch (_that) {
case OccasionsInitial() when initial != null:
return initial(_that);case OccasionsLoading() when loading != null:
return loading(_that);case OccasionsLoaded() when loaded != null:
return loaded(_that);case OccasionsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<OccasionListItem> occasions)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OccasionsInitial() when initial != null:
return initial();case OccasionsLoading() when loading != null:
return loading();case OccasionsLoaded() when loaded != null:
return loaded(_that.occasions);case OccasionsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<OccasionListItem> occasions)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case OccasionsInitial():
return initial();case OccasionsLoading():
return loading();case OccasionsLoaded():
return loaded(_that.occasions);case OccasionsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<OccasionListItem> occasions)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case OccasionsInitial() when initial != null:
return initial();case OccasionsLoading() when loading != null:
return loading();case OccasionsLoaded() when loaded != null:
return loaded(_that.occasions);case OccasionsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class OccasionsInitial implements OccasionsState {
  const OccasionsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OccasionsState.initial()';
}


}




/// @nodoc


class OccasionsLoading implements OccasionsState {
  const OccasionsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OccasionsState.loading()';
}


}




/// @nodoc


class OccasionsLoaded implements OccasionsState {
  const OccasionsLoaded(final  List<OccasionListItem> occasions): _occasions = occasions;
  

 final  List<OccasionListItem> _occasions;
 List<OccasionListItem> get occasions {
  if (_occasions is EqualUnmodifiableListView) return _occasions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_occasions);
}


/// Create a copy of OccasionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OccasionsLoadedCopyWith<OccasionsLoaded> get copyWith => _$OccasionsLoadedCopyWithImpl<OccasionsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionsLoaded&&const DeepCollectionEquality().equals(other._occasions, _occasions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_occasions));

@override
String toString() {
  return 'OccasionsState.loaded(occasions: $occasions)';
}


}

/// @nodoc
abstract mixin class $OccasionsLoadedCopyWith<$Res> implements $OccasionsStateCopyWith<$Res> {
  factory $OccasionsLoadedCopyWith(OccasionsLoaded value, $Res Function(OccasionsLoaded) _then) = _$OccasionsLoadedCopyWithImpl;
@useResult
$Res call({
 List<OccasionListItem> occasions
});




}
/// @nodoc
class _$OccasionsLoadedCopyWithImpl<$Res>
    implements $OccasionsLoadedCopyWith<$Res> {
  _$OccasionsLoadedCopyWithImpl(this._self, this._then);

  final OccasionsLoaded _self;
  final $Res Function(OccasionsLoaded) _then;

/// Create a copy of OccasionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? occasions = null,}) {
  return _then(OccasionsLoaded(
null == occasions ? _self._occasions : occasions // ignore: cast_nullable_to_non_nullable
as List<OccasionListItem>,
  ));
}


}

/// @nodoc


class OccasionsError implements OccasionsState {
  const OccasionsError(this.message);
  

 final  String message;

/// Create a copy of OccasionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OccasionsErrorCopyWith<OccasionsError> get copyWith => _$OccasionsErrorCopyWithImpl<OccasionsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OccasionsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OccasionsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $OccasionsErrorCopyWith<$Res> implements $OccasionsStateCopyWith<$Res> {
  factory $OccasionsErrorCopyWith(OccasionsError value, $Res Function(OccasionsError) _then) = _$OccasionsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OccasionsErrorCopyWithImpl<$Res>
    implements $OccasionsErrorCopyWith<$Res> {
  _$OccasionsErrorCopyWithImpl(this._self, this._then);

  final OccasionsError _self;
  final $Res Function(OccasionsError) _then;

/// Create a copy of OccasionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OccasionsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
