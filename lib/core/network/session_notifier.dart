import 'package:flutter/foundation.dart';

class SessionNotifier extends ChangeNotifier {
  static final instance = SessionNotifier._();
  SessionNotifier._();

  /// True when a genuine 401 response expired the session.
  /// Read once by LoginScreen to show the "session expired" banner, then reset.
  bool sessionExpiredPending = false;

  void invalidate() => notifyListeners();
}
