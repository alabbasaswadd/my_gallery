import 'dart:io';

import 'package:flutter/painting.dart' show Color;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';
import 'package:my_gallery/features/settings/data/settings_service.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/theme.dart' show kDefaultPalette;

part 'site_customization_cubit.freezed.dart';

/// Which of the 6 role colors a swatch edits.
enum ColorRole { primary, secondary, accent, background, surface, text }

@freezed
sealed class SiteCustomizationState with _$SiteCustomizationState {
  const factory SiteCustomizationState.loading() = SiteCustomizationLoading;

  /// Unrecoverable load failure — the editor shows a full-screen retry.
  const factory SiteCustomizationState.loadError(String message) =
      SiteCustomizationLoadError;

  /// The editable draft. [uploadingField] is set while an image upload is in
  /// flight (`'logo'`, `'favicon'`, or `'hero:<index>'`).
  const factory SiteCustomizationState.ready(
    StorefrontSettings draft, {
    @Default(false) bool saving,
    String? uploadingField,
  }) = SiteCustomizationReady;

  /// One-shot: save succeeded — the screen pops with a success message.
  const factory SiteCustomizationState.saved(StorefrontSettings draft) =
      SiteCustomizationSaved;

  /// One-shot: an upload/save failed — the screen shows the message and keeps
  /// the draft so the user can retry.
  const factory SiteCustomizationState.opError(
    String message,
    StorefrontSettings draft,
  ) = SiteCustomizationOpError;
}

extension SiteCustomizationStateX on SiteCustomizationState {
  /// The current draft, if any state carries one.
  StorefrontSettings? get draftOrNull => switch (this) {
        SiteCustomizationReady(:final draft) => draft,
        SiteCustomizationSaved(:final draft) => draft,
        SiteCustomizationOpError(:final draft) => draft,
        _ => null,
      };
}

class SiteCustomizationCubit extends Cubit<SiteCustomizationState> {
  final SettingsService _service;
  final SettingsCubit _settingsCubit;

  SiteCustomizationCubit(this._service, {required SettingsCubit settingsCubit})
      : _settingsCubit = settingsCubit,
        super(const SiteCustomizationState.loading());

  StorefrontSettings get _draft =>
      state.draftOrNull ?? _settingsCubit.currentOrDefault;

  Future<void> load() async {
    emit(const SiteCustomizationState.loading());
    try {
      final settings = await _service.getEditableSettings();
      emit(SiteCustomizationState.ready(settings));
    } on ApiException catch (e) {
      // If we have a cached identity, still let the editor open.
      final cached = _settingsCubit.currentOrDefault;
      if (_settingsCubit.state is SettingsLoaded) {
        emit(SiteCustomizationState.ready(cached));
      } else {
        emit(SiteCustomizationState.loadError(e.message));
      }
    } catch (_) {
      if (_settingsCubit.state is SettingsLoaded) {
        emit(SiteCustomizationState.ready(_settingsCubit.currentOrDefault));
      } else {
        emit(const SiteCustomizationState.loadError('فشل تحميل إعدادات المظهر'));
      }
    }
  }

  // ── Field mutators (re-emit ready with the new draft) ─────────────────────

  void _apply(StorefrontSettings next) =>
      emit(SiteCustomizationState.ready(next));

  void setBrandName(String v) => _apply(_draft.copyWith(brandName: v));

  void setWebsite(String v) => _apply(_draft.copyWith(website: v));

  void setFontFamily(String v) => _apply(_draft.copyWith(fontFamily: v));

  void setRadius(double v) => _apply(_draft.copyWith(borderRadius: v));

  void setSocial(SocialLinks social) => _apply(_draft.copyWith(social: social));

  void setLogoUrl(String url) => _apply(_draft.copyWith(logo: url));

  void setFaviconUrl(String url) => _apply(_draft.copyWith(favicon: url));

