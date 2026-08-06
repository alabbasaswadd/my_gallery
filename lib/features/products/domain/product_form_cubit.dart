import 'dart:io';

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

  /// Creates or updates a product, then handles image replacements and new uploads.
  ///
  /// [request] carries removeImageIds and coverImageId for batched image/cover changes.
  /// [replacements] maps existing image ids to their replacement files.
  /// [newImages] are local files to append (first becomes cover when no existing cover).
  Future<void> submit({
    required ProductRequest request,
    int? existingId,
    List<File> newImages = const [],
    Map<int, File> replacements = const {},
  }) async {
    emit(const ProductFormState.loading());
    try {
      final int id;
      if (existingId == null) {
        id = await _service.createProduct(request);
      } else {
        await _service.updateProduct(existingId, request);
        id = existingId;
      }

      for (final e in replacements.entries) {
        await _service.replaceImage(id, e.key, e.value);
      }
      if (newImages.isNotEmpty) {
        await _service.uploadImages(id, newImages);
      }
      emit(ProductFormState.success(id));
    } on ApiException catch (e) {
      emit(ProductFormState.error(e.message));
    } catch (_) {
      emit(ProductFormState.error(
          existingId == null ? 'فشل إنشاء المنتج' : 'فشل تحديث المنتج'));
    }
  }
}
