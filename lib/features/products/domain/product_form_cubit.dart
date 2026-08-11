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

  /// Creates or updates a product, then handles image replacements, new uploads
  /// and the cover selection.
  ///
  /// [request] carries removeImageIds (and, for an existing-image cover, a
  /// coverImageId hint). [replacements] maps existing image ids to their
  /// replacement files. [newImages] are local files to append.
  ///
  /// The cover is applied last via the dedicated `PATCH /cover-image` endpoint,
  /// which is unambiguous, rather than relying on the PUT's coverImageId:
  /// - [coverImageId] — an existing image chosen as cover, or null.
  /// - [coverNewImageIndex] — index into [newImages] chosen as cover, or null.
  ///   Its id is resolved after upload (the newly-added images are the last ones
  ///   by sort order, in upload order).
  Future<void> submit({
    required ProductRequest request,
    int? existingId,
    List<File> newImages = const [],
    Map<int, File> replacements = const {},
    int? coverImageId,
    int? coverNewImageIndex,
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

      await _applyCover(
        productId: id,
        coverImageId: coverImageId,
        coverNewImageIndex: coverNewImageIndex,
        newImageCount: newImages.length,
      );

      emit(ProductFormState.success(id));
    } on ApiException catch (e) {
      emit(ProductFormState.error(e.message));
    } catch (_) {
      emit(ProductFormState.error(
          existingId == null ? 'فشل إنشاء المنتج' : 'فشل تحديث المنتج'));
    }
  }

  /// Sets the product cover via `PATCH /cover-image`. For a newly-uploaded cover
  /// the target id is resolved by re-fetching the product: the just-added images
  /// are the last [newImageCount] when ordered by sort order, matching upload
  /// order, so [coverNewImageIndex] maps directly onto them.
  Future<void> _applyCover({
    required int productId,
    int? coverImageId,
    int? coverNewImageIndex,
    int newImageCount = 0,
  }) async {
    if (coverNewImageIndex != null && newImageCount > 0) {
      final detail = await _service.getProduct(productId);
      final images = [...detail.images]
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      if (images.length >= newImageCount) {
        final added = images.sublist(images.length - newImageCount);
        if (coverNewImageIndex >= 0 && coverNewImageIndex < added.length) {
          await _service.setCoverImage(productId, added[coverNewImageIndex].id);
        }
      }
      return;
    }
    if (coverImageId != null) {
      await _service.setCoverImage(productId, coverImageId);
    }
  }
}
