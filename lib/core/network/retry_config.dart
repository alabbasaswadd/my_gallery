import 'dart:math' as math;

/// Central, tunable configuration for the network retry policy.
///
/// Kept intentionally small and value-based so it can be constructed in tests
/// with tight timings. All durations are configurable — nothing is hardcoded in
/// the interceptor itself.
class RetryConfig {
  /// Number of RETRIES after the initial attempt.
  /// `2` ⇒ up to 3 total attempts (1 original + 2 retries).
  final int maxRetries;

  /// Delay before the first retry (grows by [backoffFactor] each retry).
  final Duration baseDelay;

  /// Multiplier applied to the delay for each successive retry.
  final double backoffFactor;

  /// Upper bound for a single backoff delay (before jitter).
  final Duration maxDelay;

  /// Maximum random jitter added to each delay to avoid thundering herds.
  final Duration maxJitter;

  const RetryConfig({
    this.maxRetries = 2,
    this.baseDelay = const Duration(milliseconds: 350),
    this.backoffFactor = 2.6,
    this.maxDelay = const Duration(seconds: 2),
    this.maxJitter = const Duration(milliseconds: 200),
  });

  /// Delay before the given 1-based [attempt].
  ///
  /// Exponential backoff + jitter. With defaults:
  ///   attempt 1 → ~350–550ms, attempt 2 → ~910–1110ms.
  Duration delayFor(int attempt, {math.Random? random}) {
    final rnd = random ?? math.Random();
    final exp = baseDelay.inMilliseconds * math.pow(backoffFactor, attempt - 1);
    final capped = math.min(exp.toDouble(), maxDelay.inMilliseconds.toDouble());
    final jitter = maxJitter.inMilliseconds <= 0
        ? 0
        : rnd.nextInt(maxJitter.inMilliseconds + 1);
    return Duration(milliseconds: capped.round() + jitter);
  }

  static const RetryConfig defaults = RetryConfig();
}
