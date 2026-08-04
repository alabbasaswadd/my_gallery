import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/orders/data/models/order_models.dart';
import 'package:my_gallery/features/orders/data/orders_service.dart';

part 'order_detail_cubit.freezed.dart';

@freezed
sealed class OrderDetailState with _$OrderDetailState {
  const factory OrderDetailState.initial() = OrderDetailInitial;
  const factory OrderDetailState.loading() = OrderDetailLoading;
  const factory OrderDetailState.loaded(OrderDetail order) = OrderDetailLoaded;
  const factory OrderDetailState.error(String message) = OrderDetailError;
}

class OrderDetailCubit extends Cubit<OrderDetailState> {
  final OrdersService _service;

  OrderDetailCubit(this._service) : super(const OrderDetailState.initial());

  Future<void> load(int id) async {
    emit(const OrderDetailState.loading());
    try {
      final order = await _service.getOrder(id);
      emit(OrderDetailState.loaded(order));
    } on ApiException catch (e) {
      emit(OrderDetailState.error(e.message));
    } catch (_) {
      emit(const OrderDetailState.error('فشل تحميل تفاصيل الطلب'));
    }
  }

  Future<void> updateStatus(String newStatus) async {
    final current = state;
    if (current is! OrderDetailLoaded) return;
    final optimistic = current.order.copyWith(status: newStatus);
    emit(OrderDetailState.loaded(optimistic));
    try {
      await _service.updateStatus(current.order.id, newStatus);
    } on ApiException catch (e) {
      emit(OrderDetailState.loaded(current.order));
      emit(OrderDetailState.error(e.message));
      emit(OrderDetailState.loaded(current.order));
    }
  }
}
