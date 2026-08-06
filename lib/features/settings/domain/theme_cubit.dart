import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/theme.dart' show ThemeSource;
import 'package:shared_preferences/shared_preferences.dart';

/// The persisted theming choices: light/dark [mode] and which palette
/// ([source]) drives the live app theme.
class ThemeSettings {
  final ThemeMode mode;
  final ThemeSource source;

  const ThemeSettings({
    this.mode = ThemeMode.system,
    this.source = ThemeSource.identity,
  });

  ThemeSettings copyWith({ThemeMode? mode, ThemeSource? source}) =>
      ThemeSettings(
        mode: mode ?? this.mode,
        source: source ?? this.source,
      );

  @override
  bool operator ==(Object other) =>
      other is ThemeSettings && other.mode == mode && other.source == source;

  @override
  int get hashCode => Object.hash(mode, source);
}

class ThemeCubit extends Cubit<ThemeSettings> {
  static const _modeKey = 'theme_mode';
  static const _sourceKey = 'theme_source';

  ThemeCubit() : super(const ThemeSettings());

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    final savedMode = prefs.getString(_modeKey);
    final mode = savedMode == null
        ? ThemeMode.system
        : ThemeMode.values.firstWhere(
            (m) => m.name == savedMode,
            orElse: () => ThemeMode.system,
          );

    final savedSource = prefs.getString(_sourceKey);
    final source = savedSource == null
        ? ThemeSource.identity
        : ThemeSource.values.firstWhere(
            (s) => s.name == savedSource,
            orElse: () => ThemeSource.identity,
          );

    emit(ThemeSettings(mode: mode, source: source));
  }

  Future<void> setMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modeKey, mode.name);
    emit(state.copyWith(mode: mode));
  }

  void toggle() => setMode(
      state.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);

  Future<void> setThemeSource(ThemeSource source) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sourceKey, source.name);
    emit(state.copyWith(source: source));
  }
}
