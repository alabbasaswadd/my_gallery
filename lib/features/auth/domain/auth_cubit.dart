import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/network/session_notifier.dart';
import 'package:my_gallery/core/storage/secure_storage.dart';
import 'package:my_gallery/features/auth/data/auth_service.dart';
import 'package:my_gallery/features/auth/data/models/auth_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_cubit.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.checking() = AuthChecking;
  const factory AuthState.authenticated(AuthUser user) = AuthAuthenticated;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.error(String message) = AuthError;
}

class AuthCubit extends Cubit<AuthState> {
  static const _cachedUserKey = '_auth_user_cache';

  final AuthService _authService;

  /// Called synchronously whenever the session is cleared — either by an
  /// explicit [logout] or by [forceUnauthenticated] (network 401). Use this
  /// to reset singleton cubits (cart, settings cache) so no previous user's
  /// data leaks to the next login.
  final void Function()? onSessionCleared;

  /// Called after every successful authentication — explicit [login],
  /// startup session restore via [checkSession], or [signInWithResult].
  /// Use this to (re)load user-specific singletons such as [SettingsCubit]
  /// with the newly authenticated user's shop ID, so User B never sees
  /// User A's stale shop identity after account switch.
  final void Function(AuthUser user)? onAuthenticated;

  AuthCubit(
    this._authService, {
    this.onSessionCleared,
    this.onAuthenticated,
  }) : super(const AuthState.initial());

  AuthUser? _currentUser;
  AuthUser? get currentUser => _currentUser;

  /// The most recent login failure, kept so the login screen can tailor the UX
  /// (offline view vs. timeout / server / invalid-credentials message) by
  /// [ApiException.kind] without changing the freezed state shape.
  ApiException? lastLoginError;

  /// Verifies the local session on startup.
  ///
  /// If the server check fails for any reason (network error, timeout, 401, or
  /// any other error), the cached user is restored so the user stays logged in.
  /// The session token is NEVER cleared automatically — only an explicit call to
  /// [logout] does that.
  Future<void> checkSession() async {
    emit(const AuthState.checking());
    final hasSession = await SecureStorage.hasValidSession();
    if (!hasSession) {
      // No token at all — user has never logged in or explicitly logged out.
      emit(const AuthState.unauthenticated());
      return;
    }
    try {
      final me = await _authService.getMe();
      _currentUser = AuthUser(
        id: me.shopId,
        fullName: me.fullName,
        email: me.email,
        role: me.role,
        shopId: me.shopId,
        shopName: me.shopName,
      );
      await _cacheUser(_currentUser!);
      emit(AuthState.authenticated(_currentUser!));
      onAuthenticated?.call(_currentUser!);
    } catch (_) {
      // Any error (network, timeout, 401, server error) — restore from cache.
      // The session token is never cleared here.
      final cached = await _getCachedUser();
      if (cached != null) {
        _currentUser = cached;
        emit(AuthState.authenticated(cached));
        onAuthenticated?.call(cached);
      } else {
        // No cache yet (before the first successful login completes its cache write).
        // Show an error — the token is still intact, nothing is cleared.
        emit(const AuthState.error('تعذّر التحقق من الجلسة، يرجى المحاولة لاحقاً'));
      }
    }
  }

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    lastLoginError = null;
    try {
      final result = await _authService.login(email: email, password: password);
      await SecureStorage.saveTokens(
        accessToken: result.accessToken,
        expiresAt: result.expiresAt,
        refreshToken: result.refreshToken,
        refreshExpiresAt: result.refreshExpiresAt,
      );
      _currentUser = result.user;
      await _cacheUser(result.user);
      emit(AuthState.authenticated(result.user));
      onAuthenticated?.call(result.user);
    } on ApiException catch (e) {
      lastLoginError = e;
      emit(AuthState.error(e.message));
    } catch (_) {
      lastLoginError = const ApiException(message: 'حدث خطأ غير متوقع');
      emit(const AuthState.error('حدث خطأ غير متوقع'));
    }
  }

  /// Adopts an already-issued session (e.g. right after self-service store
  /// creation, which returns the same [AuthResult] shape as login). Persists the
  /// token, caches the user, and emits authenticated — no extra login round-trip.
  Future<void> signInWithResult(AuthResult result) async {
    await SecureStorage.saveTokens(
      accessToken: result.accessToken,
      expiresAt: result.expiresAt,
      refreshToken: result.refreshToken,
      refreshExpiresAt: result.refreshExpiresAt,
    );
    _currentUser = result.user;
    await _cacheUser(result.user);
    emit(AuthState.authenticated(result.user));
    onAuthenticated?.call(result.user);
  }

  /// Resets in-memory auth state to unauthenticated WITHOUT calling the logout
  /// endpoint. Invoked by [SessionManager] after the network layer invalidates
  /// the session (credentials are cleared there); the router then redirects to
  /// login. Distinct from [logout], which is the explicit user action.
  void forceUnauthenticated() {
    _currentUser = null;
    // Clear the user cache so it cannot be replayed if getMe() later fails
    // during a subsequent checkSession call for a different account.
    unawaited(_clearCachedUser());
    onSessionCleared?.call();
    if (!isClosed) emit(const AuthState.unauthenticated());
  }

  /// The ONLY path that clears the session — called by an explicit user action.
  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    await _clearCachedUser();
    onSessionCleared?.call();
    emit(const AuthState.unauthenticated());
    // Explicit logout — not a session expiry, so clear any pending banner.
    SessionNotifier.instance.sessionExpiredPending = false;
    // Notify GoRouter so its redirect re-evaluates and navigates to login,
    // clearing the back-stack.
    SessionNotifier.instance.invalidate();
  }

  Future<void> _cacheUser(AuthUser user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cachedUserKey, jsonEncode(user.toJson()));
    } catch (_) {}
  }

  Future<AuthUser?> _getCachedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_cachedUserKey);
      if (json == null) return null;
      return AuthUser.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> _clearCachedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cachedUserKey);
    } catch (_) {}
  }
}
