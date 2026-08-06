import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

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
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(_emailCtrl.text.trim(), _passCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthAuthenticated():
            context.go('/home');
          case AuthError(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
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
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),
                    _buildHeader(context),
                    const SizedBox(height: 48),
                    _buildFields(context, isLoading),
                    const SizedBox(height: 24),
                    _buildButton(isLoading),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.storefront_rounded,
            color: Colors.white,
            size: 40,
          ),
        ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.8, 0.8)),
        const SizedBox(height: 20),
        Text(
          'تسجيل الدخول',
          style: Theme.of(context).textTheme.headlineLarge,
        ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
        const SizedBox(height: 8),
        Text(
          'أدخل بيانات حسابك للمتابعة',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
        ).animate().fadeIn(delay: 150.ms, duration: 400.ms),
      ],
    );
  }

  Widget _buildFields(BuildContext context, bool isLoading) {
    return Column(
      children: [
        TextFormField(
          controller: _emailCtrl,
          enabled: !isLoading,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'البريد الإلكتروني',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'البريد الإلكتروني مطلوب';
            if (!v.contains('@')) return 'البريد الإلكتروني غير صالح';
            return null;
          },
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passCtrl,
          enabled: !isLoading,
          obscureText: _obscure,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            labelText: 'كلمة المرور',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscure = !_obscure),
              icon: Icon(
                _obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return 'كلمة المرور مطلوبة';
            if (v.length < 6) return 'كلمة المرور قصيرة جداً';
            return null;
          },
        ).animate().fadeIn(delay: 250.ms, duration: 400.ms).slideY(begin: 0.1),
      ],
    );
  }

  Widget _buildButton(bool isLoading) {
    return ElevatedButton(
      onPressed: isLoading ? null : _submit,
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Text('دخول'),
    ).animate().fadeIn(delay: 300.ms, duration: 400.ms);
  }
}
