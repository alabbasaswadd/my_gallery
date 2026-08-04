import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';
import 'package:my_gallery/features/products/data/products_service.dart';

part 'product_form_cubit.freezed.dart';

@freezed
sealed class ProductFormState with _$ProductFormState {
  const factory ProductFormState.initial() = ProductFormInitial;
  const factory ProductFormState.loading() = ProductFormLoading;
  const factory ProductFormState.success(int productId) = ProductFormSuccess;
  const factory ProductFormState.error(String message) = ProductFormError;
}

class ProductFormCubit extends Cubit<ProductFormState> {
  final ProductsService _service;

  ProductFormCubit(this._service) : super(const ProductFormState.initial());

  Future<void> create(ProductRequest request) async {
    emit(const ProductFormState.loading());
    try {
      final id = await _service.createProduct(request);
      emit(ProductFormState.success(id));
    } on ApiException catch (e) {
      emit(ProductFormState.error(e.message));
    } catch (_) {
      emit(const ProductFormState.error('فشل إنشاء المنتج'));
    }
  }

  Future<void> update(int id, ProductRequest request) async {
    emit(const ProductFormState.loading());
    try {
      await _service.updateProduct(id, request);
      emit(ProductFormState.success(id));
    } on ApiException catch (e) {
      emit(ProductFormState.error(e.message));
    } catch (_) {
      emit(const ProductFormState.error('فشل تحديث المنتج'));
    }
  }
}
