import 'package:flutter/foundation.dart';
import 'package:my_gallery/core/network/session_notifier.dart';
import 'package:my_gallery/core/storage/secure_storage.dart';

/// Single authority for tearing down an authenticated session from
/// non-UI code (e.g. the network layer after repeated genuine failures).
///
/// The network layer NEVER navigates. It calls [invalidate], which:
///   1. clears stored credentials,
///   2. resets in-memory auth state via a bound callback (the root AuthCubit),
///   3. pings [SessionNotifier] so GoRouter's `refreshListenable` re-runs its
///      redirect and bounces to the login screen.
///
/// This preserves the app's invariant that credentials are cleared only by an
/// explicit user logout OR this managed invalidation path — never as a silent
/// side effect of an arbitrary failed request.
class SessionManager {
  SessionManager._();
  static final SessionManager instance = SessionManager._();

  VoidCallback? _onInvalidate;
  bool _invalidating = false;

  /// Binds a callback invoked during [invalidate] — typically resetting the
  /// root AuthCubit to `unauthenticated`. Called once during startup wiring.
  void bindOnInvalidate(VoidCallback callback) => _onInvalidate = callback;

  /// Clears the session and routes back to login.
  ///
  /// Idempotent while a teardown is in flight, so a burst of simultaneously
  /// failing requests triggers exactly one logout (no duplicate navigation).
  Future<void> invalidate({String reason = ''}) async {
    if (_invalidating) return;
    _invalidating = true;
    try {
      if (kDebugMode) {
        // Safe: no tokens or credentials are ever logged.
        debugPrint('[Session] invalidated — $reason');
      }
      await SecureStorage.clearAll();
      _onInvalidate?.call();
      SessionNotifier.instance.invalidate();
    } finally {
      _invalidating = false;
    }
  }
}
