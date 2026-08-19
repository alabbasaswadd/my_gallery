import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/core/config/app_config.dart';
import 'package:my_gallery/features/auth/data/models/auth_models.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/store_registration/data/models/store_registration_models.dart';
import 'package:my_gallery/features/store_registration/domain/store_registration_cubit.dart';

/// Presentation-style, 4-step wizard for creating a new store: each step is
/// explained, the domain is chosen as a live subdomain, and login credentials
/// are set. On submit the backend provisions the store and returns a session,
/// which is adopted immediately so the owner lands on the dashboard.
class CreateStoreWizardScreen extends StatefulWidget {
  const CreateStoreWizardScreen({super.key});

  @override
  State<CreateStoreWizardScreen> createState() =>
      _CreateStoreWizardScreenState();
}

class _CreateStoreWizardScreenState extends State<CreateStoreWizardScreen> {
  static const _stepTitles = [
    'بيانات المتجر',
    'عنوان المتجر',
    'بيانات الدخول',
    'المراجعة',
  ];

  static const _businessTypes = [
    'ملابس وأزياء',
    'إلكترونيات وهواتف',
    'مجوهرات وإكسسوارات',
    'أحذية وحقائب',
    'مستحضرات تجميل وعطور',
    'أثاث ومستلزمات منزلية',
    'مواد غذائية ومخبوزات',
    'هدايا وتذكارات',
    'لعب أطفال وترفيه',
    'متجر متنوع',
    'أخرى',
  ];

  final _pageController = PageController();
  int _currentStep = 0;

  // One form per interactive step so each is validated independently.
  final _storeFormKey = GlobalKey<FormState>();
  final _domainFormKey = GlobalKey<FormState>();
  final _credentialsFormKey = GlobalKey<FormState>();

  final _shopName = TextEditingController();
  final _ownerName = TextEditingController();
  final _phone = TextEditingController();
  final _whatsApp = TextEditingController();
  final _city = TextEditingController();
  final _country = TextEditingController();
  final _description = TextEditingController();
  final _subdomain = TextEditingController();
  final _customDomain = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  String? _businessType;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  static final _emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final _labelRegExp = RegExp(r'^[a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?$');
  static final _hostRegExp = RegExp(
    r'^(?=.{1,253}$)([a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?)(\.[a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?)+$',
  );

