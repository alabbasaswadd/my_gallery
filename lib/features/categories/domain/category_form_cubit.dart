import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/categories/data/categories_service.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';

part 'category_form_cubit.freezed.dart';

@freezed
sealed class CategoryFormState with _$CategoryFormState {
  const factory CategoryFormState.initial() = CategoryFormInitial;
  const factory CategoryFormState.loading() = CategoryFormLoading;
  const factory CategoryFormState.success(int categoryId) = CategoryFormSuccess;
  const factory CategoryFormState.error(String message) = CategoryFormError;
}

class CategoryFormCubit extends Cubit<CategoryFormState> {
  final CategoriesService _service;

  CategoryFormCubit(this._service) : super(const CategoryFormState.initial());

  /// Fetches the full category for the edit form. Throws [ApiException] on
  /// failure so the screen can render a load-error state with retry.
  Future<CategoryDetail> loadDetail(int id) => _service.getCategory(id);

  Future<void> create(CategoryRequest request) async {
    emit(const CategoryFormState.loading());
    try {
      final id = await _service.createCategory(request);
      emit(CategoryFormState.success(id));
    } on ApiException catch (e) {
      emit(CategoryFormState.error(e.message));
    } catch (_) {
      emit(const CategoryFormState.error('فشل إنشاء الفئة'));
    }
  }

  Future<void> update(int id, CategoryRequest request) async {
    emit(const CategoryFormState.loading());
    try {
      await _service.updateCategory(id, request);
      emit(CategoryFormState.success(id));
    } on ApiException catch (e) {
      emit(CategoryFormState.error(e.message));
    } catch (_) {
      emit(const CategoryFormState.error('فشل تحديث الفئة'));
    }
  }
}
