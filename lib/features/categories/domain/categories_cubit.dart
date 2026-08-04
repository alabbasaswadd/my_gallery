import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/categories/data/categories_service.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';

part 'categories_cubit.freezed.dart';

@freezed
sealed class CategoriesState with _$CategoriesState {
  const factory CategoriesState.initial() = CategoriesInitial;
  const factory CategoriesState.loading() = CategoriesLoading;
  const factory CategoriesState.loaded(List<CategoryListItem> categories) = CategoriesLoaded;
  const factory CategoriesState.error(String message) = CategoriesError;
}

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesService _service;

  CategoriesCubit(this._service) : super(const CategoriesState.initial());

  List<CategoryListItem> _categories = [];

  Future<void> load() async {
    emit(const CategoriesState.loading());
    try {
      _categories = await _service.getCategories();
      emit(CategoriesState.loaded(_categories));
    } on ApiException catch (e) {
      emit(CategoriesState.error(e.message));
    } catch (_) {
      emit(const CategoriesState.error('فشل تحميل الفئات'));
    }
  }

  Future<void> refresh() => load();

  Future<void> toggleActive(int id, bool currentlyActive) async {
    try {
      if (currentlyActive) {
        await _service.deactivateCategory(id);
      } else {
        await _service.activateCategory(id);
      }
      _categories = _categories.map((c) {
        if (c.id == id) return c.copyWith(isActive: !currentlyActive);
        return c;
      }).toList();
      emit(CategoriesState.loaded(_categories));
    } on ApiException catch (e) {
      emit(CategoriesState.error(e.message));
    }
  }

  Future<void> reorder(List<CategoryListItem> reordered) async {
    _categories = reordered;
    emit(CategoriesState.loaded(_categories));
    try {
      await _service.reorderCategories(reordered.map((c) => c.id).toList());
    } on ApiException catch (e) {
      emit(CategoriesState.error(e.message));
    }
  }

  Future<void> delete(int id) async {
    try {
      await _service.deleteCategory(id);
      _categories = _categories.where((c) => c.id != id).toList();
      emit(CategoriesState.loaded(_categories));
    } on ApiException catch (e) {
      emit(CategoriesState.error(e.message));
    }
  }
}
