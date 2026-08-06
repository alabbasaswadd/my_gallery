import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/core/storage/secure_storage.dart';
import 'package:my_gallery/features/auth/data/auth_service.dart';
import 'package:my_gallery/features/auth/data/models/auth_models.dart';

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
  final AuthService _authService;

  AuthCubit(this._authService) : super(const AuthState.initial());

  AuthUser? _currentUser;
  AuthUser? get currentUser => _currentUser;

  Future<void> checkSession() async {
    emit(const AuthState.checking());
    final hasSession = await SecureStorage.hasValidSession();
    if (!hasSession) {
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
      emit(AuthState.authenticated(_currentUser!));
    } catch (_) {
      await SecureStorage.clearAll();
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    try {
      final result = await _authService.login(email: email, password: password);
      await SecureStorage.saveTokens(
        accessToken: result.accessToken,
        expiresAt: result.expiresAt,
      );
      _currentUser = result.user;
      emit(AuthState.authenticated(result.user));
    } on ApiException catch (e) {
      emit(AuthState.error(e.message));
    } catch (_) {
      emit(const AuthState.error('حدث خطأ غير متوقع'));
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    emit(const AuthState.unauthenticated());
  }
}
