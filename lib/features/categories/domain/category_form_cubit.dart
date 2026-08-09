import 'dart:io';

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
  /// Category saved successfully but the image upload/replace failed.
  /// The caller should close the form and show a warning snackbar.
  const factory CategoryFormState.successWithImageWarning(int categoryId) =
      CategoryFormSuccessWithImageWarning;
  const factory CategoryFormState.error(String message) = CategoryFormError;
}

class CategoryFormCubit extends Cubit<CategoryFormState> {
  final CategoriesService _service;

  CategoryFormCubit(this._service) : super(const CategoryFormState.initial());

  Future<CategoryDetail> loadDetail(int id) => _service.getCategory(id);

  Future<void> create(CategoryRequest request, {File? image}) async {
    emit(const CategoryFormState.loading());
    try {
      final id = await _service.createCategory(request);
      if (image != null) {
        try {
          await _service.uploadCategoryImage(id, image);
        } catch (_) {
          emit(CategoryFormState.successWithImageWarning(id));
          return;
        }
      }
      emit(CategoryFormState.success(id));
    } on ApiException catch (e) {
      emit(CategoryFormState.error(e.message));
    } catch (_) {
      emit(const CategoryFormState.error('فشل إنشاء الفئة'));
    }
  }

  Future<void> update(int id, CategoryRequest request, {File? image}) async {
    emit(const CategoryFormState.loading());
    try {
      await _service.updateCategory(id, request);
      if (image != null) {
        try {
          await _service.uploadCategoryImage(id, image);
        } catch (_) {
          emit(CategoryFormState.successWithImageWarning(id));
          return;
        }
      }
      emit(CategoryFormState.success(id));
    } on ApiException catch (e) {
      emit(CategoryFormState.error(e.message));
    } catch (_) {
      emit(const CategoryFormState.error('فشل تحديث الفئة'));
    }
  }
}
