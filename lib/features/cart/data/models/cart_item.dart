import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
sealed class CartItem with _$CartItem {
  const factory CartItem({
    required int productId,
    required String name,
    required double unitPrice,
    String? imageUrl,
    @Default(1) int quantity,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}
