import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/occasions/data/models/occasion_models.dart';
import 'package:my_gallery/features/occasions/data/occasions_service.dart';

part 'occasion_form_cubit.freezed.dart';

@freezed
sealed class OccasionFormState with _$OccasionFormState {
  const factory OccasionFormState.initial() = OccasionFormInitial;
  const factory OccasionFormState.loading() = OccasionFormLoading;
  const factory OccasionFormState.success(int occasionId) = OccasionFormSuccess;
  const factory OccasionFormState.error(String message) = OccasionFormError;
}

class OccasionFormCubit extends Cubit<OccasionFormState> {
  final OccasionsService _service;

  OccasionFormCubit(this._service) : super(const OccasionFormState.initial());

  /// Fetches the occasion for the edit form. Throws [ApiException] on failure.
  Future<OccasionDetail> loadDetail(int id) => _service.getOccasion(id);

  Future<void> create(OccasionRequest request, {File? image}) async {
    emit(const OccasionFormState.loading());
    try {
      final id = await _service.createOccasion(request);
      if (image != null) {
        await _service.uploadImage(id, image);
      }
      emit(OccasionFormState.success(id));
    } on ApiException catch (e) {
      emit(OccasionFormState.error(e.message));
    } catch (_) {
      emit(const OccasionFormState.error('فشل إنشاء المناسبة'));
    }
  }

  Future<void> update(int id, OccasionRequest request, {File? image}) async {
    emit(const OccasionFormState.loading());
    try {
      await _service.updateOccasion(id, request);
      if (image != null) {
        await _service.uploadImage(id, image);
      }
      emit(OccasionFormState.success(id));
    } on ApiException catch (e) {
      emit(OccasionFormState.error(e.message));
    } catch (_) {
      emit(const OccasionFormState.error('فشل تحديث المناسبة'));
    }
  }
}
