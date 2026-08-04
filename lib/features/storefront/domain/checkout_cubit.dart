import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/cart/data/models/cart_item.dart';
import 'package:my_gallery/features/storefront/data/models/storefront_models.dart';
import 'package:my_gallery/features/storefront/data/storefront_service.dart';

part 'checkout_cubit.freezed.dart';

@freezed
sealed class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = CheckoutInitial;
  const factory CheckoutState.loading() = CheckoutLoading;
  const factory CheckoutState.success(PlaceOrderResult result) = CheckoutSuccess;
  const factory CheckoutState.error(String message) = CheckoutError;
}

class CheckoutCubit extends Cubit<CheckoutState> {
  final StorefrontService _service;

  CheckoutCubit(this._service) : super(const CheckoutState.initial());

  Future<void> placeOrder({
    required String whatsApp,
    String? name,
    String? notes,
    required List<CartItem> items,
  }) async {
    emit(const CheckoutState.loading());
    try {
      final result = await _service.placeOrder(PlaceOrderRequest(
        customerWhatsApp: whatsApp.trim(),
        customerName: name?.trim(),
        notes: notes?.trim(),
        items: items
            .map((i) => OrderItemRequest(
                  productId: i.productId,
                  quantity: i.quantity,
                ))
            .toList(),
      ));
      emit(CheckoutState.success(result));
    } on ApiException catch (e) {
      emit(CheckoutState.error(e.message));
    } catch (_) {
      emit(const CheckoutState.error('فشل إرسال الطلب، حاول مرة أخرى'));
    }
  }
}
