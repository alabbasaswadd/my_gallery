// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'site_customization_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SiteCustomizationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SiteCustomizationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SiteCustomizationState()';
}


}

/// @nodoc
class $SiteCustomizationStateCopyWith<$Res>  {
$SiteCustomizationStateCopyWith(SiteCustomizationState _, $Res Function(SiteCustomizationState) __);
}


/// Adds pattern-matching-related methods to [SiteCustomizationState].
extension SiteCustomizationStatePatterns on SiteCustomizationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SiteCustomizationLoading value)?  loading,TResult Function( SiteCustomizationLoadError value)?  loadError,TResult Function( SiteCustomizationReady value)?  ready,TResult Function( SiteCustomizationSaved value)?  saved,TResult Function( SiteCustomizationOpError value)?  opError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SiteCustomizationLoading() when loading != null:
return loading(_that);case SiteCustomizationLoadError() when loadError != null:
return loadError(_that);case SiteCustomizationReady() when ready != null:
return ready(_that);case SiteCustomizationSaved() when saved != null:
return saved(_that);case SiteCustomizationOpError() when opError != null:
return opError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SiteCustomizationLoading value)  loading,required TResult Function( SiteCustomizationLoadError value)  loadError,required TResult Function( SiteCustomizationReady value)  ready,required TResult Function( SiteCustomizationSaved value)  saved,required TResult Function( SiteCustomizationOpError value)  opError,}){
final _that = this;
switch (_that) {
case SiteCustomizationLoading():
return loading(_that);case SiteCustomizationLoadError():
return loadError(_that);case SiteCustomizationReady():
return ready(_that);case SiteCustomizationSaved():
return saved(_that);case SiteCustomizationOpError():
return opError(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SiteCustomizationLoading value)?  loading,TResult? Function( SiteCustomizationLoadError value)?  loadError,TResult? Function( SiteCustomizationReady value)?  ready,TResult? Function( SiteCustomizationSaved value)?  saved,TResult? Function( SiteCustomizationOpError value)?  opError,}){
final _that = this;
switch (_that) {
case SiteCustomizationLoading() when loading != null:
return loading(_that);case SiteCustomizationLoadError() when loadError != null:
return loadError(_that);case SiteCustomizationReady() when ready != null:
return ready(_that);case SiteCustomizationSaved() when saved != null:
return saved(_that);case SiteCustomizationOpError() when opError != null:
return opError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( String message)?  loadError,TResult Function( StorefrontSettings draft,  bool saving,  String? uploadingField)?  ready,TResult Function( StorefrontSettings draft)?  saved,TResult Function( String message,  StorefrontSettings draft)?  opError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SiteCustomizationLoading() when loading != null:
return loading();case SiteCustomizationLoadError() when loadError != null:
return loadError(_that.message);case SiteCustomizationReady() when ready != null:
return ready(_that.draft,_that.saving,_that.uploadingField);case SiteCustomizationSaved() when saved != null:
return saved(_that.draft);case SiteCustomizationOpError() when opError != null:
return opError(_that.message,_that.draft);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( String message)  loadError,required TResult Function( StorefrontSettings draft,  bool saving,  String? uploadingField)  ready,required TResult Function( StorefrontSettings draft)  saved,required TResult Function( String message,  StorefrontSettings draft)  opError,}) {final _that = this;
switch (_that) {
case SiteCustomizationLoading():
return loading();case SiteCustomizationLoadError():
return loadError(_that.message);case SiteCustomizationReady():
return ready(_that.draft,_that.saving,_that.uploadingField);case SiteCustomizationSaved():
return saved(_that.draft);case SiteCustomizationOpError():
return opError(_that.message,_that.draft);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( String message)?  loadError,TResult? Function( StorefrontSettings draft,  bool saving,  String? uploadingField)?  ready,TResult? Function( StorefrontSettings draft)?  saved,TResult? Function( String message,  StorefrontSettings draft)?  opError,}) {final _that = this;
switch (_that) {
case SiteCustomizationLoading() when loading != null:
return loading();case SiteCustomizationLoadError() when loadError != null:
return loadError(_that.message);case SiteCustomizationReady() when ready != null:
return ready(_that.draft,_that.saving,_that.uploadingField);case SiteCustomizationSaved() when saved != null:
return saved(_that.draft);case SiteCustomizationOpError() when opError != null:
return opError(_that.message,_that.draft);case _:
  return null;

}
}

}

/// @nodoc


class SiteCustomizationLoading implements SiteCustomizationState {
  const SiteCustomizationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SiteCustomizationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SiteCustomizationState.loading()';
}


}




/// @nodoc


class SiteCustomizationLoadError implements SiteCustomizationState {
  const SiteCustomizationLoadError(this.message);
  

 final  String message;

/// Create a copy of SiteCustomizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SiteCustomizationLoadErrorCopyWith<SiteCustomizationLoadError> get copyWith => _$SiteCustomizationLoadErrorCopyWithImpl<SiteCustomizationLoadError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SiteCustomizationLoadError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SiteCustomizationState.loadError(message: $message)';
}


}

