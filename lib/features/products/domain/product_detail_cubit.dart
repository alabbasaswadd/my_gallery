import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';
import 'package:my_gallery/features/products/data/products_service.dart';

part 'product_detail_cubit.freezed.dart';

@freezed
sealed class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.initial() = ProductDetailInitial;
  const factory ProductDetailState.loading() = ProductDetailLoading;
  const factory ProductDetailState.loaded(ProductDetail product) = ProductDetailLoaded;
  const factory ProductDetailState.error(String message) = ProductDetailError;
  const factory ProductDetailState.actionSuccess(String message, ProductDetail product) = ProductDetailActionSuccess;
}

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductsService _service;

  ProductDetailCubit(this._service) : super(const ProductDetailState.initial());

  Future<void> load(int id) async {
    emit(const ProductDetailState.loading());
    try {
      final product = await _service.getProduct(id);
      emit(ProductDetailState.loaded(product));
    } on ApiException catch (e) {
      emit(ProductDetailState.error(e.message));
    } catch (_) {
      emit(const ProductDetailState.error('فشل تحميل المنتج'));
    }
  }

  Future<void> toggleActive() async {
    final current = state;
    if (current is! ProductDetailLoaded) return;
    final product = current.product;
    try {
      if (product.isActive) {
        await _service.deactivateProduct(product.id);
      } else {
        await _service.activateProduct(product.id);
      }
      final updated = product.copyWith(isActive: !product.isActive);
      emit(ProductDetailState.actionSuccess(
        product.isActive ? 'تم إلغاء تفعيل المنتج' : 'تم تفعيل المنتج',
        updated,
      ));
      emit(ProductDetailState.loaded(updated));
    } on ApiException catch (e) {
      emit(ProductDetailState.error(e.message));
    }
  }

  Future<void> updateStock(int quantity) async {
    final current = state;
    if (current is! ProductDetailLoaded) return;
    try {
      await _service.updateStock(current.product.id, quantity);
      final updated = current.product.copyWith(stockQuantity: quantity);
      emit(ProductDetailState.actionSuccess('تم تحديث المخزون', updated));
      emit(ProductDetailState.loaded(updated));
    } on ApiException catch (e) {
      emit(ProductDetailState.error(e.message));
    }
  }

  Future<void> updatePrice(double price) async {
    final current = state;
    if (current is! ProductDetailLoaded) return;
    try {
      await _service.updatePrice(current.product.id, price);
      final updated = current.product.copyWith(price: price);
      emit(ProductDetailState.actionSuccess('تم تحديث السعر', updated));
      emit(ProductDetailState.loaded(updated));
    } on ApiException catch (e) {
      emit(ProductDetailState.error(e.message));
    }
  }

  Future<void> updateDiscount(double? discount) async {
    final current = state;
    if (current is! ProductDetailLoaded) return;
    try {
      await _service.updateDiscount(current.product.id, discount);
      final updated = current.product.copyWith(discountPrice: discount);
      emit(ProductDetailState.actionSuccess('تم تحديث الخصم', updated));
      emit(ProductDetailState.loaded(updated));
    } on ApiException catch (e) {
      emit(ProductDetailState.error(e.message));
    }
  }

  Future<void> duplicate() async {
    final current = state;
    if (current is! ProductDetailLoaded) return;
    try {
      final newId = await _service.duplicateProduct(current.product.id);
      emit(ProductDetailState.actionSuccess('تم نسخ المنتج (رقم $newId)', current.product));
      emit(ProductDetailState.loaded(current.product));
    } on ApiException catch (e) {
      emit(ProductDetailState.error(e.message));
    }
  }

  Future<void> delete() async {
    final current = state;
    if (current is! ProductDetailLoaded) return;
    try {
      await _service.deleteProduct(current.product.id);
    } on ApiException catch (e) {
      emit(ProductDetailState.error(e.message));
    }
  }

  Future<void> uploadImages(List<File> files) async {
    final current = state;
    if (current is! ProductDetailLoaded) return;
    try {
      await _service.uploadImages(current.product.id, files);
      await load(current.product.id);
    } on ApiException catch (e) {
      emit(ProductDetailState.error(e.message));
    }
  }

  Future<void> deleteImage(int imageId) async {
    final current = state;
    if (current is! ProductDetailLoaded) return;
    try {
      await _service.deleteImage(current.product.id, imageId);
      final updatedImages = current.product.images.where((i) => i.id != imageId).toList();
      final updated = current.product.copyWith(images: updatedImages);
      emit(ProductDetailState.loaded(updated));
    } on ApiException catch (e) {
      emit(ProductDetailState.error(e.message));
    }
  }

  Future<void> setCover(int imageId) async {
    final current = state;
    if (current is! ProductDetailLoaded) return;
    try {
      await _service.setCoverImage(current.product.id, imageId);
      final updatedImages = current.product.images.map((img) {
        return img.copyWith(isCover: img.id == imageId);
      }).toList();
      final updated = current.product.copyWith(images: updatedImages);
      emit(ProductDetailState.loaded(updated));
    } on ApiException catch (e) {
      emit(ProductDetailState.error(e.message));
    }
  }
}
