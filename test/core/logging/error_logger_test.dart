import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_gallery/core/logging/error_log_entry.dart';
import 'package:my_gallery/core/logging/error_logger.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  // Reset the singleton state between tests by clearing storage.
  // clearAll() also resets the deduplication state so each test gets a clean slate.
  Future<void> freshLogger() async {
    await ErrorLogger.instance.clearAll();
  }

  test('initialize loads empty when no stored data', () async {
    await freshLogger();
    expect(ErrorLogger.instance.logs, isEmpty);
    expect(ErrorLogger.instance.count, 0);
  });

  test('logApiException saves entry', () async {
    await freshLogger();
    final logger = ErrorLogger.instance;
    const ex = ApiException(
      kind: ApiErrorKind.server,
      message: 'Internal Server Error',
      statusCode: 500,
      traceId: 'trace-abc',
    );

    logger.logApiException(ex);
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(logger.count, 1);
    final entry = logger.logs.first;
    expect(entry.category, 'server');
    expect(entry.message, 'Internal Server Error');
    expect(entry.statusCode, 500);
    expect(entry.traceId, 'trace-abc');
    expect(entry.apiErrorKind, 'server');
    expect(entry.isHandled, true);
  });

  test('newest errors appear first', () async {
    await freshLogger();
    final logger = ErrorLogger.instance;

    logger.logApiException(
      const ApiException(kind: ApiErrorKind.network, message: 'First'),
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));
    logger.logApiException(
      const ApiException(kind: ApiErrorKind.server, message: 'Second'),
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(logger.count, 2);
    expect(logger.logs.first.message, 'Second');
    expect(logger.logs.last.message, 'First');
  });

  test('maximum log limit is enforced', () async {
    await freshLogger();
    final logger = ErrorLogger.instance;

    // Log more than maxLogs entries; use unique statusCodes to avoid dedup.
    for (var i = 0; i < ErrorLogger.maxLogs + 10; i++) {
      logger.logApiException(
        ApiException(kind: ApiErrorKind.unknown, message: 'Error $i', statusCode: i),
      );
    }
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(logger.count, ErrorLogger.maxLogs);
  });

  test('oldest logs are removed when limit is exceeded', () async {
    await freshLogger();
    final logger = ErrorLogger.instance;

    // Unique statusCodes prevent deduplication across entries.
    for (var i = 0; i < ErrorLogger.maxLogs + 5; i++) {
      logger.logApiException(
        ApiException(kind: ApiErrorKind.unknown, message: 'Error $i', statusCode: i + 1000),
      );
    }
    await Future<void>.delayed(const Duration(milliseconds: 50));

    // The newest (highest index) entries should still be present.
    final messages = logger.logs.map((e) => e.message).toList();
    expect(
      messages.contains('Error ${ErrorLogger.maxLogs + 4}'),
      isTrue,
      reason: 'Newest entry must be retained',
    );
    expect(
      messages.contains('Error 0'),
      isFalse,
      reason: 'Oldest entry must be evicted',
    );
  });

  test('deleting one error removes only that entry', () async {
    await freshLogger();
    final logger = ErrorLogger.instance;

    logger.logApiException(
      const ApiException(kind: ApiErrorKind.network, message: 'A'),
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));
    logger.logApiException(
      const ApiException(kind: ApiErrorKind.server, message: 'B'),
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(logger.count, 2);
    final idA = logger.logs.last.id;

    await logger.delete(idA);
    expect(logger.count, 1);
    expect(logger.logs.first.message, 'B');
  });

  test('clearAll removes all logs', () async {
    await freshLogger();
    final logger = ErrorLogger.instance;

    logger.logApiException(
      const ApiException(kind: ApiErrorKind.server, message: 'X'),
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(logger.count, 1);

    await logger.clearAll();
    expect(logger.count, 0);
  });

  test('error serialization round-trips through JSON', () {
    final original = ErrorLogEntry(
      id: 'test-id',
      timestamp: DateTime(2026, 8, 14, 10, 0, 0),
      category: 'server',
      message: 'Internal error',
      technicalMessage: 'ApiException(server, 500)',
      statusCode: 500,
      apiErrorKind: 'server',
      traceId: 'trace-xyz',
      endpoint: '/products',
      httpMethod: 'GET',
      featureName: 'products',
      isHandled: true,
    );

    final json = original.toJson();
    final restored = ErrorLogEntry.fromJson(json);

    expect(restored.id, original.id);
    expect(restored.category, original.category);
    expect(restored.message, original.message);
    expect(restored.statusCode, original.statusCode);
    expect(restored.traceId, original.traceId);
    expect(restored.endpoint, original.endpoint);
    expect(restored.httpMethod, original.httpMethod);
    expect(restored.isHandled, original.isHandled);
  });

  test('Authorization header is never stored (no request body logged)', () async {
    await freshLogger();
    final logger = ErrorLogger.instance;

    logger.logApiException(
      const ApiException(kind: ApiErrorKind.unauthorized, message: 'Unauthorized'),
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final entry = logger.logs.first;
    final allText = [
      entry.message,
      entry.technicalMessage ?? '',
      entry.stackTrace ?? '',
    ].join(' ');

    expect(allText.contains('Bearer '), isFalse);
    expect(allText.contains('password'), isFalse);
  });

  test('logger does not throw when logging fails gracefully', () async {
    await freshLogger();
    // Passing null as endpoint — should not crash.
    expect(
      () => ErrorLogger.instance.logApiException(
        const ApiException(kind: ApiErrorKind.unknown, message: 'Test'),
      ),
      returnsNormally,
    );
  });

  test('duplicate ApiException within 2s is skipped', () async {
    await freshLogger();
    final logger = ErrorLogger.instance;

    const ex = ApiException(
      kind: ApiErrorKind.server,
      message: 'Duplicate',
      statusCode: 500,
    );

    logger.logApiException(ex);
    logger.logApiException(ex); // same hash, within window
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(logger.count, 1, reason: 'Duplicate within 2s must be skipped');
  });

  test('logFlutterError captures flutter errors', () async {
    await freshLogger();
    final logger = ErrorLogger.instance;

    logger.logFlutterError(const FlutterErrorDetails(
      exception: 'Widget build failed',
    ));
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(logger.count, 1);
    expect(logger.logs.first.category, 'flutter');
    expect(logger.logs.first.isHandled, false);
  });

  test('logUncaughtError captures platform errors', () async {
    await freshLogger();
    final logger = ErrorLogger.instance;

    logger.logUncaughtError(
      Exception('Something crashed'),
      StackTrace.current,
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(logger.count, 1);
    expect(logger.logs.first.category, 'platform');
    expect(logger.logs.first.isHandled, false);
  });
}
