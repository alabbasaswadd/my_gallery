import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';
import 'package:my_gallery/features/settings/data/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_cubit.freezed.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = SettingsInitial;
  const factory SettingsState.loading() = SettingsLoading;
  const factory SettingsState.loaded(StorefrontSettings settings) = SettingsLoaded;
  const factory SettingsState.error(String message) = SettingsError;
}

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsService _service;
  static const _cacheKey = 'storefront_settings_cache';

  SettingsCubit(this._service) : super(const SettingsState.initial());

  StorefrontSettings get currentOrDefault =>
      state is SettingsLoaded ? (state as SettingsLoaded).settings : kDefaultSettings;

  /// Loads settings for [shopId]: serves cached data instantly, then refreshes from server.
  Future<void> load(int shopId) async {
    final cached = await _loadCache();
    if (cached != null) {
      emit(SettingsState.loaded(cached));
    } else {
      emit(const SettingsState.loading());
    }

    try {
      final fresh = await _service.getSettings(shopId);
      await _saveCache(fresh);
      emit(SettingsState.loaded(fresh));
    } on ApiException catch (e) {
      if (state is! SettingsLoaded) {
        emit(SettingsState.error(e.message));
      }
    } catch (_) {
      if (state is! SettingsLoaded) {
        emit(const SettingsState.error('فشل تحميل إعدادات المعرض'));
      }
    }
  }

  Future<StorefrontSettings?> _loadCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_cacheKey);
      if (raw == null) return null;
      return StorefrontSettings.fromJson(
          jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  void updateSocial(SocialLinks social) {
    final current = currentOrDefault;
    final updated = current.copyWith(social: social);
    emit(SettingsState.loaded(updated));
    _saveCache(updated);
  }

  /// Replaces the app-wide settings after a full save from the customization
  /// editor, so the whole app restyles immediately and the cache is refreshed.
  void applyUpdated(StorefrontSettings settings) {
    emit(SettingsState.loaded(settings));
    _saveCache(settings);
  }

  Future<void> _saveCache(StorefrontSettings settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, jsonEncode(settings.toJson()));
    } catch (_) {}
  }
}
