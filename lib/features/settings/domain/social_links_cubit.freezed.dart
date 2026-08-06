// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_links_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SocialLinksState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLinksState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialLinksState()';
}


}

/// @nodoc
class $SocialLinksStateCopyWith<$Res>  {
$SocialLinksStateCopyWith(SocialLinksState _, $Res Function(SocialLinksState) __);
}


/// Adds pattern-matching-related methods to [SocialLinksState].
extension SocialLinksStatePatterns on SocialLinksState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SocialLinksInitial value)?  initial,TResult Function( SocialLinksLoading value)?  loading,TResult Function( SocialLinksLoaded value)?  loaded,TResult Function( SocialLinksSaving value)?  saving,TResult Function( SocialLinksSaved value)?  saved,TResult Function( SocialLinksError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SocialLinksInitial() when initial != null:
return initial(_that);case SocialLinksLoading() when loading != null:
return loading(_that);case SocialLinksLoaded() when loaded != null:
return loaded(_that);case SocialLinksSaving() when saving != null:
return saving(_that);case SocialLinksSaved() when saved != null:
return saved(_that);case SocialLinksError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SocialLinksInitial value)  initial,required TResult Function( SocialLinksLoading value)  loading,required TResult Function( SocialLinksLoaded value)  loaded,required TResult Function( SocialLinksSaving value)  saving,required TResult Function( SocialLinksSaved value)  saved,required TResult Function( SocialLinksError value)  error,}){
final _that = this;
switch (_that) {
case SocialLinksInitial():
return initial(_that);case SocialLinksLoading():
return loading(_that);case SocialLinksLoaded():
return loaded(_that);case SocialLinksSaving():
return saving(_that);case SocialLinksSaved():
return saved(_that);case SocialLinksError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SocialLinksInitial value)?  initial,TResult? Function( SocialLinksLoading value)?  loading,TResult? Function( SocialLinksLoaded value)?  loaded,TResult? Function( SocialLinksSaving value)?  saving,TResult? Function( SocialLinksSaved value)?  saved,TResult? Function( SocialLinksError value)?  error,}){
final _that = this;
switch (_that) {
case SocialLinksInitial() when initial != null:
return initial(_that);case SocialLinksLoading() when loading != null:
return loading(_that);case SocialLinksLoaded() when loaded != null:
return loaded(_that);case SocialLinksSaving() when saving != null:
return saving(_that);case SocialLinksSaved() when saved != null:
return saved(_that);case SocialLinksError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( SocialLinks links)?  loaded,TResult Function( SocialLinks links)?  saving,TResult Function( SocialLinks links)?  saved,TResult Function( String message,  SocialLinks? links)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SocialLinksInitial() when initial != null:
return initial();case SocialLinksLoading() when loading != null:
return loading();case SocialLinksLoaded() when loaded != null:
return loaded(_that.links);case SocialLinksSaving() when saving != null:
return saving(_that.links);case SocialLinksSaved() when saved != null:
return saved(_that.links);case SocialLinksError() when error != null:
return error(_that.message,_that.links);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( SocialLinks links)  loaded,required TResult Function( SocialLinks links)  saving,required TResult Function( SocialLinks links)  saved,required TResult Function( String message,  SocialLinks? links)  error,}) {final _that = this;
switch (_that) {
case SocialLinksInitial():
return initial();case SocialLinksLoading():
return loading();case SocialLinksLoaded():
return loaded(_that.links);case SocialLinksSaving():
return saving(_that.links);case SocialLinksSaved():
return saved(_that.links);case SocialLinksError():
return error(_that.message,_that.links);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( SocialLinks links)?  loaded,TResult? Function( SocialLinks links)?  saving,TResult? Function( SocialLinks links)?  saved,TResult? Function( String message,  SocialLinks? links)?  error,}) {final _that = this;
switch (_that) {
case SocialLinksInitial() when initial != null:
return initial();case SocialLinksLoading() when loading != null:
return loading();case SocialLinksLoaded() when loaded != null:
return loaded(_that.links);case SocialLinksSaving() when saving != null:
return saving(_that.links);case SocialLinksSaved() when saved != null:
return saved(_that.links);case SocialLinksError() when error != null:
return error(_that.message,_that.links);case _:
  return null;

}
}

}

/// @nodoc


class SocialLinksInitial implements SocialLinksState {
  const SocialLinksInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLinksInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialLinksState.initial()';
}


}




/// @nodoc


class SocialLinksLoading implements SocialLinksState {
  const SocialLinksLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLinksLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocialLinksState.loading()';
}


}




/// @nodoc


class SocialLinksLoaded implements SocialLinksState {
  const SocialLinksLoaded(this.links);
  

 final  SocialLinks links;

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLinksLoadedCopyWith<SocialLinksLoaded> get copyWith => _$SocialLinksLoadedCopyWithImpl<SocialLinksLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLinksLoaded&&(identical(other.links, links) || other.links == links));
}


@override
int get hashCode => Object.hash(runtimeType,links);

@override
String toString() {
  return 'SocialLinksState.loaded(links: $links)';
}


}

