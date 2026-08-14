import 'dart:async';

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
  const factory OrdersListState.error(String message, [ApiErrorKind? kind]) =
      OrdersListError;
}

class OrdersListCubit extends Cubit<OrdersListState> {
  final OrdersService _service;
  Timer? _pollTimer;

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

  /// Fetches page 1 without emitting [OrdersListLoading], so the existing list
  /// stays visible during pull-to-refresh and after returning from detail.
  Future<void> refresh() async {
    if (_fetching) return;
    try {
      final resp = await _service.getOrders(
        status: _status == 'All' ? null : _status,
        page: 1,
      );
      _orders = resp.data ?? [];
      _page = 1;
      _pagination = resp.pagination ?? const PaginationMeta();
      if (!isClosed) {
        emit(OrdersListState.loaded(
          orders: _orders,
          pagination: _pagination,
          statusFilter: _status,
        ));
        _startPolling();
      }
    } on ApiException catch (e) {
      emit(OrdersListState.error(e.message, e.kind));
    } catch (_) {
      emit(const OrdersListState.error('فشل تحميل الطلبات'));
    }
  }

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
      if (isClosed) return;
      if (append) {
        _orders = [..._orders, ...?resp.data];
      } else {
        _orders = resp.data ?? [];
      }
      _pagination = resp.pagination ?? const PaginationMeta();
      emit(OrdersListState.loaded(
        orders: _orders,
        pagination: _pagination,
        statusFilter: _status,
      ));
      // Start/restart the background poll after every fresh (non-append) load
      if (!append) _startPolling();
    } on ApiException catch (e) {
      if (!isClosed) emit(OrdersListState.error(e.message, e.kind));
    } catch (_) {
      if (!isClosed) emit(const OrdersListState.error('فشل تحميل الطلبات'));
    }
  }

  // ── Background polling ────────────────────────────────────────────────────

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(
      const Duration(seconds: 20),
      (_) => _pollRefresh(),
    );
  }

  Future<void> _pollRefresh() async {
    // Skip if a user-initiated fetch is in progress or the cubit is closed
    if (_fetching || isClosed || state is OrdersListLoading) return;
    try {
      final resp = await _service.getOrders(
        status: _status == 'All' ? null : _status,
        page: 1,
      );
      final fresh = resp.data ?? [];

      // Compare a short signature of the top items (id + status).
      // Emitting only on an actual change avoids unnecessary rebuilds.
      String sig(List<OrderListItem> list) =>
          list.take(10).map((o) => '${o.id}:${o.status}').join('|');

      if (fresh.length != _orders.length || sig(fresh) != sig(_orders)) {
        _orders = fresh;
        _pagination = resp.pagination ?? _pagination;
        if (!isClosed) {
          emit(OrdersListState.loaded(
            orders: _orders,
            pagination: _pagination,
            statusFilter: _status,
          ));
        }
      }
    } catch (_) {
      // Silent: background failures must not disrupt the visible UI
    }
  }

  // ── Sync helper called by OrderDetailScreen ───────────────────────────────

  void updateOrderStatus(int orderId, String newStatus) {
    _orders = _orders
        .map((o) => o.id == orderId ? o.copyWith(status: newStatus) : o)
        .toList();
    final current = state;
    if (current is OrdersListLoaded) {
      emit(current.copyWith(orders: _orders));
    }
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}
