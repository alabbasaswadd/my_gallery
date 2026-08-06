import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/network/api_response.dart';
import 'package:my_gallery/features/orders/data/models/order_models.dart';
import 'package:my_gallery/features/orders/data/orders_service.dart';

part 'orders_list_cubit.freezed.dart';

@freezed
sealed class OrdersListState with _$OrdersListState {
  const factory OrdersListState.initial() = OrdersListInitial;
  const factory OrdersListState.loading() = OrdersListLoading;
  const factory OrdersListState.loaded({
    required List<OrderListItem> orders,
    required PaginationMeta pagination,
    required String statusFilter,
  }) = OrdersListLoaded;
  const factory OrdersListState.error(String message) = OrdersListError;
}

class OrdersListCubit extends Cubit<OrdersListState> {
  final OrdersService _service;

  OrdersListCubit(this._service) : super(const OrdersListState.initial());

  List<OrderListItem> _orders = [];
  PaginationMeta _pagination = const PaginationMeta();
  String _status = 'All';
  int _page = 1;
  bool _fetching = false;

  String get currentStatus => _status;

  Future<void> load({String status = 'All'}) async {
    _status = status;
    _page = 1;
    _orders = [];
    emit(const OrdersListState.loading());
    await _fetch();
  }

  Future<void> refresh() => load(status: _status);

  Future<void> loadMore() async {
    if (_fetching || !_pagination.hasNext) return;
    _fetching = true;
    _page++;
    await _fetch(append: true);
    _fetching = false;
  }

  Future<void> filterByStatus(String status) => load(status: status);

  Future<void> _fetch({bool append = false}) async {
    try {
      final resp = await _service.getOrders(
        status: _status == 'All' ? null : _status,
        page: _page,
      );
      if (append) {
        _orders = [..._orders, ...?resp.data];
      } else {
        _orders = resp.data ?? [];
      }
      _pagination = resp.pagination ?? const PaginationMeta();
      emit(
        OrdersListState.loaded(
          orders: _orders,
          pagination: _pagination,
          statusFilter: _status,
        ),
      );
    } on ApiException catch (e) {
      emit(OrdersListState.error(e.message));
    } catch (_) {
      emit(const OrdersListState.error('فشل تحميل الطلبات'));
    }
  }

  void updateOrderStatus(int orderId, String newStatus) {
    _orders = _orders.map((o) {
      return o.id == orderId ? o.copyWith(status: newStatus) : o;
    }).toList();
    final current = state;
    if (current is OrdersListLoaded) {
      emit(current.copyWith(orders: _orders));
    }
  }
}
