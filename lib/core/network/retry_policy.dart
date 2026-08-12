import 'dart:io' show SocketException;
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_gallery/core/network/network_monitor.dart';
import 'package:my_gallery/core/network/retry_config.dart';
import 'package:my_gallery/core/session/session_manager.dart';

/// `Options.extra` key marking a request as safe to auto-retry.
/// Opt-in on purpose — see [ApiClient.retryable].
const String kRetryableExtra = 'retryable';

/// Internal `Options.extra` key tracking how many retries have run.
const String kRetryAttemptExtra = 'retry_attempt';

/// Tears down the session after retries are exhausted. Injectable for tests;
/// defaults to [SessionManager].
typedef SessionInvalidator = Future<void> Function({String reason});

/// Centralized network retry + connectivity-reporting Dio interceptor.
///
/// Responsibilities:
///  * Reports every request outcome to [NetworkMonitor] (request-driven health).
///  * Retries ONLY genuine transport failures (timeouts / connection errors),
///    and ONLY for requests explicitly marked retryable via [kRetryableExtra]
///    using a safe (idempotent) HTTP method, with exponential backoff + jitter,
///    up to [RetryConfig.maxRetries] retries.
///  * When a retryable request exhausts its retries, asks [SessionManager] to
///    invalidate the session — it never navigates itself.
///
/// It NEVER retries HTTP status errors (400/401/403/404/409/422/429/5xx) and
/// NEVER logs the user out for them; those pass through untouched.
///
/// Placed FIRST in the interceptor chain so its `onError` runs before the auth
/// interceptor maps/rejects the error, allowing a clean re-dispatch.
class NetworkRetryInterceptor extends Interceptor {
  NetworkRetryInterceptor(
    this._dio, {
    this.config = RetryConfig.defaults,
    NetworkMonitor? monitor,
    SessionInvalidator? onInvalidate,
    math.Random? random,
  }) : _monitor = monitor ?? NetworkMonitor.instance,
       _onInvalidate = onInvalidate ?? SessionManager.instance.invalidate,
       _random = random ?? math.Random();

  final Dio _dio;
  final RetryConfig config;
  final NetworkMonitor _monitor;
  final SessionInvalidator _onInvalidate;
  final math.Random _random;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Reaching a response means the round-trip worked, whatever the status.
    _monitor.reportSuccess();
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_isTransportFailure(err)) {
      // HTTP status error or non-network problem: connectivity is fine — the
      // server answered. Pass through so the auth interceptor maps it.
      handler.next(err);
      return;
    }

    _monitor.reportNetworkFailure();

    final options = err.requestOptions;
    final attempt = (options.extra[kRetryAttemptExtra] as int?) ?? 0;

    if (_isRetryable(options) && attempt < config.maxRetries) {
      final nextAttempt = attempt + 1;
      final delay = config.delayFor(nextAttempt, random: _random);
      if (kDebugMode) {
        debugPrint(
          '[Retry] ${options.method} ${options.path} — '
          'attempt $nextAttempt/${config.maxRetries} in ${delay.inMilliseconds}ms',
        );
      }
      await Future<void>.delayed(delay);
      options.extra[kRetryAttemptExtra] = nextAttempt;
      try {
        final response = await _dio.fetch<dynamic>(options);
        handler.resolve(response);
      } on DioException catch (e) {
        // The re-dispatched attempt failed. If it was another transport error
        // it already re-entered this interceptor (incrementing the attempt and,
        // when exhausted, invalidating the session). Just propagate.
        handler.next(e);
      }
      return;
    }

    if (_isRetryable(options)) {
      // A genuinely retryable request has exhausted all attempts against a real
      // network failure → tear the session down (routes back to login).
      if (kDebugMode) {
        debugPrint(
          '[Retry] network failure threshold reached for '
          '${options.path} — invalidating session',
        );
      }
      await _onInvalidate(
        reason: 'network failure after ${config.maxRetries} retries',
      );
    }

    handler.next(err);
  }

  /// True for genuine transport failures (no HTTP response was received).
  bool _isTransportFailure(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.unknown:
        return err.error is SocketException;
      case DioExceptionType.badResponse:
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
        return false;
    }
  }

  bool _isRetryable(RequestOptions options) =>
      options.extra[kRetryableExtra] == true && _isSafeMethod(options.method);

  /// Only idempotent reads are ever auto-retried, to avoid duplicate side
  /// effects (never retry POST/PUT/PATCH/DELETE automatically).
  bool _isSafeMethod(String method) {
    final m = method.toUpperCase();
    return m == 'GET' || m == 'HEAD';
  }
}
