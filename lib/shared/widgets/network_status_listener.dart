import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/core/network/network_monitor.dart';
import 'package:my_gallery/l10n/app_localizations.dart';

/// Mounts once near the app root and turns throttled [NetworkMonitor] events
/// into calm, non-blocking notifications:
///   * unstable connection  → a single warning snackbar (throttled upstream),
///   * connection restored   → a single success snackbar per recovery.
///
/// Deduplication/throttling lives in [NetworkMonitor], so a burst of concurrent
/// failed requests produces exactly one banner here. This widget is purely a
/// presentation adapter — it holds no network logic.
class NetworkStatusListener extends StatefulWidget {
  const NetworkStatusListener({super.key, required this.child});

  final Widget child;

  @override
  State<NetworkStatusListener> createState() => _NetworkStatusListenerState();
}

class _NetworkStatusListenerState extends State<NetworkStatusListener> {
  StreamSubscription<NetworkEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = NetworkMonitor.instance.events.listen(_onEvent);
  }

  void _onEvent(NetworkEvent event) {
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    switch (event) {
      case NetworkEvent.unstable:
        AppSnackbar.showWarning(
          context,
          l10n?.unstableNetwork ?? 'الاتصال بالإنترنت غير مستقر',
        );
      case NetworkEvent.restored:
        AppSnackbar.showSuccess(
          context,
          l10n?.connectionRestored ?? 'تم استعادة الاتصال بالإنترنت',
        );
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
