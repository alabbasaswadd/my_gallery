import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/features/cart/data/models/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_cubit.freezed.dart';

@freezed
sealed class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<CartItem> items,
  }) = _CartState;
}

class CartCubit extends Cubit<CartState> {
  static const _key = 'cart_items';

  CartCubit() : super(const CartState()) {
    _load();
  }

  List<CartItem> get items => state.items;

  double get total => items.fold(0, (sum, i) => sum + i.unitPrice * i.quantity);

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);

  void add(CartItem item) {
    final existing = items.indexWhere((i) => i.productId == item.productId);
    List<CartItem> updated;
    if (existing >= 0) {
      updated = [...items];
      updated[existing] =
          updated[existing].copyWith(quantity: updated[existing].quantity + 1);
    } else {
      updated = [...items, item];
    }
    emit(CartState(items: updated));
    _persist(updated);
  }

  void remove(int productId) {
    final updated = items.where((i) => i.productId != productId).toList();
    emit(CartState(items: updated));
    _persist(updated);
  }

  void setQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      remove(productId);
      return;
    }
    final updated = items.map((i) {
      return i.productId == productId ? i.copyWith(quantity: quantity) : i;
    }).toList();
    emit(CartState(items: updated));
    _persist(updated);
  }

  void clear() {
    emit(const CartState());
    _persist([]);
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) return;
    try {
      final list = (jsonDecode(json) as List)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(CartState(items: list));
    } catch (_) {}
  }

  Future<void> _persist(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _key, jsonEncode(items.map((i) => i.toJson()).toList()));
  }
}
