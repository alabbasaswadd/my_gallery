// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderListItem {

 int get id; String get orderNumber; String? get customerName; String? get customerWhatsApp; String get status; double get totalAmount; int get itemsCount; String? get createdAt;
/// Create a copy of OrderListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderListItemCopyWith<OrderListItem> get copyWith => _$OrderListItemCopyWithImpl<OrderListItem>(this as OrderListItem, _$identity);

  /// Serializes this OrderListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerWhatsApp, customerWhatsApp) || other.customerWhatsApp == customerWhatsApp)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.itemsCount, itemsCount) || other.itemsCount == itemsCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,customerName,customerWhatsApp,status,totalAmount,itemsCount,createdAt);

@override
String toString() {
  return 'OrderListItem(id: $id, orderNumber: $orderNumber, customerName: $customerName, customerWhatsApp: $customerWhatsApp, status: $status, totalAmount: $totalAmount, itemsCount: $itemsCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $OrderListItemCopyWith<$Res>  {
  factory $OrderListItemCopyWith(OrderListItem value, $Res Function(OrderListItem) _then) = _$OrderListItemCopyWithImpl;
@useResult
$Res call({
 int id, String orderNumber, String? customerName, String? customerWhatsApp, String status, double totalAmount, int itemsCount, String? createdAt
});




}
/// @nodoc
class _$OrderListItemCopyWithImpl<$Res>
    implements $OrderListItemCopyWith<$Res> {
  _$OrderListItemCopyWithImpl(this._self, this._then);

  final OrderListItem _self;
  final $Res Function(OrderListItem) _then;

/// Create a copy of OrderListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNumber = null,Object? customerName = freezed,Object? customerWhatsApp = freezed,Object? status = null,Object? totalAmount = null,Object? itemsCount = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerWhatsApp: freezed == customerWhatsApp ? _self.customerWhatsApp : customerWhatsApp // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,itemsCount: null == itemsCount ? _self.itemsCount : itemsCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderListItem].
extension OrderListItemPatterns on OrderListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderListItem value)  $default,){
final _that = this;
switch (_that) {
case _OrderListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderListItem value)?  $default,){
final _that = this;
switch (_that) {
case _OrderListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String orderNumber,  String? customerName,  String? customerWhatsApp,  String status,  double totalAmount,  int itemsCount,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderListItem() when $default != null:
return $default(_that.id,_that.orderNumber,_that.customerName,_that.customerWhatsApp,_that.status,_that.totalAmount,_that.itemsCount,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String orderNumber,  String? customerName,  String? customerWhatsApp,  String status,  double totalAmount,  int itemsCount,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _OrderListItem():
return $default(_that.id,_that.orderNumber,_that.customerName,_that.customerWhatsApp,_that.status,_that.totalAmount,_that.itemsCount,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String orderNumber,  String? customerName,  String? customerWhatsApp,  String status,  double totalAmount,  int itemsCount,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _OrderListItem() when $default != null:
return $default(_that.id,_that.orderNumber,_that.customerName,_that.customerWhatsApp,_that.status,_that.totalAmount,_that.itemsCount,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderListItem implements OrderListItem {
  const _OrderListItem({required this.id, required this.orderNumber, this.customerName, this.customerWhatsApp, required this.status, required this.totalAmount, this.itemsCount = 0, this.createdAt});
  factory _OrderListItem.fromJson(Map<String, dynamic> json) => _$OrderListItemFromJson(json);

@override final  int id;
@override final  String orderNumber;
@override final  String? customerName;
@override final  String? customerWhatsApp;
@override final  String status;
@override final  double totalAmount;
@override@JsonKey() final  int itemsCount;
@override final  String? createdAt;

/// Create a copy of OrderListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderListItemCopyWith<_OrderListItem> get copyWith => __$OrderListItemCopyWithImpl<_OrderListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerWhatsApp, customerWhatsApp) || other.customerWhatsApp == customerWhatsApp)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.itemsCount, itemsCount) || other.itemsCount == itemsCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,customerName,customerWhatsApp,status,totalAmount,itemsCount,createdAt);

@override
String toString() {
  return 'OrderListItem(id: $id, orderNumber: $orderNumber, customerName: $customerName, customerWhatsApp: $customerWhatsApp, status: $status, totalAmount: $totalAmount, itemsCount: $itemsCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$OrderListItemCopyWith<$Res> implements $OrderListItemCopyWith<$Res> {
  factory _$OrderListItemCopyWith(_OrderListItem value, $Res Function(_OrderListItem) _then) = __$OrderListItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String orderNumber, String? customerName, String? customerWhatsApp, String status, double totalAmount, int itemsCount, String? createdAt
});




}
/// @nodoc
class __$OrderListItemCopyWithImpl<$Res>
    implements _$OrderListItemCopyWith<$Res> {
  __$OrderListItemCopyWithImpl(this._self, this._then);

  final _OrderListItem _self;
  final $Res Function(_OrderListItem) _then;

/// Create a copy of OrderListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? customerName = freezed,Object? customerWhatsApp = freezed,Object? status = null,Object? totalAmount = null,Object? itemsCount = null,Object? createdAt = freezed,}) {
  return _then(_OrderListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerWhatsApp: freezed == customerWhatsApp ? _self.customerWhatsApp : customerWhatsApp // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,itemsCount: null == itemsCount ? _self.itemsCount : itemsCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OrderDetail {

 int get id; String get orderNumber; String? get customerName; String? get customerWhatsApp; String? get notes; String get status; double get totalAmount; List<OrderDetailItem> get items; String? get createdAt;
/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailCopyWith<OrderDetail> get copyWith => _$OrderDetailCopyWithImpl<OrderDetail>(this as OrderDetail, _$identity);

  /// Serializes this OrderDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerWhatsApp, customerWhatsApp) || other.customerWhatsApp == customerWhatsApp)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,customerName,customerWhatsApp,notes,status,totalAmount,const DeepCollectionEquality().hash(items),createdAt);

@override
String toString() {
  return 'OrderDetail(id: $id, orderNumber: $orderNumber, customerName: $customerName, customerWhatsApp: $customerWhatsApp, notes: $notes, status: $status, totalAmount: $totalAmount, items: $items, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $OrderDetailCopyWith<$Res>  {
  factory $OrderDetailCopyWith(OrderDetail value, $Res Function(OrderDetail) _then) = _$OrderDetailCopyWithImpl;
@useResult
$Res call({
 int id, String orderNumber, String? customerName, String? customerWhatsApp, String? notes, String status, double totalAmount, List<OrderDetailItem> items, String? createdAt
});




}
/// @nodoc
class _$OrderDetailCopyWithImpl<$Res>
    implements $OrderDetailCopyWith<$Res> {
  _$OrderDetailCopyWithImpl(this._self, this._then);

  final OrderDetail _self;
  final $Res Function(OrderDetail) _then;

/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNumber = null,Object? customerName = freezed,Object? customerWhatsApp = freezed,Object? notes = freezed,Object? status = null,Object? totalAmount = null,Object? items = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerWhatsApp: freezed == customerWhatsApp ? _self.customerWhatsApp : customerWhatsApp // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<OrderDetailItem>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderDetail].
extension OrderDetailPatterns on OrderDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderDetail value)  $default,){
final _that = this;
switch (_that) {
case _OrderDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderDetail value)?  $default,){
final _that = this;
switch (_that) {
case _OrderDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String orderNumber,  String? customerName,  String? customerWhatsApp,  String? notes,  String status,  double totalAmount,  List<OrderDetailItem> items,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderDetail() when $default != null:
return $default(_that.id,_that.orderNumber,_that.customerName,_that.customerWhatsApp,_that.notes,_that.status,_that.totalAmount,_that.items,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String orderNumber,  String? customerName,  String? customerWhatsApp,  String? notes,  String status,  double totalAmount,  List<OrderDetailItem> items,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _OrderDetail():
return $default(_that.id,_that.orderNumber,_that.customerName,_that.customerWhatsApp,_that.notes,_that.status,_that.totalAmount,_that.items,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String orderNumber,  String? customerName,  String? customerWhatsApp,  String? notes,  String status,  double totalAmount,  List<OrderDetailItem> items,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _OrderDetail() when $default != null:
return $default(_that.id,_that.orderNumber,_that.customerName,_that.customerWhatsApp,_that.notes,_that.status,_that.totalAmount,_that.items,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderDetail implements OrderDetail {
  const _OrderDetail({required this.id, required this.orderNumber, this.customerName, this.customerWhatsApp, this.notes, required this.status, required this.totalAmount, final  List<OrderDetailItem> items = const [], this.createdAt}): _items = items;
  factory _OrderDetail.fromJson(Map<String, dynamic> json) => _$OrderDetailFromJson(json);

@override final  int id;
@override final  String orderNumber;
@override final  String? customerName;
@override final  String? customerWhatsApp;
@override final  String? notes;
@override final  String status;
@override final  double totalAmount;
 final  List<OrderDetailItem> _items;
@override@JsonKey() List<OrderDetailItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? createdAt;

/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderDetailCopyWith<_OrderDetail> get copyWith => __$OrderDetailCopyWithImpl<_OrderDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerWhatsApp, customerWhatsApp) || other.customerWhatsApp == customerWhatsApp)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,customerName,customerWhatsApp,notes,status,totalAmount,const DeepCollectionEquality().hash(_items),createdAt);

@override
String toString() {
  return 'OrderDetail(id: $id, orderNumber: $orderNumber, customerName: $customerName, customerWhatsApp: $customerWhatsApp, notes: $notes, status: $status, totalAmount: $totalAmount, items: $items, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$OrderDetailCopyWith<$Res> implements $OrderDetailCopyWith<$Res> {
  factory _$OrderDetailCopyWith(_OrderDetail value, $Res Function(_OrderDetail) _then) = __$OrderDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String orderNumber, String? customerName, String? customerWhatsApp, String? notes, String status, double totalAmount, List<OrderDetailItem> items, String? createdAt
});




}
/// @nodoc
class __$OrderDetailCopyWithImpl<$Res>
    implements _$OrderDetailCopyWith<$Res> {
  __$OrderDetailCopyWithImpl(this._self, this._then);

  final _OrderDetail _self;
  final $Res Function(_OrderDetail) _then;

/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? customerName = freezed,Object? customerWhatsApp = freezed,Object? notes = freezed,Object? status = null,Object? totalAmount = null,Object? items = null,Object? createdAt = freezed,}) {
  return _then(_OrderDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerWhatsApp: freezed == customerWhatsApp ? _self.customerWhatsApp : customerWhatsApp // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<OrderDetailItem>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OrderDetailItem {

@JsonKey(name: 'productId') int get id; String get productName; double get unitPrice; int get quantity; double get lineTotal;
/// Create a copy of OrderDetailItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailItemCopyWith<OrderDetailItem> get copyWith => _$OrderDetailItemCopyWithImpl<OrderDetailItem>(this as OrderDetailItem, _$identity);

  /// Serializes this OrderDetailItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailItem&&(identical(other.id, id) || other.id == id)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productName,unitPrice,quantity,lineTotal);

@override
String toString() {
  return 'OrderDetailItem(id: $id, productName: $productName, unitPrice: $unitPrice, quantity: $quantity, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class $OrderDetailItemCopyWith<$Res>  {
  factory $OrderDetailItemCopyWith(OrderDetailItem value, $Res Function(OrderDetailItem) _then) = _$OrderDetailItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'productId') int id, String productName, double unitPrice, int quantity, double lineTotal
});




}
/// @nodoc
class _$OrderDetailItemCopyWithImpl<$Res>
    implements $OrderDetailItemCopyWith<$Res> {
  _$OrderDetailItemCopyWithImpl(this._self, this._then);

  final OrderDetailItem _self;
  final $Res Function(OrderDetailItem) _then;

/// Create a copy of OrderDetailItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productName = null,Object? unitPrice = null,Object? quantity = null,Object? lineTotal = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderDetailItem].
extension OrderDetailItemPatterns on OrderDetailItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderDetailItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderDetailItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderDetailItem value)  $default,){
final _that = this;
switch (_that) {
case _OrderDetailItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderDetailItem value)?  $default,){
final _that = this;
switch (_that) {
case _OrderDetailItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'productId')  int id,  String productName,  double unitPrice,  int quantity,  double lineTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderDetailItem() when $default != null:
return $default(_that.id,_that.productName,_that.unitPrice,_that.quantity,_that.lineTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'productId')  int id,  String productName,  double unitPrice,  int quantity,  double lineTotal)  $default,) {final _that = this;
switch (_that) {
case _OrderDetailItem():
return $default(_that.id,_that.productName,_that.unitPrice,_that.quantity,_that.lineTotal);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'productId')  int id,  String productName,  double unitPrice,  int quantity,  double lineTotal)?  $default,) {final _that = this;
switch (_that) {
case _OrderDetailItem() when $default != null:
return $default(_that.id,_that.productName,_that.unitPrice,_that.quantity,_that.lineTotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderDetailItem implements OrderDetailItem {
  const _OrderDetailItem({@JsonKey(name: 'productId') required this.id, required this.productName, required this.unitPrice, required this.quantity, required this.lineTotal});
  factory _OrderDetailItem.fromJson(Map<String, dynamic> json) => _$OrderDetailItemFromJson(json);

@override@JsonKey(name: 'productId') final  int id;
@override final  String productName;
@override final  double unitPrice;
@override final  int quantity;
@override final  double lineTotal;

/// Create a copy of OrderDetailItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderDetailItemCopyWith<_OrderDetailItem> get copyWith => __$OrderDetailItemCopyWithImpl<_OrderDetailItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderDetailItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderDetailItem&&(identical(other.id, id) || other.id == id)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productName,unitPrice,quantity,lineTotal);

@override
String toString() {
  return 'OrderDetailItem(id: $id, productName: $productName, unitPrice: $unitPrice, quantity: $quantity, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class _$OrderDetailItemCopyWith<$Res> implements $OrderDetailItemCopyWith<$Res> {
  factory _$OrderDetailItemCopyWith(_OrderDetailItem value, $Res Function(_OrderDetailItem) _then) = __$OrderDetailItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'productId') int id, String productName, double unitPrice, int quantity, double lineTotal
});




}
/// @nodoc
class __$OrderDetailItemCopyWithImpl<$Res>
    implements _$OrderDetailItemCopyWith<$Res> {
  __$OrderDetailItemCopyWithImpl(this._self, this._then);

  final _OrderDetailItem _self;
  final $Res Function(_OrderDetailItem) _then;

/// Create a copy of OrderDetailItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productName = null,Object? unitPrice = null,Object? quantity = null,Object? lineTotal = null,}) {
  return _then(_OrderDetailItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
