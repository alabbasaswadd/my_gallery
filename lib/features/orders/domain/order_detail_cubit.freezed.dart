// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailState()';
}


}

/// @nodoc
class $OrderDetailStateCopyWith<$Res>  {
$OrderDetailStateCopyWith(OrderDetailState _, $Res Function(OrderDetailState) __);
}


/// Adds pattern-matching-related methods to [OrderDetailState].
extension OrderDetailStatePatterns on OrderDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrderDetailInitial value)?  initial,TResult Function( OrderDetailLoading value)?  loading,TResult Function( OrderDetailLoaded value)?  loaded,TResult Function( OrderDetailError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrderDetailInitial() when initial != null:
return initial(_that);case OrderDetailLoading() when loading != null:
return loading(_that);case OrderDetailLoaded() when loaded != null:
return loaded(_that);case OrderDetailError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrderDetailInitial value)  initial,required TResult Function( OrderDetailLoading value)  loading,required TResult Function( OrderDetailLoaded value)  loaded,required TResult Function( OrderDetailError value)  error,}){
final _that = this;
switch (_that) {
case OrderDetailInitial():
return initial(_that);case OrderDetailLoading():
return loading(_that);case OrderDetailLoaded():
return loaded(_that);case OrderDetailError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrderDetailInitial value)?  initial,TResult? Function( OrderDetailLoading value)?  loading,TResult? Function( OrderDetailLoaded value)?  loaded,TResult? Function( OrderDetailError value)?  error,}){
final _that = this;
switch (_that) {
case OrderDetailInitial() when initial != null:
return initial(_that);case OrderDetailLoading() when loading != null:
return loading(_that);case OrderDetailLoaded() when loaded != null:
return loaded(_that);case OrderDetailError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( OrderDetail order)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrderDetailInitial() when initial != null:
return initial();case OrderDetailLoading() when loading != null:
return loading();case OrderDetailLoaded() when loaded != null:
return loaded(_that.order);case OrderDetailError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( OrderDetail order)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case OrderDetailInitial():
return initial();case OrderDetailLoading():
return loading();case OrderDetailLoaded():
return loaded(_that.order);case OrderDetailError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( OrderDetail order)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case OrderDetailInitial() when initial != null:
return initial();case OrderDetailLoading() when loading != null:
return loading();case OrderDetailLoaded() when loaded != null:
return loaded(_that.order);case OrderDetailError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class OrderDetailInitial implements OrderDetailState {
  const OrderDetailInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailState.initial()';
}


}




/// @nodoc


class OrderDetailLoading implements OrderDetailState {
  const OrderDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailState.loading()';
}


}




/// @nodoc


class OrderDetailLoaded implements OrderDetailState {
  const OrderDetailLoaded(this.order);
  

 final  OrderDetail order;

/// Create a copy of OrderDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailLoadedCopyWith<OrderDetailLoaded> get copyWith => _$OrderDetailLoadedCopyWithImpl<OrderDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailLoaded&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'OrderDetailState.loaded(order: $order)';
}


}

/// @nodoc
abstract mixin class $OrderDetailLoadedCopyWith<$Res> implements $OrderDetailStateCopyWith<$Res> {
  factory $OrderDetailLoadedCopyWith(OrderDetailLoaded value, $Res Function(OrderDetailLoaded) _then) = _$OrderDetailLoadedCopyWithImpl;
@useResult
$Res call({
 OrderDetail order
});


$OrderDetailCopyWith<$Res> get order;

}
/// @nodoc
class _$OrderDetailLoadedCopyWithImpl<$Res>
    implements $OrderDetailLoadedCopyWith<$Res> {
  _$OrderDetailLoadedCopyWithImpl(this._self, this._then);

  final OrderDetailLoaded _self;
  final $Res Function(OrderDetailLoaded) _then;

/// Create a copy of OrderDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,}) {
  return _then(OrderDetailLoaded(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderDetail,
  ));
}

/// Create a copy of OrderDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderDetailCopyWith<$Res> get order {
  
  return $OrderDetailCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}

/// @nodoc


class OrderDetailError implements OrderDetailState {
  const OrderDetailError(this.message);
  

 final  String message;

/// Create a copy of OrderDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailErrorCopyWith<OrderDetailError> get copyWith => _$OrderDetailErrorCopyWithImpl<OrderDetailError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OrderDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $OrderDetailErrorCopyWith<$Res> implements $OrderDetailStateCopyWith<$Res> {
  factory $OrderDetailErrorCopyWith(OrderDetailError value, $Res Function(OrderDetailError) _then) = _$OrderDetailErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OrderDetailErrorCopyWithImpl<$Res>
    implements $OrderDetailErrorCopyWith<$Res> {
  _$OrderDetailErrorCopyWithImpl(this._self, this._then);

  final OrderDetailError _self;
  final $Res Function(OrderDetailError) _then;

/// Create a copy of OrderDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OrderDetailError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
