import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/network/api_response.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';
import 'package:my_gallery/features/products/data/products_service.dart';

part 'products_list_cubit.freezed.dart';

@freezed
sealed class ProductsListState with _$ProductsListState {
  const factory ProductsListState.initial() = ProductsListInitial;
  const factory ProductsListState.loading() = ProductsListLoading;
  const factory ProductsListState.loaded({
    required List<ProductListItem> items,
    required PaginationMeta pagination,
    required ProductFilter filter,
  }) = ProductsListLoaded;
  const factory ProductsListState.error(String message) = ProductsListError;
}

class ProductsListCubit extends Cubit<ProductsListState> {
  final ProductsService _service;

  ProductsListCubit(this._service) : super(const ProductsListState.initial());

  List<ProductListItem> _items = [];
  PaginationMeta _pagination = const PaginationMeta();
  ProductFilter _filter = const ProductFilter();
  bool _isFetchingMore = false;

  ProductFilter get currentFilter => _filter;

  Future<void> load({ProductFilter? filter}) async {
    _filter = filter ?? const ProductFilter();
    _items = [];
    emit(const ProductsListState.loading());
    await _fetch();
  }

  Future<void> refresh() => load(filter: _filter.copyWith(page: 1));

  Future<void> loadMore() async {
    if (_isFetchingMore) return;
    if (!_pagination.hasNext) return;
    _isFetchingMore = true;
    _filter = _filter.copyWith(page: _filter.page + 1);
    await _fetch(append: true);
    _isFetchingMore = false;
  }

  Future<void> applyFilter(ProductFilter filter) => load(filter: filter);

  Future<void> _fetch({bool append = false}) async {
    try {
      final resp = await _service.getProducts(_filter);
      if (append) {
        final existingIds = _items.map((p) => p.id).toSet();
        final newItems = resp.data?.where((p) => !existingIds.contains(p.id)) ?? [];
        _items = [..._items, ...newItems];
      } else {
        _items = resp.data ?? [];
      }
      _pagination = resp.pagination ?? const PaginationMeta();
      emit(ProductsListState.loaded(
        items: _items,
        pagination: _pagination,
        filter: _filter,
      ));
    } on ApiException catch (e) {
      emit(ProductsListState.error(e.message));
    } catch (_) {
      emit(const ProductsListState.error('فشل تحميل المنتجات'));
    }
  }

  Future<void> toggleActive(int productId, bool currentlyActive) async {
    try {
      if (currentlyActive) {
        await _service.deactivateProduct(productId);
      } else {
        await _service.activateProduct(productId);
      }
      _items = _items.map((p) {
        if (p.id == productId) return p.copyWith(isActive: !currentlyActive);
        return p;
      }).toList();
      final current = state;
      if (current is ProductsListLoaded) {
        emit(current.copyWith(items: _items));
      }
    } on ApiException catch (e) {
      emit(ProductsListState.error(e.message));
    }
  }
}
