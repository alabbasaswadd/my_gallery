import 'dart:async' show unawaited;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_gallery/core/logging/error_log_entry.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Centralized developer-facing error logger.
///
/// Captures API errors (from [ApiException]) and uncaught Flutter/platform
/// errors. Stores up to [maxLogs] entries in SharedPreferences so they survive
/// restarts. Never throws — all methods are best-effort and silently swallow
/// internal failures.
///
/// Usage:
///   await ErrorLogger.instance.initialize(); // once in main()
///   ErrorLogger.instance.logApiException(e, requestOptions: options);
class ErrorLogger {
  ErrorLogger._();
  static final ErrorLogger instance = ErrorLogger._();

  static const _storageKey = 'app_error_logs';
  static const maxLogs = 100;
  static const stackTraceMaxLines = 50;

  // Deduplication: skip the same (kind+endpoint+status) within this window.
  static const _dedupeWindowMs = 2000;

  final List<ErrorLogEntry> _logs = [];
  bool _initialized = false;

  String? _lastHash;
  int _lastHashTimeMs = 0;
  int _idCounter = 0;

  // ── Public API ──────────────────────────────────────────────────────────

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      if (raw != null) {
        final list = jsonDecode(raw) as List<dynamic>;
        for (final item in list) {
          try {
            _logs.add(ErrorLogEntry.fromJson(item as Map<String, dynamic>));
          } catch (_) {
            // Drop malformed entries silently.
          }
        }
        _logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        if (_logs.length > maxLogs) _logs.removeRange(maxLogs, _logs.length);
      }
    } catch (e) {
      if (kDebugMode) debugPrint('[ErrorLogger] init failed: $e');
    }
    _initialized = true;
  }

  List<ErrorLogEntry> get logs => List.unmodifiable(_logs);
  int get count => _logs.length;

  /// Log an [ApiException] from the network interceptor.
  /// Safe to call synchronously — persistence is fire-and-forget.
  void logApiException(
    ApiException exception, {
    RequestOptions? requestOptions,
    String? featureName,
    bool isHandled = true,
  }) {
    try {
      final endpoint = _sanitizeUrl(requestOptions?.path);
      final hash =
          '${exception.kind.name}|${exception.statusCode}|$endpoint';
      if (_isDuplicate(hash)) return;

      _addLog(ErrorLogEntry(
        id: _nextId(),
        timestamp: DateTime.now(),
        category: exception.kind.name,
        message: exception.message,
        technicalMessage: exception.toString(),
        statusCode: exception.statusCode,
        apiErrorKind: exception.kind.name,
        traceId: exception.traceId,
        endpoint: endpoint,
        httpMethod: requestOptions?.method,
        featureName: featureName,
        isHandled: isHandled,
      ));
    } catch (e) {
      if (kDebugMode) debugPrint('[ErrorLogger] logApiException failed: $e');
    }
  }

  /// Log a Flutter framework error (from [FlutterError.onError]).
  void logFlutterError(FlutterErrorDetails details) {
    try {
      final msg = details.exceptionAsString();
      if (_isDuplicate('flutter|$msg')) return;

      _addLog(ErrorLogEntry(
        id: _nextId(),
        timestamp: DateTime.now(),
        category: kErrorCategoryFlutter,
        message: msg,
        technicalMessage: msg,
        stackTrace: _limitTrace(details.stack?.toString()),
        isHandled: false,
      ));
    } catch (e) {
      if (kDebugMode) debugPrint('[ErrorLogger] logFlutterError failed: $e');
    }
  }

  /// Log an uncaught Dart/platform error (from [PlatformDispatcher.onError]).
  void logUncaughtError(Object error, StackTrace? stack) {
    try {
      final msg = error.toString();
      if (_isDuplicate('platform|$msg')) return;

      _addLog(ErrorLogEntry(
        id: _nextId(),
        timestamp: DateTime.now(),
        category: kErrorCategoryPlatform,
        message: msg,
        technicalMessage: msg,
        stackTrace: _limitTrace(stack?.toString()),
        isHandled: false,
      ));
    } catch (e) {
      if (kDebugMode) debugPrint('[ErrorLogger] logUncaughtError failed: $e');
    }
  }

  Future<void> delete(String id) async {
    _logs.removeWhere((e) => e.id == id);
    await _persist();
  }

  Future<void> clearAll() async {
    _logs.clear();
    _lastHash = null;
    _lastHashTimeMs = 0;
    await _persist();
  }

  // ── Private helpers ─────────────────────────────────────────────────────

  void _addLog(ErrorLogEntry entry) {
    _logs.insert(0, entry);
    if (_logs.length > maxLogs) _logs.removeRange(maxLogs, _logs.length);
    unawaited(_persist());
  }

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(_logs.map((e) => e.toJson()).toList());
      await prefs.setString(_storageKey, encoded);
    } catch (e) {
      if (kDebugMode) debugPrint('[ErrorLogger] persist failed: $e');
    }
  }

  bool _isDuplicate(String hash) {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_lastHash == hash && (now - _lastHashTimeMs) < _dedupeWindowMs) {
      return true;
    }
    _lastHash = hash;
    _lastHashTimeMs = now;
    return false;
  }

  String _nextId() {
    _idCounter++;
    return '${DateTime.now().microsecondsSinceEpoch}_$_idCounter';
  }

  static String? _sanitizeUrl(String? url) => url;

  static String? _limitTrace(String? trace) {
    if (trace == null) return null;
    final lines = trace.split('\n');
    if (lines.length <= stackTraceMaxLines) return trace;
    return '${lines.take(stackTraceMaxLines).join('\n')}\n... (truncated)';
  }
}
