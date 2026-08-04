// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrdersListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrdersListState()';
}


}

/// @nodoc
class $OrdersListStateCopyWith<$Res>  {
$OrdersListStateCopyWith(OrdersListState _, $Res Function(OrdersListState) __);
}


/// Adds pattern-matching-related methods to [OrdersListState].
extension OrdersListStatePatterns on OrdersListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrdersListInitial value)?  initial,TResult Function( OrdersListLoading value)?  loading,TResult Function( OrdersListLoaded value)?  loaded,TResult Function( OrdersListError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrdersListInitial() when initial != null:
return initial(_that);case OrdersListLoading() when loading != null:
return loading(_that);case OrdersListLoaded() when loaded != null:
return loaded(_that);case OrdersListError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrdersListInitial value)  initial,required TResult Function( OrdersListLoading value)  loading,required TResult Function( OrdersListLoaded value)  loaded,required TResult Function( OrdersListError value)  error,}){
final _that = this;
switch (_that) {
case OrdersListInitial():
return initial(_that);case OrdersListLoading():
return loading(_that);case OrdersListLoaded():
return loaded(_that);case OrdersListError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrdersListInitial value)?  initial,TResult? Function( OrdersListLoading value)?  loading,TResult? Function( OrdersListLoaded value)?  loaded,TResult? Function( OrdersListError value)?  error,}){
final _that = this;
switch (_that) {
case OrdersListInitial() when initial != null:
return initial(_that);case OrdersListLoading() when loading != null:
return loading(_that);case OrdersListLoaded() when loaded != null:
return loaded(_that);case OrdersListError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<OrderListItem> orders,  PaginationMeta pagination,  String statusFilter)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrdersListInitial() when initial != null:
return initial();case OrdersListLoading() when loading != null:
return loading();case OrdersListLoaded() when loaded != null:
return loaded(_that.orders,_that.pagination,_that.statusFilter);case OrdersListError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<OrderListItem> orders,  PaginationMeta pagination,  String statusFilter)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case OrdersListInitial():
return initial();case OrdersListLoading():
return loading();case OrdersListLoaded():
return loaded(_that.orders,_that.pagination,_that.statusFilter);case OrdersListError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<OrderListItem> orders,  PaginationMeta pagination,  String statusFilter)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case OrdersListInitial() when initial != null:
return initial();case OrdersListLoading() when loading != null:
return loading();case OrdersListLoaded() when loaded != null:
return loaded(_that.orders,_that.pagination,_that.statusFilter);case OrdersListError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class OrdersListInitial implements OrdersListState {
  const OrdersListInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersListInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrdersListState.initial()';
}


}




/// @nodoc


class OrdersListLoading implements OrdersListState {
  const OrdersListLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersListLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrdersListState.loading()';
}


}




/// @nodoc


class OrdersListLoaded implements OrdersListState {
  const OrdersListLoaded({required final  List<OrderListItem> orders, required this.pagination, required this.statusFilter}): _orders = orders;
  

 final  List<OrderListItem> _orders;
 List<OrderListItem> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

 final  PaginationMeta pagination;
 final  String statusFilter;

/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrdersListLoadedCopyWith<OrdersListLoaded> get copyWith => _$OrdersListLoadedCopyWithImpl<OrdersListLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersListLoaded&&const DeepCollectionEquality().equals(other._orders, _orders)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders),pagination,statusFilter);

@override
String toString() {
  return 'OrdersListState.loaded(orders: $orders, pagination: $pagination, statusFilter: $statusFilter)';
}


}

/// @nodoc
abstract mixin class $OrdersListLoadedCopyWith<$Res> implements $OrdersListStateCopyWith<$Res> {
  factory $OrdersListLoadedCopyWith(OrdersListLoaded value, $Res Function(OrdersListLoaded) _then) = _$OrdersListLoadedCopyWithImpl;
@useResult
$Res call({
 List<OrderListItem> orders, PaginationMeta pagination, String statusFilter
});


$PaginationMetaCopyWith<$Res> get pagination;

}
/// @nodoc
class _$OrdersListLoadedCopyWithImpl<$Res>
    implements $OrdersListLoadedCopyWith<$Res> {
  _$OrdersListLoadedCopyWithImpl(this._self, this._then);

  final OrdersListLoaded _self;
  final $Res Function(OrdersListLoaded) _then;

/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,Object? pagination = null,Object? statusFilter = null,}) {
  return _then(OrdersListLoaded(
orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderListItem>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationMeta,statusFilter: null == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationMetaCopyWith<$Res> get pagination {
  
  return $PaginationMetaCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}

/// @nodoc


class OrdersListError implements OrdersListState {
  const OrdersListError(this.message);
  

 final  String message;

/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrdersListErrorCopyWith<OrdersListError> get copyWith => _$OrdersListErrorCopyWithImpl<OrdersListError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersListError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OrdersListState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $OrdersListErrorCopyWith<$Res> implements $OrdersListStateCopyWith<$Res> {
  factory $OrdersListErrorCopyWith(OrdersListError value, $Res Function(OrdersListError) _then) = _$OrdersListErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OrdersListErrorCopyWithImpl<$Res>
    implements $OrdersListErrorCopyWith<$Res> {
  _$OrdersListErrorCopyWithImpl(this._self, this._then);

  final OrdersListError _self;
  final $Res Function(OrdersListError) _then;

/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OrdersListError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
