import 'package:flutter/foundation.dart';

class SessionNotifier extends ChangeNotifier {
  static final instance = SessionNotifier._();
  SessionNotifier._();

  void invalidate() => notifyListeners();
}
