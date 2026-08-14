// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_logs_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ErrorLogsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorLogsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ErrorLogsState()';
}


}

/// @nodoc
class $ErrorLogsStateCopyWith<$Res>  {
$ErrorLogsStateCopyWith(ErrorLogsState _, $Res Function(ErrorLogsState) __);
}


/// Adds pattern-matching-related methods to [ErrorLogsState].
extension ErrorLogsStatePatterns on ErrorLogsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ErrorLogsInitial value)?  initial,TResult Function( ErrorLogsLoading value)?  loading,TResult Function( ErrorLogsLoaded value)?  loaded,TResult Function( ErrorLogsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ErrorLogsInitial() when initial != null:
return initial(_that);case ErrorLogsLoading() when loading != null:
return loading(_that);case ErrorLogsLoaded() when loaded != null:
return loaded(_that);case ErrorLogsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ErrorLogsInitial value)  initial,required TResult Function( ErrorLogsLoading value)  loading,required TResult Function( ErrorLogsLoaded value)  loaded,required TResult Function( ErrorLogsError value)  error,}){
final _that = this;
switch (_that) {
case ErrorLogsInitial():
return initial(_that);case ErrorLogsLoading():
return loading(_that);case ErrorLogsLoaded():
return loaded(_that);case ErrorLogsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ErrorLogsInitial value)?  initial,TResult? Function( ErrorLogsLoading value)?  loading,TResult? Function( ErrorLogsLoaded value)?  loaded,TResult? Function( ErrorLogsError value)?  error,}){
final _that = this;
switch (_that) {
case ErrorLogsInitial() when initial != null:
return initial(_that);case ErrorLogsLoading() when loading != null:
return loading(_that);case ErrorLogsLoaded() when loaded != null:
return loaded(_that);case ErrorLogsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ErrorLogEntry> logs,  List<ErrorLogEntry> filtered,  String searchQuery,  String filterCategory)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ErrorLogsInitial() when initial != null:
return initial();case ErrorLogsLoading() when loading != null:
return loading();case ErrorLogsLoaded() when loaded != null:
return loaded(_that.logs,_that.filtered,_that.searchQuery,_that.filterCategory);case ErrorLogsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ErrorLogEntry> logs,  List<ErrorLogEntry> filtered,  String searchQuery,  String filterCategory)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ErrorLogsInitial():
return initial();case ErrorLogsLoading():
return loading();case ErrorLogsLoaded():
return loaded(_that.logs,_that.filtered,_that.searchQuery,_that.filterCategory);case ErrorLogsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ErrorLogEntry> logs,  List<ErrorLogEntry> filtered,  String searchQuery,  String filterCategory)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ErrorLogsInitial() when initial != null:
return initial();case ErrorLogsLoading() when loading != null:
return loading();case ErrorLogsLoaded() when loaded != null:
return loaded(_that.logs,_that.filtered,_that.searchQuery,_that.filterCategory);case ErrorLogsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ErrorLogsInitial implements ErrorLogsState {
  const ErrorLogsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorLogsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ErrorLogsState.initial()';
}


}




/// @nodoc


class ErrorLogsLoading implements ErrorLogsState {
  const ErrorLogsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorLogsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ErrorLogsState.loading()';
}


}




/// @nodoc


class ErrorLogsLoaded implements ErrorLogsState {
  const ErrorLogsLoaded({required final  List<ErrorLogEntry> logs, required final  List<ErrorLogEntry> filtered, this.searchQuery = '', this.filterCategory = ''}): _logs = logs,_filtered = filtered;
  

 final  List<ErrorLogEntry> _logs;
 List<ErrorLogEntry> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

 final  List<ErrorLogEntry> _filtered;
 List<ErrorLogEntry> get filtered {
  if (_filtered is EqualUnmodifiableListView) return _filtered;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filtered);
}

@JsonKey() final  String searchQuery;
@JsonKey() final  String filterCategory;

/// Create a copy of ErrorLogsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorLogsLoadedCopyWith<ErrorLogsLoaded> get copyWith => _$ErrorLogsLoadedCopyWithImpl<ErrorLogsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorLogsLoaded&&const DeepCollectionEquality().equals(other._logs, _logs)&&const DeepCollectionEquality().equals(other._filtered, _filtered)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.filterCategory, filterCategory) || other.filterCategory == filterCategory));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_logs),const DeepCollectionEquality().hash(_filtered),searchQuery,filterCategory);

@override
String toString() {
  return 'ErrorLogsState.loaded(logs: $logs, filtered: $filtered, searchQuery: $searchQuery, filterCategory: $filterCategory)';
}


}

/// @nodoc
abstract mixin class $ErrorLogsLoadedCopyWith<$Res> implements $ErrorLogsStateCopyWith<$Res> {
  factory $ErrorLogsLoadedCopyWith(ErrorLogsLoaded value, $Res Function(ErrorLogsLoaded) _then) = _$ErrorLogsLoadedCopyWithImpl;
@useResult
$Res call({
 List<ErrorLogEntry> logs, List<ErrorLogEntry> filtered, String searchQuery, String filterCategory
});




}
/// @nodoc
class _$ErrorLogsLoadedCopyWithImpl<$Res>
    implements $ErrorLogsLoadedCopyWith<$Res> {
  _$ErrorLogsLoadedCopyWithImpl(this._self, this._then);

  final ErrorLogsLoaded _self;
  final $Res Function(ErrorLogsLoaded) _then;

/// Create a copy of ErrorLogsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? logs = null,Object? filtered = null,Object? searchQuery = null,Object? filterCategory = null,}) {
  return _then(ErrorLogsLoaded(
logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<ErrorLogEntry>,filtered: null == filtered ? _self._filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<ErrorLogEntry>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,filterCategory: null == filterCategory ? _self.filterCategory : filterCategory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ErrorLogsError implements ErrorLogsState {
  const ErrorLogsError(this.message);
  

 final  String message;

/// Create a copy of ErrorLogsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorLogsErrorCopyWith<ErrorLogsError> get copyWith => _$ErrorLogsErrorCopyWithImpl<ErrorLogsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorLogsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ErrorLogsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorLogsErrorCopyWith<$Res> implements $ErrorLogsStateCopyWith<$Res> {
  factory $ErrorLogsErrorCopyWith(ErrorLogsError value, $Res Function(ErrorLogsError) _then) = _$ErrorLogsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorLogsErrorCopyWithImpl<$Res>
    implements $ErrorLogsErrorCopyWith<$Res> {
  _$ErrorLogsErrorCopyWithImpl(this._self, this._then);

  final ErrorLogsError _self;
  final $Res Function(ErrorLogsError) _then;

/// Create a copy of ErrorLogsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorLogsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
