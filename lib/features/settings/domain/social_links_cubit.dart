import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';
import 'package:my_gallery/features/settings/data/settings_service.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';

part 'social_links_cubit.freezed.dart';

@freezed
sealed class SocialLinksState with _$SocialLinksState {
  const factory SocialLinksState.initial() = SocialLinksInitial;
  const factory SocialLinksState.loading() = SocialLinksLoading;
  const factory SocialLinksState.loaded(SocialLinks links) = SocialLinksLoaded;
  const factory SocialLinksState.saving(SocialLinks links) = SocialLinksSaving;
  const factory SocialLinksState.saved(SocialLinks links) = SocialLinksSaved;
  const factory SocialLinksState.error(String message, {SocialLinks? links}) =
      SocialLinksError;
}

class SocialLinksCubit extends Cubit<SocialLinksState> {
  final SettingsService _service;
  final SettingsCubit? _settingsCubit;

  SocialLinksCubit(this._service, {this._settingsCubit})
      : super(const SocialLinksState.initial());

  Future<void> load() async {
    emit(const SocialLinksState.loading());
    try {
      final links = await _service.getSocial();
      emit(SocialLinksState.loaded(links));
    } on ApiException catch (e) {
      emit(SocialLinksState.error(e.message));
    } catch (_) {
      emit(const SocialLinksState.error('فشل تحميل روابط التواصل'));
    }
  }

  Future<void> save(SocialLinks links) async {
    emit(SocialLinksState.saving(links));
    try {
      await _service.updateSocial(links);
      _settingsCubit?.updateSocial(links);
      emit(SocialLinksState.saved(links));
    } on ApiException catch (e) {
      emit(SocialLinksState.error(e.message, links: links));
    } catch (_) {
      emit(SocialLinksState.error('فشل حفظ روابط التواصل', links: links));
    }
  }
}
