import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/auth/data/auth_service.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/auth/presentation/screens/login_screen.dart';
import 'package:my_gallery/features/settings/data/settings_service.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/l10n/app_localizations.dart';
import 'package:my_gallery/shared/widgets/no_internet_view.dart';

/// Test double: no network, no secure storage, no navigation. Lets each test
/// drive the exact auth state it wants to assert against.
class _TestAuthCubit extends AuthCubit {
  _TestAuthCubit() : super(AuthService(dio: Dio()));

  int loginCalls = 0;

  @override
  Future<void> checkSession() async => emit(const AuthState.unauthenticated());

  @override
  Future<void> login(String email, String password) async {
    loginCalls++;
    emit(const AuthState.loading());
  }

  void simulateError(ApiException error) {
    lastLoginError = error;
    emit(AuthState.error(error.message));
  }

  void simulateLoading() => emit(const AuthState.loading());
}

void main() {
  late _TestAuthCubit auth;
  late SettingsCubit settings;

  setUp(() {
    auth = _TestAuthCubit();
    settings = SettingsCubit(SettingsService(dio: Dio()));
  });

  tearDown(() {
    auth.close();
    settings.close();
  });

  Widget harness() => MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>.value(value: auth),
          BlocProvider<SettingsCubit>.value(value: settings),
        ],
        child: MaterialApp(
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LoginScreen(),
        ),
      );

  Future<void> settle(WidgetTester tester) async {
    await tester.pump(); // resolve checkSession microtask → show the form
    await tester.pump(const Duration(seconds: 1)); // let entry animations run
  }

  testWidgets('shows required errors and does not submit when fields are empty',
      (tester) async {
    await tester.pumpWidget(harness());
    await settle(tester);

    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.text('يرجى إدخال البريد الإلكتروني'), findsOneWidget);
    expect(find.text('الرجاء إدخال كلمة المرور'), findsOneWidget);
    expect(auth.loginCalls, 0);
  });

  testWidgets('rejects an invalid email', (tester) async {
    await tester.pumpWidget(harness());
    await settle(tester);

    await tester.enterText(find.byType(TextFormField).first, 'not-an-email');
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(find.text('يرجى إدخال بريد إلكتروني صحيح'), findsOneWidget);
    expect(auth.loginCalls, 0);
  });

  testWidgets('submits once with valid credentials', (tester) async {
    await tester.pumpWidget(harness());
    await settle(tester);

    await tester.enterText(
        find.byType(TextFormField).first, 'owner@example.com');
    await tester.enterText(find.byType(TextFormField).last, 'secret123');
    await tester.tap(find.byType(FilledButton));
    await tester.pump();

    expect(auth.loginCalls, 1);
  });

  testWidgets('loading state shows a spinner and disables the button',
      (tester) async {
    await tester.pumpWidget(harness());
    await settle(tester);

    auth.simulateLoading();
    await tester.pump();

    expect(
      find.descendant(
        of: find.byType(FilledButton),
        matching: find.byType(CircularProgressIndicator),
      ),
      findsOneWidget,
    );
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('an offline login error swaps in the no-internet view',
      (tester) async {
    await tester.pumpWidget(harness());
    await settle(tester);

    auth.simulateError(
      const ApiException(kind: ApiErrorKind.network, message: 'x'),
    );
    await tester.pump(); // run the listener
    await tester.pump(const Duration(milliseconds: 400)); // view entry anim

    expect(find.byType(NoInternetView), findsOneWidget);
  });
}
