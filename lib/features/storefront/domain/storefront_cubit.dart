import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/network/api_response.dart';
import 'package:my_gallery/features/storefront/data/models/storefront_models.dart';
import 'package:my_gallery/features/storefront/data/storefront_service.dart';

part 'storefront_cubit.freezed.dart';

@freezed
sealed class StorefrontState with _$StorefrontState {
  const factory StorefrontState.initial() = StorefrontInitial;
  const factory StorefrontState.loading() = StorefrontLoading;
  const factory StorefrontState.loaded({
    required List<StorefrontProduct> products,
    required PaginationMeta pagination,
    required List<StorefrontCategory> categories,
    int? selectedCategoryId,
    String? search,
  }) = StorefrontLoaded;
  const factory StorefrontState.error(String message) = StorefrontError;
}

class StorefrontCubit extends Cubit<StorefrontState> {
  final StorefrontService _service;

  StorefrontCubit(this._service) : super(const StorefrontState.initial());

  List<StorefrontProduct> _products = [];
  PaginationMeta _pagination = const PaginationMeta();
  List<StorefrontCategory> _categories = [];
  int? _categoryId;
  String? _search;
  int _page = 1;
  bool _fetching = false;

  Future<void> load() async {
    _page = 1;
    _products = [];
    emit(const StorefrontState.loading());
    await Future.wait([_fetchProducts(), _fetchCategories()]);
    _emitLoaded();
  }

  Future<void> refresh() => load();

  Future<void> loadMore() async {
    if (_fetching || !_pagination.hasNext) return;
    _page++;
    await _fetchProducts(append: true);
    _emitLoaded();
  }

  Future<void> filter({int? categoryId, String? search}) async {
    _categoryId = categoryId;
    _search = search;
    _page = 1;
    _products = [];
    await _fetchProducts();
    _emitLoaded();
  }

  Future<void> _fetchProducts({bool append = false}) async {
    _fetching = true;
    try {
      final resp = await _service.getProducts(
        search: _search,
        categoryId: _categoryId,
        page: _page,
      );
      if (append) {
        _products = [..._products, ...?resp.data];
      } else {
        _products = resp.data ?? [];
      }
      _pagination = resp.pagination ?? const PaginationMeta();
    } on ApiException catch (e) {
      emit(StorefrontState.error(e.message));
    } catch (_) {
      emit(const StorefrontState.error('فشل تحميل المنتجات'));
    } finally {
      _fetching = false;
    }
  }

  Future<void> _fetchCategories() async {
    try {
      _categories = await _service.getCategories();
    } catch (_) {}
  }

  void _emitLoaded() {
    emit(StorefrontState.loaded(
      products: _products,
      pagination: _pagination,
      categories: _categories,
      selectedCategoryId: _categoryId,
      search: _search,
    ));
  }
}
