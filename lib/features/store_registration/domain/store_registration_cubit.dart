import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/auth/data/models/auth_models.dart';
import 'package:my_gallery/features/store_registration/data/models/store_registration_models.dart';
import 'package:my_gallery/features/store_registration/data/store_registration_service.dart';

/// State for the create-store wizard. A native Dart 3 `sealed` union (not
/// `@freezed`) so it supports exhaustive `switch`/pattern-matching without any
/// build_runner codegen.
sealed class StoreRegistrationState {
  const StoreRegistrationState();
}

class StoreRegInitial extends StoreRegistrationState {
  const StoreRegInitial();
}

class StoreRegSubmitting extends StoreRegistrationState {
  const StoreRegSubmitting();
}

class StoreRegSuccess extends StoreRegistrationState {
  final AuthResult result;
  const StoreRegSuccess(this.result);
}

class StoreRegError extends StoreRegistrationState {
  final String message;
  const StoreRegError(this.message);
}

/// Drives the create-store wizard: submits the accumulated form to the backend
/// and exposes the resulting auth session (or a user-facing error).
class StoreRegistrationCubit extends Cubit<StoreRegistrationState> {
  final StoreRegistrationService _service;

  StoreRegistrationCubit(this._service) : super(const StoreRegInitial());

  /// The last failure, kept so the screen can jump to the offending step
  /// (domain vs. credentials) by inspecting [ApiException] without widening
  /// the state shape.
  ApiException? lastError;

  Future<void> register(RegisterStoreRequest request) async {
    emit(const StoreRegSubmitting());
    lastError = null;
    try {
      final result = await _service.register(request);
      emit(StoreRegSuccess(result));
    } on ApiException catch (e) {
      lastError = e;
      emit(StoreRegError(e.message));
    } catch (_) {
      lastError = const ApiException(message: 'حدث خطأ غير متوقع');
      emit(const StoreRegError('حدث خطأ غير متوقع'));
    }
  }
}
