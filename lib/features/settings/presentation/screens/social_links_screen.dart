import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';
import 'package:my_gallery/features/settings/domain/social_links_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksScreen extends StatefulWidget {
  const SocialLinksScreen({super.key});

  @override
  State<SocialLinksScreen> createState() => _SocialLinksScreenState();
}

class _SocialLinksScreenState extends State<SocialLinksScreen> {
  final _formKey = GlobalKey<FormState>();
  final _instagram = TextEditingController();
  final _facebook = TextEditingController();
  final _whatsApp = TextEditingController();
  bool _populated = false;

  @override
  void initState() {
    super.initState();
    context.read<SocialLinksCubit>().load();
  }

  @override
  void dispose() {
    _instagram.dispose();
    _facebook.dispose();
    _whatsApp.dispose();
    super.dispose();
  }

  void _populate(SocialLinks links) {
    if (_populated) return;
    _instagram.text = links.instagram;
    _facebook.text = links.facebook;
    _whatsApp.text = links.whatsApp;
    _populated = true;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<SocialLinksCubit>().save(SocialLinks(
          instagram: _instagram.text.trim(),
          facebook: _facebook.text.trim(),
          whatsApp: _whatsApp.text.trim(),
        ));
  }

  String? _validateUrl(String? v, String platform) {
    if (v == null || v.trim().isEmpty) return null;
    final trimmed = v.trim();
    final uri = Uri.tryParse(trimmed);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      return 'رابط $platform غير صالح (يجب أن يبدأ بـ https://)';
    }
    return null;
  }

  String? _validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return null;
    final digits = v.trim().replaceAll(RegExp(r'[\s\-()]'), '');
    if (!RegExp(r'^\+?\d{7,15}$').hasMatch(digits)) {
      return 'رقم الواتساب غير صالح (أرقام فقط، مثال: 966501234567+)';
    }
    return null;
  }

  Future<void> _launch(String url) async {
    final uri = Uri.tryParse(url.trim());
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchWhatsApp(String phone) async {
    final digits = phone.trim().replaceAll(RegExp(r'[\s\-+()]'), '');
    final uri = Uri.parse('https://wa.me/$digits');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLinksCubit, SocialLinksState>(
      listener: (context, state) {
        switch (state) {
          case SocialLinksLoaded(:final links):
            _populate(links);
          case SocialLinksSaved(:final links):
            _populate(links);
            AppSnackbar.showSuccess(context, 'تم حفظ روابط التواصل');
            context.pop();
          case SocialLinksError(:final message, :final links):
            if (links != null) _populate(links);
            AppSnackbar.showError(context, message);
          default:
            break;
        }
      },
      builder: (context, state) {
        final isBusy = state is SocialLinksLoading || state is SocialLinksSaving;

        return Scaffold(
          appBar: AppBar(title: const Text('روابط التواصل الاجتماعي')),
          body: switch (state) {
            SocialLinksLoading() => _buildShimmer(context),
            SocialLinksInitial() => _buildShimmer(context),
            SocialLinksError(links: null) => _buildLoadError(context, state.message),
            _ => _buildForm(context, isBusy),
          },
          bottomNavigationBar: state is! SocialLinksLoading &&
                  state is! SocialLinksInitial &&
                  (state is! SocialLinksError || state.links != null)
              ? _buildSaveBar(context, isBusy)
              : null,
        );
      },
    );
  }

  Widget _buildShimmer(BuildContext context) {
    final base = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlight = Theme.of(context).colorScheme.surface;
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: List.generate(
          3,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.error.withValues(alpha: 0.6)),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              _populated = false;
              context.read<SocialLinksCubit>().load();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, bool isBusy) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SocialField(
              controller: _instagram,
              label: 'إنستغرام',
              hint: 'https://instagram.com/yourshop',
              icon: Icons.camera_alt_outlined,
              keyboardType: TextInputType.url,
              enabled: !isBusy,
              validator: (v) => _validateUrl(v, 'إنستغرام'),
              onPreview: () => _launch(_instagram.text),
            ),
            const SizedBox(height: 16),
            _SocialField(
              controller: _facebook,
              label: 'فيسبوك',
              hint: 'https://facebook.com/yourpage',
              icon: Icons.facebook_outlined,
              keyboardType: TextInputType.url,
              enabled: !isBusy,
              validator: (v) => _validateUrl(v, 'فيسبوك'),
              onPreview: () => _launch(_facebook.text),
            ),
            const SizedBox(height: 16),
            _SocialField(
              controller: _whatsApp,
              label: 'واتساب',
              hint: '+966501234567',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d+\-\s()]'))],
              enabled: !isBusy,
              validator: _validatePhone,
              onPreview: () => _launchWhatsApp(_whatsApp.text),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveBar(BuildContext context, bool isBusy) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: FilledButton.icon(
          onPressed: isBusy ? null : _submit,
          icon: isBusy
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Icon(Icons.save_outlined),
          label: const Text('حفظ الروابط'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
        ),
      ),
    );
  }
}

class _SocialField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final String? Function(String?) validator;
  final VoidCallback onPreview;

  const _SocialField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.keyboardType,
    this.inputFormatters,
    required this.enabled,
    required this.validator,
    required this.onPreview,
  });

  @override
  State<_SocialField> createState() => _SocialFieldState();
}

class _SocialFieldState extends State<_SocialField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = widget.controller.text.trim().isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            prefixIcon: Icon(widget.icon),
            border: const OutlineInputBorder(),
          ),
          validator: widget.validator,
        ),
        if (hasValue) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: widget.onPreview,
            child: Chip(
              avatar: Icon(Icons.open_in_new,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary),
              label: Text(
                widget.controller.text.trim(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                ),
              ),
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
