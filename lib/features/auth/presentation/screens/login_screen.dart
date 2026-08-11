import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/core/network/api_error_localizer.dart';
import 'package:my_gallery/core/network/api_exception.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/l10n/app_localizations.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';
import 'package:my_gallery/shared/widgets/no_internet_view.dart';

/// Premium, business-oriented login screen.
///
/// White-label: brand name and logo come from [SettingsCubit] (never hardcoded).
/// Arabic-first / RTL, light & dark aware, responsive and keyboard-safe. All
/// strings are localized; per-error UX distinguishes offline / timeout / server
/// / invalid-credentials.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _passFocus = FocusNode();

  bool _obscure = true;
  bool _autoValidate = false;
  bool _showNoInternet = false;

  static final _emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) context.read<AuthCubit>().checkSession();
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _submit() {
    // Prevent double submission while a request is in flight.
    if (context.read<AuthCubit>().state is AuthLoading) return;
    FocusScope.of(context).unfocus();
    setState(() => _autoValidate = true);
    if (!_formKey.currentState!.validate()) return;
    setState(() => _showNoInternet = false);
    context.read<AuthCubit>().login(_emailCtrl.text.trim(), _passCtrl.text);
  }

  String _loginErrorMessage(AppLocalizations? l10n, ApiException? err) {
    if (l10n == null) return err?.message ?? 'حدث خطأ غير متوقع';
    switch (err?.kind) {
      case ApiErrorKind.unauthorized:
        // Never reveal whether the email exists.
        return l10n.invalidCredentials;
      case ApiErrorKind.timeout:
        return l10n.requestTimeoutMessage;
      case ApiErrorKind.server:
        return l10n.serverErrorTitle;
      case null:
        return l10n.error_unknown;
      default:
        return err!.localizedMessage(l10n);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthAuthenticated():
            context.go('/home');
          case AuthError():
            final err = context.read<AuthCubit>().lastLoginError;
            if (err?.kind == ApiErrorKind.network) {
              // Offline → swap the form for the reusable no-internet view.
              setState(() => _showNoInternet = true);
            } else {
              setState(() => _showNoInternet = false);
              AppSnackbar.showError(
                context,
                _loginErrorMessage(AppLocalizations.of(context), err),
              );
            }
          default:
            break;
        }
      },
      builder: (context, state) {
        if (state is AuthInitial || state is AuthChecking) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final isLoading = state is AuthLoading;
        final settings = context.watch<SettingsCubit>().currentOrDefault;
        return Scaffold(
          body: SafeArea(
            child: _showNoInternet
                ? NoInternetView(
                    onRetry: isLoading ? null : _submit,
                  )
                : _buildForm(context, isLoading, settings),
          ),
        );
      },
    );
  }

  Widget _buildForm(
    BuildContext context,
    bool isLoading,
    StorefrontSettings settings,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autoValidate
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 24),
                        _buildHeader(context, settings),
                        const SizedBox(height: 40),
                        _buildFields(context, isLoading),
                        const SizedBox(height: 28),
                        _buildButton(context, isLoading),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, StorefrontSettings settings) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final logo = settings.logo;
    final hasLogo = logo != null && logo.isNotEmpty;

    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: hasLogo ? cs.surfaceContainerHighest : cs.primary,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withValues(alpha: 0.22),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: hasLogo
              ? AppNetworkImage(
                  imagePath: logo,
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                )
              : Icon(Icons.storefront_rounded, color: cs.onPrimary, size: 44),
        )
            .animate()
            .fadeIn(duration: 450.ms)
            .scale(begin: const Offset(0.85, 0.85), curve: Curves.easeOutBack),
        const SizedBox(height: 20),
        Text(
          settings.brandName,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium?.copyWith(
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
        const SizedBox(height: 12),
        Text(
          l10n?.loginWelcome ?? 'مرحبًا بك 👋',
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ).animate().fadeIn(delay: 150.ms, duration: 400.ms),
        const SizedBox(height: 8),
        Text(
          l10n?.loginSubtitle ?? 'سجّل الدخول للمتابعة إلى حسابك',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
      ],
    );
  }

  Widget _buildFields(BuildContext context, bool isLoading) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FieldLabel(l10n?.email ?? 'البريد الإلكتروني'),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailCtrl,
          enabled: !isLoading,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.username, AutofillHints.email],
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
          onFieldSubmitted: (_) => _passFocus.requestFocus(),
          decoration: _fieldDecoration(
            context,
            hint: l10n?.emailHint ?? 'أدخل بريدك الإلكتروني',
            icon: Icons.alternate_email_rounded,
          ),
          validator: (v) {
            final value = v?.trim() ?? '';
            if (value.isEmpty) {
              return l10n?.emailRequired ?? 'يرجى إدخال البريد الإلكتروني';
            }
            if (!_emailRegExp.hasMatch(value)) {
              return l10n?.invalidEmail ?? 'يرجى إدخال بريد إلكتروني صحيح';
            }
            return null;
          },
        )
            .animate()
            .fadeIn(delay: 250.ms, duration: 400.ms)
            .slideY(begin: 0.1, end: 0),
        const SizedBox(height: 18),
        _FieldLabel(l10n?.password ?? 'كلمة المرور'),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passCtrl,
          focusNode: _passFocus,
          enabled: !isLoading,
          obscureText: _obscure,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.password],
          onFieldSubmitted: (_) => _submit(),
          decoration: _fieldDecoration(
            context,
            hint: l10n?.passwordHint ?? 'أدخل كلمة المرور',
            icon: Icons.lock_outline_rounded,
            suffix: IconButton(
              onPressed: isLoading
                  ? null
                  : () => setState(() => _obscure = !_obscure),
              icon: Icon(
                _obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
          validator: (v) {
            if (v == null || v.isEmpty) {
              return l10n?.password_required ?? 'يرجى إدخال كلمة المرور';
            }
            return null;
          },
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 400.ms)
            .slideY(begin: 0.1, end: 0),
      ],
    );
  }

  InputDecoration _fieldDecoration(
    BuildContext context, {
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    final cs = Theme.of(context).colorScheme;
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color, width: width),
        );
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: border(cs.outlineVariant),
      focusedBorder: border(cs.primary, 1.6),
      errorBorder: border(cs.error),
      focusedErrorBorder: border(cs.error, 1.6),
    );
  }

  Widget _buildButton(BuildContext context, bool isLoading) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: 54,
      child: FilledButton(
        onPressed: isLoading ? null : _submit,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        // AnimatedSwitcher keeps the button size fixed between idle/loading,
        // so the layout never jumps when submission starts.
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? SizedBox(
                  key: const ValueKey('loading'),
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : Text(
                  key: const ValueKey('label'),
                  l10n?.signin ?? 'تسجيل الدخول',
                ),
        ),
      ),
    ).animate().fadeIn(delay: 350.ms, duration: 400.ms);
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
