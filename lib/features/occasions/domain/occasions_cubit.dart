import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/occasions/data/models/occasion_models.dart';
import 'package:my_gallery/features/occasions/data/occasions_service.dart';

part 'occasions_cubit.freezed.dart';

@freezed
sealed class OccasionsState with _$OccasionsState {
  const factory OccasionsState.initial() = OccasionsInitial;
  const factory OccasionsState.loading() = OccasionsLoading;
  const factory OccasionsState.loaded(List<OccasionListItem> occasions) =
      OccasionsLoaded;
  const factory OccasionsState.error(String message) = OccasionsError;
}

class OccasionsCubit extends Cubit<OccasionsState> {
  final OccasionsService _service;
  Timer? _pollTimer;

  OccasionsCubit(this._service) : super(const OccasionsState.initial());

  List<OccasionListItem> _occasions = [];

  Future<void> load() async {
    emit(const OccasionsState.loading());
    try {
      _occasions = await _service.getOccasions();
      emit(OccasionsState.loaded(_occasions));
      _startPolling();
    } on ApiException catch (e) {
      emit(OccasionsState.error(e.message));
    } catch (_) {
      emit(const OccasionsState.error('فشل تحميل المناسبات'));
    }
  }

  Future<void> refresh() => load();

  // ── Background polling ────────────────────────────────────────────────────

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _pollRefresh(),
    );
  }

  Future<void> _pollRefresh() async {
    if (isClosed || state is OccasionsLoading) return;
    try {
      final fresh = await _service.getOccasions();

      String sig(List<OccasionListItem> list) =>
          list.map((o) => '${o.id}:${o.isActive}:${o.productCount}').join('|');

      if (fresh.length != _occasions.length || sig(fresh) != sig(_occasions)) {
        _occasions = fresh;
        if (!isClosed) emit(OccasionsState.loaded(_occasions));
      }
    } catch (_) {
      // Silent: background failures must not disrupt the visible UI
    }
  }

  Future<void> toggleActive(int id, bool currentlyActive) async {
    try {
      if (currentlyActive) {
        await _service.deactivateOccasion(id);
      } else {
        await _service.activateOccasion(id);
      }
      _occasions = _occasions
          .map((o) => o.id == id ? o.copyWith(isActive: !currentlyActive) : o)
          .toList();
      emit(OccasionsState.loaded(_occasions));
    } on ApiException catch (e) {
      emit(OccasionsState.error(e.message));
    }
  }

  Future<void> reorder(List<OccasionListItem> reordered) async {
    _occasions = reordered;
    emit(OccasionsState.loaded(_occasions));
    try {
      await _service.reorderOccasions(reordered.map((o) => o.id).toList());
    } on ApiException catch (e) {
      emit(OccasionsState.error(e.message));
    }
  }

  Future<void> delete(int id) async {
    try {
      await _service.deleteOccasion(id);
      _occasions = _occasions.where((o) => o.id != id).toList();
      emit(OccasionsState.loaded(_occasions));
    } on ApiException catch (e) {
      emit(OccasionsState.error(e.message));
    }
  }

  Future<void> uploadImage(int id, File file) async {
    try {
      await _service.uploadImage(id, file);
      await load();
    } on ApiException catch (e) {
      emit(OccasionsState.error(e.message));
    }
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}
