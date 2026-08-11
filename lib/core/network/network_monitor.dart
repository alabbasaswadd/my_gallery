import 'dart:async';

import 'package:flutter/foundation.dart';

/// Coarse connectivity health, derived from real request behavior.
enum NetworkStatus { online, unstable, offline }

/// One-shot notifications the UI can react to (banners / snackbars).
enum NetworkEvent { unstable, restored }

/// Request-driven network health.
///
/// The network layer reports the outcome of every request; this class derives a
/// coarse [NetworkStatus] and emits throttled [NetworkEvent]s for the UI. There
/// is deliberately **no polling and no platform channel** — connectivity is
/// inferred from actual traffic, which is battery-friendly and easy to unit
/// test. This satisfies the rule "don't trust connectivity state alone": we only
/// ever conclude offline/unstable from failed round-trips, and online from a
/// successful one.
class NetworkMonitor {
  NetworkMonitor._();
  static final NetworkMonitor instance = NetworkMonitor._();

  /// Consecutive transport failures before the device is considered fully
  /// offline (below this it is merely "unstable").
  int offlineThreshold = 2;

  /// Minimum gap between two "unstable" notifications, so a burst of concurrent
  /// failures collapses into a single banner.
  Duration unstableCooldown = const Duration(seconds: 10);

  /// Current derived status. UI can listen for reactive rebuilds.
  final ValueNotifier<NetworkStatus> status =
      ValueNotifier<NetworkStatus>(NetworkStatus.online);

  final StreamController<NetworkEvent> _events =
      StreamController<NetworkEvent>.broadcast();

  /// Throttled event stream: at most one "unstable" per [unstableCooldown],
  /// and one "restored" per recovery.
  Stream<NetworkEvent> get events => _events.stream;

  int _consecutiveFailures = 0;
  DateTime? _lastUnstableAt;

  /// Injectable clock for deterministic tests.
  DateTime Function() clock = DateTime.now;

  /// A network round-trip completed (any HTTP status) ⇒ connectivity is healthy.
  void reportSuccess() {
    _consecutiveFailures = 0;
    if (status.value != NetworkStatus.online) {
      status.value = NetworkStatus.online;
      _add(NetworkEvent.restored);
    }
  }

  /// A genuine transport failure with no response (timeout / connection error).
  void reportNetworkFailure() {
    _consecutiveFailures++;
    status.value = _consecutiveFailures >= offlineThreshold
        ? NetworkStatus.offline
        : NetworkStatus.unstable;

    final now = clock();
    final last = _lastUnstableAt;
    if (last == null || now.difference(last) >= unstableCooldown) {
      _lastUnstableAt = now;
      _add(NetworkEvent.unstable);
    }
  }

  void _add(NetworkEvent event) {
    if (!_events.isClosed) _events.add(event);
  }

  /// Test seam — restore pristine state between cases.
  @visibleForTesting
  void reset() {
    _consecutiveFailures = 0;
    _lastUnstableAt = null;
    status.value = NetworkStatus.online;
  }
}