/// @nodoc
abstract mixin class $SocialLinksLoadedCopyWith<$Res> implements $SocialLinksStateCopyWith<$Res> {
  factory $SocialLinksLoadedCopyWith(SocialLinksLoaded value, $Res Function(SocialLinksLoaded) _then) = _$SocialLinksLoadedCopyWithImpl;
@useResult
$Res call({
 SocialLinks links
});


$SocialLinksCopyWith<$Res> get links;

}
/// @nodoc
class _$SocialLinksLoadedCopyWithImpl<$Res>
    implements $SocialLinksLoadedCopyWith<$Res> {
  _$SocialLinksLoadedCopyWithImpl(this._self, this._then);

  final SocialLinksLoaded _self;
  final $Res Function(SocialLinksLoaded) _then;

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? links = null,}) {
  return _then(SocialLinksLoaded(
null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as SocialLinks,
  ));
}

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialLinksCopyWith<$Res> get links {
  
  return $SocialLinksCopyWith<$Res>(_self.links, (value) {
    return _then(_self.copyWith(links: value));
  });
}
}

/// @nodoc


class SocialLinksSaving implements SocialLinksState {
  const SocialLinksSaving(this.links);
  

 final  SocialLinks links;

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLinksSavingCopyWith<SocialLinksSaving> get copyWith => _$SocialLinksSavingCopyWithImpl<SocialLinksSaving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLinksSaving&&(identical(other.links, links) || other.links == links));
}


@override
int get hashCode => Object.hash(runtimeType,links);

@override
String toString() {
  return 'SocialLinksState.saving(links: $links)';
}


}

/// @nodoc
abstract mixin class $SocialLinksSavingCopyWith<$Res> implements $SocialLinksStateCopyWith<$Res> {
  factory $SocialLinksSavingCopyWith(SocialLinksSaving value, $Res Function(SocialLinksSaving) _then) = _$SocialLinksSavingCopyWithImpl;
@useResult
$Res call({
 SocialLinks links
});


$SocialLinksCopyWith<$Res> get links;

}
/// @nodoc
class _$SocialLinksSavingCopyWithImpl<$Res>
    implements $SocialLinksSavingCopyWith<$Res> {
  _$SocialLinksSavingCopyWithImpl(this._self, this._then);

  final SocialLinksSaving _self;
  final $Res Function(SocialLinksSaving) _then;

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? links = null,}) {
  return _then(SocialLinksSaving(
null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as SocialLinks,
  ));
}

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialLinksCopyWith<$Res> get links {
  
  return $SocialLinksCopyWith<$Res>(_self.links, (value) {
    return _then(_self.copyWith(links: value));
  });
}
}

/// @nodoc


class SocialLinksSaved implements SocialLinksState {
  const SocialLinksSaved(this.links);
  

 final  SocialLinks links;

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLinksSavedCopyWith<SocialLinksSaved> get copyWith => _$SocialLinksSavedCopyWithImpl<SocialLinksSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLinksSaved&&(identical(other.links, links) || other.links == links));
}


@override
int get hashCode => Object.hash(runtimeType,links);

@override
String toString() {
  return 'SocialLinksState.saved(links: $links)';
}


}

/// @nodoc
abstract mixin class $SocialLinksSavedCopyWith<$Res> implements $SocialLinksStateCopyWith<$Res> {
  factory $SocialLinksSavedCopyWith(SocialLinksSaved value, $Res Function(SocialLinksSaved) _then) = _$SocialLinksSavedCopyWithImpl;
@useResult
$Res call({
 SocialLinks links
});


$SocialLinksCopyWith<$Res> get links;

}
/// @nodoc
class _$SocialLinksSavedCopyWithImpl<$Res>
    implements $SocialLinksSavedCopyWith<$Res> {
  _$SocialLinksSavedCopyWithImpl(this._self, this._then);

  final SocialLinksSaved _self;
  final $Res Function(SocialLinksSaved) _then;

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? links = null,}) {
  return _then(SocialLinksSaved(
null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as SocialLinks,
  ));
}

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialLinksCopyWith<$Res> get links {
  
  return $SocialLinksCopyWith<$Res>(_self.links, (value) {
    return _then(_self.copyWith(links: value));
  });
}
}

/// @nodoc


class SocialLinksError implements SocialLinksState {
  const SocialLinksError(this.message, {this.links});
  

 final  String message;
 final  SocialLinks? links;

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLinksErrorCopyWith<SocialLinksError> get copyWith => _$SocialLinksErrorCopyWithImpl<SocialLinksError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLinksError&&(identical(other.message, message) || other.message == message)&&(identical(other.links, links) || other.links == links));
}


@override
int get hashCode => Object.hash(runtimeType,message,links);

@override
String toString() {
  return 'SocialLinksState.error(message: $message, links: $links)';
}


}

/// @nodoc
abstract mixin class $SocialLinksErrorCopyWith<$Res> implements $SocialLinksStateCopyWith<$Res> {
  factory $SocialLinksErrorCopyWith(SocialLinksError value, $Res Function(SocialLinksError) _then) = _$SocialLinksErrorCopyWithImpl;
@useResult
$Res call({
 String message, SocialLinks? links
});


$SocialLinksCopyWith<$Res>? get links;

}
/// @nodoc
class _$SocialLinksErrorCopyWithImpl<$Res>
    implements $SocialLinksErrorCopyWith<$Res> {
  _$SocialLinksErrorCopyWithImpl(this._self, this._then);

  final SocialLinksError _self;
  final $Res Function(SocialLinksError) _then;

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? links = freezed,}) {
  return _then(SocialLinksError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,links: freezed == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as SocialLinks?,
  ));
}

/// Create a copy of SocialLinksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialLinksCopyWith<$Res>? get links {
    if (_self.links == null) {
    return null;
  }

  return $SocialLinksCopyWith<$Res>(_self.links!, (value) {
    return _then(_self.copyWith(links: value));
  });
}
}

// dart format on
