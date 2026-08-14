// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_log_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ErrorLogEntry {

 String get id; DateTime get timestamp;/// Error category — for API errors this is [ApiErrorKind.name];
/// for Flutter/platform errors use [kErrorCategoryFlutter] / [kErrorCategoryPlatform].
 String get category;/// User-readable error message.
 String get message;/// Raw technical exception text.
 String? get technicalMessage;/// First [ErrorLogger.stackTraceMaxLines] lines of the stack trace.
 String? get stackTrace; int? get statusCode;/// [ApiErrorKind.name] for API errors, null for others.
 String? get apiErrorKind; String? get traceId; String? get endpoint; String? get httpMethod; String? get featureName; bool get isHandled;
/// Create a copy of ErrorLogEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorLogEntryCopyWith<ErrorLogEntry> get copyWith => _$ErrorLogEntryCopyWithImpl<ErrorLogEntry>(this as ErrorLogEntry, _$identity);

  /// Serializes this ErrorLogEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorLogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.category, category) || other.category == category)&&(identical(other.message, message) || other.message == message)&&(identical(other.technicalMessage, technicalMessage) || other.technicalMessage == technicalMessage)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.apiErrorKind, apiErrorKind) || other.apiErrorKind == apiErrorKind)&&(identical(other.traceId, traceId) || other.traceId == traceId)&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint)&&(identical(other.httpMethod, httpMethod) || other.httpMethod == httpMethod)&&(identical(other.featureName, featureName) || other.featureName == featureName)&&(identical(other.isHandled, isHandled) || other.isHandled == isHandled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,timestamp,category,message,technicalMessage,stackTrace,statusCode,apiErrorKind,traceId,endpoint,httpMethod,featureName,isHandled);

@override
String toString() {
  return 'ErrorLogEntry(id: $id, timestamp: $timestamp, category: $category, message: $message, technicalMessage: $technicalMessage, stackTrace: $stackTrace, statusCode: $statusCode, apiErrorKind: $apiErrorKind, traceId: $traceId, endpoint: $endpoint, httpMethod: $httpMethod, featureName: $featureName, isHandled: $isHandled)';
}


}