  void setColor(ColorRole role, String hex) {
    final d = _draft;
    _apply(switch (role) {
      ColorRole.primary => d.copyWith(primaryColor: hex),
      ColorRole.secondary => d.copyWith(secondaryColor: hex),
      ColorRole.accent => d.copyWith(accentColor: hex),
      ColorRole.background => d.copyWith(backgroundColor: hex),
      ColorRole.surface => d.copyWith(surfaceColor: hex),
      ColorRole.text => d.copyWith(textColor: hex),
    });
  }

  /// Task 6e — reset the draft's 6 colors + radius to the attractive default.
  void resetColorsToDefault() {
    _apply(_draft.copyWith(
      primaryColor: _hex(kDefaultPalette.primary),
      secondaryColor: _hex(kDefaultPalette.secondary),
      accentColor: _hex(kDefaultPalette.accent),
      backgroundColor: _hex(kDefaultPalette.background),
      surfaceColor: _hex(kDefaultPalette.surface),
      textColor: _hex(kDefaultPalette.text),
      borderRadius: kDefaultPalette.radius,
    ));
  }

  // ── Hero slide ops ────────────────────────────────────────────────────────

  void addHero() =>
      _apply(_draft.copyWith(heroSlides: [..._draft.heroSlides, const HeroSlide(imageUrl: '')]));

  void updateHero(int index, HeroSlide slide) {
    final list = [..._draft.heroSlides];
    if (index < 0 || index >= list.length) return;
    list[index] = slide;
    _apply(_draft.copyWith(heroSlides: list));
  }

  void removeHero(int index) {
    final list = [..._draft.heroSlides];
    if (index < 0 || index >= list.length) return;
    list.removeAt(index);
    _apply(_draft.copyWith(heroSlides: list));
  }

  void reorderHero(int oldIndex, int newIndex) {
    final list = [..._draft.heroSlides];
    if (newIndex > oldIndex) newIndex -= 1;
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    _apply(_draft.copyWith(heroSlides: list));
  }

  // ── Image uploads ─────────────────────────────────────────────────────────

  Future<void> pickAndUploadLogo(File file) =>
      _upload(file, 'logo', (url) => _draft.copyWith(logo: url));

  Future<void> pickAndUploadFavicon(File file) =>
      _upload(file, 'favicon', (url) => _draft.copyWith(favicon: url));

  Future<void> pickAndUploadHeroImage(File file, int index) => _upload(
        file,
        'hero:$index',
        (url) {
          final list = [..._draft.heroSlides];
          if (index < 0 || index >= list.length) return _draft;
          list[index] = list[index].copyWith(imageUrl: url);
          return _draft.copyWith(heroSlides: list);
        },
      );

  Future<void> _upload(
    File file,
    String field,
    StorefrontSettings Function(String url) put,
  ) async {
    final draft = _draft;
    emit(SiteCustomizationState.ready(draft, uploadingField: field));
    try {
      final url = await _service.uploadImage(file);
      emit(SiteCustomizationState.ready(put(url)));
    } on ApiException catch (e) {
      emit(SiteCustomizationState.opError(e.message, draft));
      emit(SiteCustomizationState.ready(draft));
    } catch (_) {
      emit(SiteCustomizationState.opError('فشل رفع الصورة', draft));
      emit(SiteCustomizationState.ready(draft));
    }
  }

  // ── Save ──────────────────────────────────────────────────────────────────

  Future<void> save() async {
    final draft = _draft;
    emit(SiteCustomizationState.ready(draft, saving: true));
    try {
      await _service.updateSettings(draft);
      _settingsCubit.applyUpdated(draft);
      emit(SiteCustomizationState.saved(draft));
    } on ApiException catch (e) {
      emit(SiteCustomizationState.opError(e.message, draft));
      emit(SiteCustomizationState.ready(draft));
    } catch (_) {
      emit(SiteCustomizationState.opError('فشل حفظ إعدادات المظهر', draft));
      emit(SiteCustomizationState.ready(draft));
    }
  }

  static String _hex(Color c) {
    final argb = c.toARGB32();
    return '#${(argb & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}