/// @nodoc
abstract mixin class $SiteCustomizationLoadErrorCopyWith<$Res> implements $SiteCustomizationStateCopyWith<$Res> {
  factory $SiteCustomizationLoadErrorCopyWith(SiteCustomizationLoadError value, $Res Function(SiteCustomizationLoadError) _then) = _$SiteCustomizationLoadErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SiteCustomizationLoadErrorCopyWithImpl<$Res>
    implements $SiteCustomizationLoadErrorCopyWith<$Res> {
  _$SiteCustomizationLoadErrorCopyWithImpl(this._self, this._then);

  final SiteCustomizationLoadError _self;
  final $Res Function(SiteCustomizationLoadError) _then;

/// Create a copy of SiteCustomizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SiteCustomizationLoadError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SiteCustomizationReady implements SiteCustomizationState {
  const SiteCustomizationReady(this.draft, {this.saving = false, this.uploadingField});
  

 final  StorefrontSettings draft;
@JsonKey() final  bool saving;
 final  String? uploadingField;

/// Create a copy of SiteCustomizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SiteCustomizationReadyCopyWith<SiteCustomizationReady> get copyWith => _$SiteCustomizationReadyCopyWithImpl<SiteCustomizationReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SiteCustomizationReady&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.uploadingField, uploadingField) || other.uploadingField == uploadingField));
}


@override
int get hashCode => Object.hash(runtimeType,draft,saving,uploadingField);

@override
String toString() {
  return 'SiteCustomizationState.ready(draft: $draft, saving: $saving, uploadingField: $uploadingField)';
}


}

/// @nodoc
abstract mixin class $SiteCustomizationReadyCopyWith<$Res> implements $SiteCustomizationStateCopyWith<$Res> {
  factory $SiteCustomizationReadyCopyWith(SiteCustomizationReady value, $Res Function(SiteCustomizationReady) _then) = _$SiteCustomizationReadyCopyWithImpl;
@useResult
$Res call({
 StorefrontSettings draft, bool saving, String? uploadingField
});


$StorefrontSettingsCopyWith<$Res> get draft;

}
/// @nodoc
class _$SiteCustomizationReadyCopyWithImpl<$Res>
    implements $SiteCustomizationReadyCopyWith<$Res> {
  _$SiteCustomizationReadyCopyWithImpl(this._self, this._then);

  final SiteCustomizationReady _self;
  final $Res Function(SiteCustomizationReady) _then;

/// Create a copy of SiteCustomizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? saving = null,Object? uploadingField = freezed,}) {
  return _then(SiteCustomizationReady(
null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as StorefrontSettings,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,uploadingField: freezed == uploadingField ? _self.uploadingField : uploadingField // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SiteCustomizationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorefrontSettingsCopyWith<$Res> get draft {
  
  return $StorefrontSettingsCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

/// @nodoc


class SiteCustomizationSaved implements SiteCustomizationState {
  const SiteCustomizationSaved(this.draft);
  

 final  StorefrontSettings draft;

/// Create a copy of SiteCustomizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SiteCustomizationSavedCopyWith<SiteCustomizationSaved> get copyWith => _$SiteCustomizationSavedCopyWithImpl<SiteCustomizationSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SiteCustomizationSaved&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode => Object.hash(runtimeType,draft);

@override
String toString() {
  return 'SiteCustomizationState.saved(draft: $draft)';
}


}

/// @nodoc
abstract mixin class $SiteCustomizationSavedCopyWith<$Res> implements $SiteCustomizationStateCopyWith<$Res> {
  factory $SiteCustomizationSavedCopyWith(SiteCustomizationSaved value, $Res Function(SiteCustomizationSaved) _then) = _$SiteCustomizationSavedCopyWithImpl;
@useResult
$Res call({
 StorefrontSettings draft
});


$StorefrontSettingsCopyWith<$Res> get draft;

}
/// @nodoc
class _$SiteCustomizationSavedCopyWithImpl<$Res>
    implements $SiteCustomizationSavedCopyWith<$Res> {
  _$SiteCustomizationSavedCopyWithImpl(this._self, this._then);

  final SiteCustomizationSaved _self;
  final $Res Function(SiteCustomizationSaved) _then;

/// Create a copy of SiteCustomizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,}) {
  return _then(SiteCustomizationSaved(
null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as StorefrontSettings,
  ));
}

/// Create a copy of SiteCustomizationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorefrontSettingsCopyWith<$Res> get draft {
  
  return $StorefrontSettingsCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

/// @nodoc


class SiteCustomizationOpError implements SiteCustomizationState {
  const SiteCustomizationOpError(this.message, this.draft);
  

 final  String message;
 final  StorefrontSettings draft;

/// Create a copy of SiteCustomizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SiteCustomizationOpErrorCopyWith<SiteCustomizationOpError> get copyWith => _$SiteCustomizationOpErrorCopyWithImpl<SiteCustomizationOpError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SiteCustomizationOpError&&(identical(other.message, message) || other.message == message)&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode => Object.hash(runtimeType,message,draft);

@override
String toString() {
  return 'SiteCustomizationState.opError(message: $message, draft: $draft)';
}


}

/// @nodoc
abstract mixin class $SiteCustomizationOpErrorCopyWith<$Res> implements $SiteCustomizationStateCopyWith<$Res> {
  factory $SiteCustomizationOpErrorCopyWith(SiteCustomizationOpError value, $Res Function(SiteCustomizationOpError) _then) = _$SiteCustomizationOpErrorCopyWithImpl;
@useResult
$Res call({
 String message, StorefrontSettings draft
});


$StorefrontSettingsCopyWith<$Res> get draft;

}
/// @nodoc
class _$SiteCustomizationOpErrorCopyWithImpl<$Res>
    implements $SiteCustomizationOpErrorCopyWith<$Res> {
  _$SiteCustomizationOpErrorCopyWithImpl(this._self, this._then);

  final SiteCustomizationOpError _self;
  final $Res Function(SiteCustomizationOpError) _then;

/// Create a copy of SiteCustomizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? draft = null,}) {
  return _then(SiteCustomizationOpError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as StorefrontSettings,
  ));
}

/// Create a copy of SiteCustomizationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorefrontSettingsCopyWith<$Res> get draft {
  
  return $StorefrontSettingsCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