  @override
  void dispose() {
    _pageController.dispose();
    for (final c in [
      _shopName,
      _ownerName,
      _phone,
      _whatsApp,
      _city,
      _country,
      _description,
      _subdomain,
      _customDomain,
      _email,
      _password,
      _confirmPassword,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  String get _subdomainPreview {
    final label = _subdomain.text.trim().toLowerCase();
    return '${label.isEmpty ? 'myshop' : label}.${AppConfig.storeBaseDomain}';
  }

  bool get _isSubmitting =>
      context.read<StoreRegistrationCubit>().state is StoreRegSubmitting;

  GlobalKey<FormState>? _formKeyFor(int step) => switch (step) {
        0 => _storeFormKey,
        1 => _domainFormKey,
        2 => _credentialsFormKey,
        _ => null,
      };

  void _goTo(int step) {
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  void _next() {
    FocusScope.of(context).unfocus();
    final key = _formKeyFor(_currentStep);
    if (key != null && !(key.currentState?.validate() ?? true)) return;
    if (_currentStep < _stepTitles.length - 1) _goTo(_currentStep + 1);
  }

  void _back() {
    FocusScope.of(context).unfocus();
    if (_currentStep > 0) _goTo(_currentStep - 1);
  }

  void _submit() {
    if (_isSubmitting) return;
    FocusScope.of(context).unfocus();
    // Re-validate every step so a jumped-to review can't submit stale input.
    for (var step = 0; step <= 2; step++) {
      final key = _formKeyFor(step);
      if (key != null && !(key.currentState?.validate() ?? true)) {
        _goTo(step);
        return;
      }
    }

    final request = RegisterStoreRequest(
      shopName: _shopName.text,
      ownerName: _ownerName.text,
      phone: _phone.text,
      whatsApp: _whatsApp.text,
      city: _city.text,
      country: _country.text,
      businessType: _businessType,
      description: _description.text,
      subdomainLabel: _subdomain.text,
      customDomain: _customDomain.text,
      email: _email.text,
      password: _password.text,
    );
    context.read<StoreRegistrationCubit>().register(request);
  }

  Future<void> _onSuccess(AuthResult result) async {
    await context.read<AuthCubit>().signInWithResult(result);
    if (mounted) context.go('/home');
  }

  void _onError() {
    final err = context.read<StoreRegistrationCubit>().lastError;
    // Route the user back to the step most likely at fault so they can fix it.
    final msg = err?.message ?? '';
    if (msg.contains('بريد')) {
      _goTo(2);
    } else if (msg.contains('نطاق')) {
      _goTo(1);
    }
    AppSnackbar.showError(
      context,
      msg.isEmpty ? 'تعذّر إنشاء المتجر' : msg,
      errors: err?.errors,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreRegistrationCubit, StoreRegistrationState>(
      listener: (context, state) {
        switch (state) {
          case StoreRegSuccess(:final result):
            _onSuccess(result);
          case StoreRegError():
            _onError();
          default:
            break;
        }
      },
      builder: (context, state) {
        final isSubmitting = state is StoreRegSubmitting;
        return Scaffold(
          appBar: AppBar(
            title: const Text('إنشاء متجر جديد'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                _StepIndicator(current: _currentStep, titles: _stepTitles),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (i) => setState(() => _currentStep = i),
                    children: [
                      _buildStoreStep(context),
                      _buildDomainStep(context),
                      _buildCredentialsStep(context),
                      _buildReviewStep(context),
                    ],
                  ),
                ),
                _buildNavBar(context, isSubmitting),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- Steps ------------------------------------------------------------------

  Widget _buildStoreStep(BuildContext context) {
    return _StepScroll(
      formKey: _storeFormKey,
      children: [
        const _StepHeader(
          icon: Icons.storefront_rounded,
          title: 'عرّفنا على متجرك',
          subtitle:
              'هذه البيانات تظهر لعملائك وتساعدهم على التواصل معك. اسم المتجر واسمك مطلوبان، والباقي اختياري.',
        ),
        _field(
          controller: _shopName,
          label: 'اسم المتجر *',
          hint: 'مثال: متجر الأزياء',
          icon: Icons.store_rounded,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'اسم المتجر مطلوب' : null,
        ),
        _field(
          controller: _ownerName,
          label: 'اسم المالك *',
          hint: 'الاسم الكامل',
          icon: Icons.person_rounded,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'اسم المالك مطلوب' : null,
        ),
        _field(
          controller: _phone,
          label: 'رقم الهاتف',
          hint: '+9639xxxxxxxx',
          icon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
        ),
        _field(
          controller: _whatsApp,
          label: 'رقم الواتساب',
          hint: '+9639xxxxxxxx',
          icon: Icons.chat_rounded,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
        ),
        _buildBusinessTypeField(context),
        _field(
          controller: _city,
          label: 'المدينة',
          hint: 'مثال: دمشق',
          icon: Icons.location_city_rounded,
        ),
        _field(
          controller: _country,
          label: 'الدولة',
          hint: 'مثال: سوريا',
          icon: Icons.public_rounded,
        ),
        _field(
          controller: _description,
          label: 'وصف مختصر للنشاط',
          hint: 'اكتب نبذة مختصرة عن نشاطك ومنتجاتك',
          icon: Icons.notes_rounded,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildDomainStep(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _StepScroll(
      formKey: _domainFormKey,
      children: [
        const _StepHeader(
          icon: Icons.link_rounded,
          title: 'اختر عنوان متجرك',
          subtitle:
              'العنوان هو الرابط الذي يفتح عليه عملاؤك متجرك. اختر اسماً قصيراً بالإنجليزية وسنمنحك رابطاً فورياً. نتحقق عند الإنشاء أنّ العنوان غير مستخدَم.',
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: _field(
            controller: _subdomain,
            label: 'النطاق الفرعي *',
            hint: 'myshop',
            icon: Icons.dns_rounded,
            textDirection: TextDirection.ltr,
            onChanged: (_) => setState(() {}),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9-]')),
            ],
            validator: (v) {
              final value = (v ?? '').trim().toLowerCase();
              if (value.isEmpty) return 'النطاق الفرعي مطلوب';
              if (!_labelRegExp.hasMatch(value)) {
                return 'استخدم حروفاً وأرقاماً إنجليزية وشرطات فقط';
              }
              return null;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.public_rounded, size: 18, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'رابط متجرك: $_subdomainPreview',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
        _field(
          controller: _customDomain,
          label: 'نطاق خاص (اختياري)',
          hint: 'myshop.com',
          icon: Icons.language_rounded,
          textDirection: TextDirection.ltr,
          validator: (v) {
            final value = (v ?? '').trim().toLowerCase();
            if (value.isEmpty) return null;
            if (!_hostRegExp.hasMatch(value)) {
              return 'أدخل نطاقاً صحيحاً مثل myshop.com بدون http';
            }
            return null;
          },
        ),
        const _InfoNote(
          text:
              'لديك نطاق خاص؟ أدخله بدون https://. سيُفعّل بعد التحقق من ملكيته، بينما يعمل رابط المنصّة فوراً.',
        ),
      ],
    );
  }

  Widget _buildCredentialsStep(BuildContext context) {
    return _StepScroll(
      formKey: _credentialsFormKey,
      children: [
        const _StepHeader(
          icon: Icons.lock_rounded,
          title: 'أنشئ بيانات الدخول',
          subtitle:
              'بهذا البريد وكلمة المرور ستدخل إلى لوحة تحكّم متجرك لإدارة المنتجات والطلبات. احفظها في مكان آمن.',
        ),
        _field(
          controller: _email,
          label: 'البريد الإلكتروني *',
          hint: 'you@example.com',
          icon: Icons.alternate_email_rounded,
          keyboardType: TextInputType.emailAddress,
          textDirection: TextDirection.ltr,
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
          validator: (v) {
            final value = (v ?? '').trim();
            if (value.isEmpty) return 'البريد الإلكتروني مطلوب';
            if (!_emailRegExp.hasMatch(value)) {
              return 'يرجى إدخال بريد إلكتروني صحيح';
            }
            return null;
          },
        ),
        _field(
          controller: _password,
          label: 'كلمة المرور *',
          hint: '٨ أحرف على الأقل',
          icon: Icons.lock_outline_rounded,
          obscureText: _obscurePassword,
          suffix: IconButton(
            onPressed: () =>
                setState(() => _obscurePassword = !_obscurePassword),
            icon: Icon(_obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined),
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return 'كلمة المرور مطلوبة';
            if (v.length < 8) return 'كلمة المرور يجب ألا تقل عن 8 أحرف';
            return null;
          },
        ),
        _field(
          controller: _confirmPassword,
          label: 'تأكيد كلمة المرور *',
          hint: 'أعد إدخال كلمة المرور',
          icon: Icons.lock_reset_rounded,
          obscureText: _obscureConfirm,
          suffix: IconButton(
            onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
            icon: Icon(_obscureConfirm
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined),
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return 'تأكيد كلمة المرور مطلوب';
            if (v != _password.text) return 'كلمتا المرور غير متطابقتين';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildReviewStep(BuildContext context) {
    return _StepScroll(
      children: [
        const _StepHeader(
          icon: Icons.fact_check_rounded,
          title: 'راجع بياناتك ثم أنشئ متجرك',
          subtitle:
              'تأكّد من صحّة المعلومات التالية. بالضغط على "إنشاء المتجر" سيُنشأ متجرك فوراً وتُنقل إلى لوحة التحكّم.',
        ),
        _ReviewCard(rows: [
          ('اسم المتجر', _shopName.text.trim()),
          ('اسم المالك', _ownerName.text.trim()),
          if (_businessType != null) ('نوع النشاط', _businessType!),
          ('رابط المتجر', _subdomainPreview),
          if (_customDomain.text.trim().isNotEmpty)
            ('نطاق خاص', _customDomain.text.trim()),
          ('البريد الإلكتروني', _email.text.trim()),
        ]),
      ],
    );
  }

  // --- Field builders ---------------------------------------------------------

  Widget _buildBusinessTypeField(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        initialValue: _businessType,
        isExpanded: true,
        decoration: _decoration(context,
            label: 'نوع النشاط', icon: Icons.category_rounded),
        hint: const Text('اختر نوع النشاط'),
        items: _businessTypes
            .map((t) => DropdownMenuItem(value: t, child: Text(t)))
            .toList(),
        onChanged: (v) => setState(() => _businessType = v),
        dropdownColor: cs.surface,
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextDirection? textDirection,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
    bool obscureText = false,
    Widget? suffix,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        textDirection: textDirection,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        obscureText: obscureText,
        maxLines: obscureText ? 1 : maxLines,
        decoration: _decoration(context,
            label: label, hint: hint, icon: icon, suffix: suffix),
      ),
    );
  }

  InputDecoration _decoration(
    BuildContext context, {
    required String label,
    String? hint,
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
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
      enabledBorder: border(cs.outlineVariant),
      focusedBorder: border(cs.primary, 1.6),
      errorBorder: border(cs.error),
      focusedErrorBorder: border(cs.error, 1.6),
    );
  }

  // --- Bottom navigation ------------------------------------------------------

  Widget _buildNavBar(BuildContext context, bool isSubmitting) {
    final isLast = _currentStep == _stepTitles.length - 1;
    final isFirst = _currentStep == 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Row(
        children: [
          if (!isFirst)
            TextButton.icon(
              onPressed: isSubmitting ? null : _back,
              icon: const Icon(Icons.chevron_right_rounded),
              label: const Text('السابق'),
            ),
          const Spacer(),
          SizedBox(
            height: 50,
            child: FilledButton(
              onPressed: isSubmitting ? null : (isLast ? _submit : _next),
              style: FilledButton.styleFrom(
                minimumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isSubmitting
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
                        isLast ? 'إنشاء المتجر' : 'التالي',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable wizard pieces
// ---------------------------------------------------------------------------

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.current, required this.titles});
  final int current;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: List.generate(titles.length, (i) {
          final done = i < current;
          final active = i == current;
          final color = (done || active) ? cs.primary : cs.outlineVariant;
          return Expanded(
            child: Row(
              children: [
                _Dot(index: i, done: done, active: active),
                if (i < titles.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      color: color,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.index, required this.done, required this.active});
  final int index;
  final bool done;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final filled = done || active;
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? cs.primary : cs.surface,
        border: Border.all(
          color: filled ? cs.primary : cs.outlineVariant,
          width: 2,
        ),
      ),
      child: done
          ? Icon(Icons.check_rounded, size: 16, color: cs.onPrimary)
          : Text(
              '${index + 1}',
              style: TextStyle(
                color: active ? cs.onPrimary : cs.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
    );
  }
}

/// A scrollable step body, optionally wrapped in a [Form].
class _StepScroll extends StatelessWidget {
  const _StepScroll({required this.children, this.formKey});
  final List<Widget> children;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
    final centered = Center(child: content);
    if (formKey == null) return centered.animate().fadeIn(duration: 250.ms);
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: centered,
    ).animate().fadeIn(duration: 250.ms);
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: cs.primaryContainer.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: cs.primary, size: 26),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoNote extends StatelessWidget {
  const _InfoNote({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 18, color: cs.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.rows});
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: i == rows.length - 1
                    ? null
                    : Border(bottom: BorderSide(color: cs.outlineVariant)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      rows[i].$1,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      rows[i].$2,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
