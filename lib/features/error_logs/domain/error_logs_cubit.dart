import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/logging/error_log_entry.dart';
import 'package:my_gallery/core/logging/error_logger.dart';

part 'error_logs_cubit.freezed.dart';

@freezed
sealed class ErrorLogsState with _$ErrorLogsState {
  const factory ErrorLogsState.initial() = ErrorLogsInitial;
  const factory ErrorLogsState.loading() = ErrorLogsLoading;
  const factory ErrorLogsState.loaded({
    required List<ErrorLogEntry> logs,
    required List<ErrorLogEntry> filtered,
    @Default('') String searchQuery,
    @Default('') String filterCategory,
  }) = ErrorLogsLoaded;
  const factory ErrorLogsState.error(String message) = ErrorLogsError;
}

class ErrorLogsCubit extends Cubit<ErrorLogsState> {
  final ErrorLogger _logger;

  ErrorLogsCubit(this._logger) : super(const ErrorLogsState.initial());

  Future<void> load() async {
    emit(const ErrorLogsState.loading());
    try {
      final logs = _logger.logs;
      emit(ErrorLogsState.loaded(logs: logs, filtered: logs));
    } catch (e) {
      emit(ErrorLogsState.error(e.toString()));
    }
  }

  void search(String query) {
    final current = state;
    if (current is! ErrorLogsLoaded) return;
    final trimmed = query.trim().toLowerCase();
    final filtered = _applyFilters(
      current.logs,
      searchQuery: trimmed,
      filterCategory: current.filterCategory,
    );
    emit(current.copyWith(
      searchQuery: trimmed,
      filtered: filtered,
    ));
  }

  void filterByCategory(String category) {
    final current = state;
    if (current is! ErrorLogsLoaded) return;
    final filtered = _applyFilters(
      current.logs,
      searchQuery: current.searchQuery,
      filterCategory: category,
    );
    emit(current.copyWith(filterCategory: category, filtered: filtered));
  }

  Future<void> deleteLog(String id) async {
    final current = state;
    if (current is! ErrorLogsLoaded) return;
    await _logger.delete(id);
    final updated = _logger.logs;
    final filtered = _applyFilters(
      updated,
      searchQuery: current.searchQuery,
      filterCategory: current.filterCategory,
    );
    emit(current.copyWith(logs: updated, filtered: filtered));
  }

  Future<void> clearAll() async {
    final current = state;
    if (current is! ErrorLogsLoaded) return;
    await _logger.clearAll();
    emit(current.copyWith(logs: const [], filtered: const []));
  }

  static List<ErrorLogEntry> _applyFilters(
    List<ErrorLogEntry> logs, {
    required String searchQuery,
    required String filterCategory,
  }) {
    return logs.where((log) {
      final matchesSearch = searchQuery.isEmpty ||
          log.message.toLowerCase().contains(searchQuery) ||
          (log.endpoint?.toLowerCase().contains(searchQuery) ?? false);
      final matchesCategory = filterCategory.isEmpty ||
          log.category == filterCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }
}