/// @nodoc
abstract mixin class $ErrorLogEntryCopyWith<$Res>  {
  factory $ErrorLogEntryCopyWith(ErrorLogEntry value, $Res Function(ErrorLogEntry) _then) = _$ErrorLogEntryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime timestamp, String category, String message, String? technicalMessage, String? stackTrace, int? statusCode, String? apiErrorKind, String? traceId, String? endpoint, String? httpMethod, String? featureName, bool isHandled
});




}
/// @nodoc
class _$ErrorLogEntryCopyWithImpl<$Res>
    implements $ErrorLogEntryCopyWith<$Res> {
  _$ErrorLogEntryCopyWithImpl(this._self, this._then);

  final ErrorLogEntry _self;
  final $Res Function(ErrorLogEntry) _then;

/// Create a copy of ErrorLogEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? timestamp = null,Object? category = null,Object? message = null,Object? technicalMessage = freezed,Object? stackTrace = freezed,Object? statusCode = freezed,Object? apiErrorKind = freezed,Object? traceId = freezed,Object? endpoint = freezed,Object? httpMethod = freezed,Object? featureName = freezed,Object? isHandled = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,technicalMessage: freezed == technicalMessage ? _self.technicalMessage : technicalMessage // ignore: cast_nullable_to_non_nullable
as String?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,apiErrorKind: freezed == apiErrorKind ? _self.apiErrorKind : apiErrorKind // ignore: cast_nullable_to_non_nullable
as String?,traceId: freezed == traceId ? _self.traceId : traceId // ignore: cast_nullable_to_non_nullable
as String?,endpoint: freezed == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as String?,httpMethod: freezed == httpMethod ? _self.httpMethod : httpMethod // ignore: cast_nullable_to_non_nullable
as String?,featureName: freezed == featureName ? _self.featureName : featureName // ignore: cast_nullable_to_non_nullable
as String?,isHandled: null == isHandled ? _self.isHandled : isHandled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ErrorLogEntry].
extension ErrorLogEntryPatterns on ErrorLogEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErrorLogEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErrorLogEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErrorLogEntry value)  $default,){
final _that = this;
switch (_that) {
case _ErrorLogEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErrorLogEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ErrorLogEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime timestamp,  String category,  String message,  String? technicalMessage,  String? stackTrace,  int? statusCode,  String? apiErrorKind,  String? traceId,  String? endpoint,  String? httpMethod,  String? featureName,  bool isHandled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErrorLogEntry() when $default != null:
return $default(_that.id,_that.timestamp,_that.category,_that.message,_that.technicalMessage,_that.stackTrace,_that.statusCode,_that.apiErrorKind,_that.traceId,_that.endpoint,_that.httpMethod,_that.featureName,_that.isHandled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime timestamp,  String category,  String message,  String? technicalMessage,  String? stackTrace,  int? statusCode,  String? apiErrorKind,  String? traceId,  String? endpoint,  String? httpMethod,  String? featureName,  bool isHandled)  $default,) {final _that = this;
switch (_that) {
case _ErrorLogEntry():
return $default(_that.id,_that.timestamp,_that.category,_that.message,_that.technicalMessage,_that.stackTrace,_that.statusCode,_that.apiErrorKind,_that.traceId,_that.endpoint,_that.httpMethod,_that.featureName,_that.isHandled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime timestamp,  String category,  String message,  String? technicalMessage,  String? stackTrace,  int? statusCode,  String? apiErrorKind,  String? traceId,  String? endpoint,  String? httpMethod,  String? featureName,  bool isHandled)?  $default,) {final _that = this;
switch (_that) {
case _ErrorLogEntry() when $default != null:
return $default(_that.id,_that.timestamp,_that.category,_that.message,_that.technicalMessage,_that.stackTrace,_that.statusCode,_that.apiErrorKind,_that.traceId,_that.endpoint,_that.httpMethod,_that.featureName,_that.isHandled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ErrorLogEntry implements ErrorLogEntry {
  const _ErrorLogEntry({required this.id, required this.timestamp, required this.category, required this.message, this.technicalMessage, this.stackTrace, this.statusCode, this.apiErrorKind, this.traceId, this.endpoint, this.httpMethod, this.featureName, this.isHandled = true});
  factory _ErrorLogEntry.fromJson(Map<String, dynamic> json) => _$ErrorLogEntryFromJson(json);

@override final  String id;
@override final  DateTime timestamp;
/// Error category — for API errors this is [ApiErrorKind.name];
/// for Flutter/platform errors use [kErrorCategoryFlutter] / [kErrorCategoryPlatform].
@override final  String category;
/// User-readable error message.
@override final  String message;
/// Raw technical exception text.
@override final  String? technicalMessage;
/// First [ErrorLogger.stackTraceMaxLines] lines of the stack trace.
@override final  String? stackTrace;
@override final  int? statusCode;
/// [ApiErrorKind.name] for API errors, null for others.
@override final  String? apiErrorKind;
@override final  String? traceId;
@override final  String? endpoint;
@override final  String? httpMethod;
@override final  String? featureName;
@override@JsonKey() final  bool isHandled;

/// Create a copy of ErrorLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorLogEntryCopyWith<_ErrorLogEntry> get copyWith => __$ErrorLogEntryCopyWithImpl<_ErrorLogEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorLogEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorLogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.category, category) || other.category == category)&&(identical(other.message, message) || other.message == message)&&(identical(other.technicalMessage, technicalMessage) || other.technicalMessage == technicalMessage)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.apiErrorKind, apiErrorKind) || other.apiErrorKind == apiErrorKind)&&(identical(other.traceId, traceId) || other.traceId == traceId)&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint)&&(identical(other.httpMethod, httpMethod) || other.httpMethod == httpMethod)&&(identical(other.featureName, featureName) || other.featureName == featureName)&&(identical(other.isHandled, isHandled) || other.isHandled == isHandled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,timestamp,category,message,technicalMessage,stackTrace,statusCode,apiErrorKind,traceId,endpoint,httpMethod,featureName,isHandled);

@override
String toString() {
  return 'ErrorLogEntry(id: $id, timestamp: $timestamp, category: $category, message: $message, technicalMessage: $technicalMessage, stackTrace: $stackTrace, statusCode: $statusCode, apiErrorKind: $apiErrorKind, traceId: $traceId, endpoint: $endpoint, httpMethod: $httpMethod, featureName: $featureName, isHandled: $isHandled)';
}


}

/// @nodoc
abstract mixin class _$ErrorLogEntryCopyWith<$Res> implements $ErrorLogEntryCopyWith<$Res> {
  factory _$ErrorLogEntryCopyWith(_ErrorLogEntry value, $Res Function(_ErrorLogEntry) _then) = __$ErrorLogEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime timestamp, String category, String message, String? technicalMessage, String? stackTrace, int? statusCode, String? apiErrorKind, String? traceId, String? endpoint, String? httpMethod, String? featureName, bool isHandled
});




}
/// @nodoc
class __$ErrorLogEntryCopyWithImpl<$Res>
    implements _$ErrorLogEntryCopyWith<$Res> {
  __$ErrorLogEntryCopyWithImpl(this._self, this._then);

  final _ErrorLogEntry _self;
  final $Res Function(_ErrorLogEntry) _then;

/// Create a copy of ErrorLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? timestamp = null,Object? category = null,Object? message = null,Object? technicalMessage = freezed,Object? stackTrace = freezed,Object? statusCode = freezed,Object? apiErrorKind = freezed,Object? traceId = freezed,Object? endpoint = freezed,Object? httpMethod = freezed,Object? featureName = freezed,Object? isHandled = null,}) {
  return _then(_ErrorLogEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,technicalMessage: freezed == technicalMessage ? _self.technicalMessage : technicalMessage // ignore: cast_nullable_to_non_nullable
as String?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,apiErrorKind: freezed == apiErrorKind ? _self.apiErrorKind : apiErrorKind // ignore: cast_nullable_to_non_nullable
as String?,traceId: freezed == traceId ? _self.traceId : traceId // ignore: cast_nullable_to_non_nullable
as String?,endpoint: freezed == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as String?,httpMethod: freezed == httpMethod ? _self.httpMethod : httpMethod // ignore: cast_nullable_to_non_nullable
as String?,featureName: freezed == featureName ? _self.featureName : featureName // ignore: cast_nullable_to_non_nullable
as String?,isHandled: null == isHandled ? _self.isHandled : isHandled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
