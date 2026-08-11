import 'package:flutter_test/flutter_test.dart';
import 'package:my_gallery/core/network/network_monitor.dart';

/// Flush pending broadcast-stream microtasks.
Future<void> _flush() => Future<void>.delayed(Duration.zero);

void main() {
  final monitor = NetworkMonitor.instance;

  setUp(() {
    monitor.reset();
    monitor.clock = DateTime.now;
    monitor.offlineThreshold = 2;
    monitor.unstableCooldown = const Duration(seconds: 10);
  });

  test('starts online', () {
    expect(monitor.status.value, NetworkStatus.online);
  });

  test('a single failure → unstable with one unstable event', () async {
    final events = <NetworkEvent>[];
    final sub = monitor.events.listen(events.add);

    monitor.reportNetworkFailure();
    await _flush();

    expect(monitor.status.value, NetworkStatus.unstable);
    expect(events, [NetworkEvent.unstable]);
    await sub.cancel();
  });

  test('reaching the offline threshold → offline', () {
    monitor.reportNetworkFailure();
    monitor.reportNetworkFailure();
    expect(monitor.status.value, NetworkStatus.offline);
  });

  test('concurrent failures within cooldown emit a single unstable event',
      () async {
    final events = <NetworkEvent>[];
    final sub = monitor.events.listen(events.add);

    // Freeze the clock so every failure falls inside the cooldown window.
    final fixed = DateTime(2026, 1, 1, 12);
    monitor.clock = () => fixed;

    for (var i = 0; i < 5; i++) {
      monitor.reportNetworkFailure();
    }
    await _flush();

    expect(events.where((e) => e == NetworkEvent.unstable).length, 1);
    await sub.cancel();
  });

  test('a success after failures → online + exactly one restored event',
      () async {
    final events = <NetworkEvent>[];
    final sub = monitor.events.listen(events.add);

    monitor.reportNetworkFailure();
    monitor.reportSuccess();
    await _flush();

    expect(monitor.status.value, NetworkStatus.online);
    expect(events.where((e) => e == NetworkEvent.restored).length, 1);
    await sub.cancel();
  });

  test('a success while already online emits no event', () async {
    final events = <NetworkEvent>[];
    final sub = monitor.events.listen(events.add);

    monitor.reportSuccess();
    await _flush();

    expect(events, isEmpty);
    await sub.cancel();
  });
}
