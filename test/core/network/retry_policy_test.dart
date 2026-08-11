import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/core/network/network_monitor.dart';
import 'package:my_gallery/core/network/retry_config.dart';
import 'package:my_gallery/core/network/retry_policy.dart';

/// One canned outcome for a request attempt: either an HTTP response or a
/// transport-level failure ([error]).
class _Outcome {
  const _Outcome.ok([this.status = 200]) : error = null;
  const _Outcome.fail(this.error) : status = null;
  final int? status;
  final DioExceptionType? error;
}

/// Fake adapter that replays [outcomes] in order (repeating the last one) and
/// counts how many times the network was actually hit.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.outcomes);
  final List<_Outcome> outcomes;
  int calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<dynamic>? cancelFuture,
  ) async {
    final outcome =
        outcomes[calls < outcomes.length ? calls : outcomes.length - 1];
    calls++;
    if (outcome.error != null) {
      throw DioException(requestOptions: options, type: outcome.error!);
    }
    return ResponseBody.fromString(
      '{"ok":true}',
      outcome.status!,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  const fastConfig = RetryConfig(
    maxRetries: 2,
    baseDelay: Duration(milliseconds: 1),
    backoffFactor: 1,
    maxDelay: Duration(milliseconds: 2),
    maxJitter: Duration.zero,
  );

  late bool invalidated;

  Dio buildDio(_FakeAdapter adapter) {
    invalidated = false;
    final dio = Dio(BaseOptions(validateStatus: (_) => true));
    dio.httpClientAdapter = adapter;
    dio.interceptors.add(
      NetworkRetryInterceptor(
        dio,
        config: fastConfig,
        monitor: NetworkMonitor.instance,
        onInvalidate: ({String reason = ''}) async {
          invalidated = true;
        },
      ),
    );
    return dio;
  }

  setUp(() {
    NetworkMonitor.instance.reset();
    NetworkMonitor.instance.offlineThreshold = 2;
  });

  test('successful request is not retried and marks connectivity healthy',
      () async {
    final adapter = _FakeAdapter([const _Outcome.ok()]);
    final dio = buildDio(adapter);

    final resp = await dio.get<dynamic>('/x');

    expect(resp.statusCode, 200);
    expect(adapter.calls, 1);
    expect(invalidated, isFalse);
    expect(NetworkMonitor.instance.status.value, NetworkStatus.online);
  });

  test('HTTP 500 is returned (not retried) and never logs out', () async {
    final adapter = _FakeAdapter([const _Outcome.ok(500)]);
    final dio = buildDio(adapter);

    final resp = await dio.get<dynamic>('/x');

    expect(resp.statusCode, 500);
    expect(adapter.calls, 1);
    expect(invalidated, isFalse);
    expect(NetworkMonitor.instance.status.value, NetworkStatus.online);
  });

  test('non-retryable network failure is not retried and does not log out',
      () async {
    final adapter =
        _FakeAdapter([const _Outcome.fail(DioExceptionType.connectionError)]);
    final dio = buildDio(adapter);

    await expectLater(
      dio.get<dynamic>('/x'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.calls, 1);
    expect(invalidated, isFalse);
    expect(NetworkMonitor.instance.status.value, NetworkStatus.unstable);
  });

  test('retryable GET retries then succeeds on the 2nd retry (3 attempts)',
      () async {
    final adapter = _FakeAdapter([
      const _Outcome.fail(DioExceptionType.receiveTimeout),
      const _Outcome.fail(DioExceptionType.receiveTimeout),
      const _Outcome.ok(),
    ]);
    final dio = buildDio(adapter);

    final resp = await dio.get<dynamic>('/x', options: ApiClient.retryable());

    expect(resp.statusCode, 200);
    expect(adapter.calls, 3); // 1 original + 2 retries
    expect(invalidated, isFalse);
    expect(NetworkMonitor.instance.status.value, NetworkStatus.online);
  });

  test('retryable GET exhausts all attempts → session invalidated once',
      () async {
    final adapter =
        _FakeAdapter([const _Outcome.fail(DioExceptionType.connectionError)]);
    final dio = buildDio(adapter);

    await expectLater(
      dio.get<dynamic>('/x', options: ApiClient.retryable()),
      throwsA(isA<DioException>()),
    );

    expect(adapter.calls, 3); // 1 original + 2 retries
    expect(invalidated, isTrue);
    expect(NetworkMonitor.instance.status.value, NetworkStatus.offline);
  });

  test('unsafe POST is never auto-retried even if marked retryable', () async {
    final adapter =
        _FakeAdapter([const _Outcome.fail(DioExceptionType.connectionError)]);
    final dio = buildDio(adapter);

    await expectLater(
      dio.post<dynamic>('/x', options: ApiClient.retryable()),
      throwsA(isA<DioException>()),
    );

    expect(adapter.calls, 1);
    expect(invalidated, isFalse);
  });
}
