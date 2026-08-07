import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/core/config/app_config.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';
import 'package:my_gallery/features/settings/domain/site_customization_cubit.dart';
import 'package:my_gallery/features/settings/domain/theme_cubit.dart';
import 'package:my_gallery/theme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

/// Resolves a server image path (`/uploads/x.png`) or absolute URL into a full
/// URL for previews.
String _resolveImageUrl(String path) {
  if (path.isEmpty) return path;
  if (path.startsWith('http')) return path;
  return '${AppConfig.baseUrl}$path';
}

String colorToHex(Color c) =>
    '#${(c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';

class SiteCustomizationScreen extends StatefulWidget {
  const SiteCustomizationScreen({super.key});

  @override
  State<SiteCustomizationScreen> createState() =>
      _SiteCustomizationScreenState();
}

class _SiteCustomizationScreenState extends State<SiteCustomizationScreen> {
  final _brand = TextEditingController();
  final _website = TextEditingController();
  final _instagram = TextEditingController();
  final _facebook = TextEditingController();
  final _whatsApp = TextEditingController();
  final _picker = ImagePicker();
  final _debounce = _Debouncer();
  bool _populated = false;

  @override
  void initState() {
    super.initState();
    context.read<SiteCustomizationCubit>().load();
  }

  @override
  void dispose() {
    _brand.dispose();
    _website.dispose();
    _instagram.dispose();
    _facebook.dispose();
    _whatsApp.dispose();
    _debounce.dispose();
    super.dispose();
  }

  void _populate(StorefrontSettings s) {
    if (_populated) return;
    _brand.text = s.brandName;
    _website.text = s.website;
    _instagram.text = s.social.instagram;
    _facebook.text = s.social.facebook;
    _whatsApp.text = s.social.whatsApp;
    _populated = true;
  }

  SiteCustomizationCubit get _cubit => context.read<SiteCustomizationCubit>();

  Future<File?> _pick() async {
    final x = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 90);
    return x == null ? null : File(x.path);
  }

  void _pushSocial() => _cubit.setSocial(SocialLinks(
        instagram: _instagram.text.trim(),
        facebook: _facebook.text.trim(),
        whatsApp: _whatsApp.text.trim(),
      ));

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SiteCustomizationCubit, SiteCustomizationState>(
      listener: (context, state) {
        switch (state) {
          case SiteCustomizationReady(:final draft):
            _populate(draft);
          case SiteCustomizationSaved():
            AppSnackbar.showSuccess(context, 'تم حفظ إعدادات المظهر.');
            context.pop();
          case SiteCustomizationOpError(:final message):
            AppSnackbar.showError(context, message);
          default:
            break;
        }
      },
      builder: (context, state) {
        final draft = state.draftOrNull;
        final saving =
            state is SiteCustomizationReady && state.saving;
        final uploadingField =
            state is SiteCustomizationReady ? state.uploadingField : null;

        return Scaffold(
          body: switch (state) {
            SiteCustomizationLoading() => _buildShimmer(context),
            SiteCustomizationLoadError(:final message) =>
              _buildLoadError(context, message),
            _ => _buildForm(context, draft!, uploadingField),
          },
          bottomNavigationBar: draft == null
              ? null
              : _SaveBar(saving: saving, onSave: () => _cubit.save()),
        );
      },
    );
  }

  // ── States ──────────────────────────────────────────────────────────────

  Widget _buildShimmer(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(title: Text('تخصيص المظهر')),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList.list(
            children: List.generate(
              4,
              (_) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Shimmer.fromColors(
                  baseColor: cs.surfaceContainerHighest,
                  highlightColor: cs.surface,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadError(BuildContext context, String message) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('تخصيص المظهر')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded,
                size: 64, color: cs.error.withValues(alpha: 0.6)),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(message, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                _populated = false;
                _cubit.load();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }

  // ── Form ────────────────────────────────────────────────────────────────

  Widget _buildForm(
    BuildContext context,
    StorefrontSettings draft,
    String? uploadingField,
  ) {
    var delay = 0;
    Widget animated(Widget child) {
      final w = child
          .animate()
          .fadeIn(delay: (delay).ms, duration: 300.ms)
          .slideY(begin: 0.05, curve: Curves.easeOut);
      delay += 70;
      return w;
    }

    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(title: Text('تخصيص المظهر')),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          sliver: SliverList.list(
            children: [
              animated(_brandingSection(context, draft, uploadingField)),
              const SizedBox(height: 16),
              animated(_websiteSection(context)),
              const SizedBox(height: 16),
              animated(_colorsSection(context, draft)),
              const SizedBox(height: 16),
              animated(_shapeTypeSection(context, draft)),
              const SizedBox(height: 16),
              animated(_heroSection(context, draft, uploadingField)),
              const SizedBox(height: 16),
              animated(_socialSection(context)),
              const SizedBox(height: 16),
              animated(_themeSourceSection(context, draft)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget child,
    Widget? trailing,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: cs.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                if (trailing != null) trailing,
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  // 1 — Branding
  Widget _brandingSection(
    BuildContext context,
    StorefrontSettings draft,
    String? uploadingField,
  ) {
    return _sectionCard(
      context: context,
      title: 'الهوية',
      icon: Icons.badge_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _brand,
            decoration: const InputDecoration(
              labelText: 'اسم المعرض',
              prefixIcon: Icon(Icons.storefront_outlined),
            ),
            onChanged: (v) =>
                _debounce.run(() => _cubit.setBrandName(v.trim())),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ImageUploadTile(
                  label: 'الشعار',
                  url: draft.logo ?? '',
                  circular: true,
                  uploading: uploadingField == 'logo',
                  onPick: () async {
                    final f = await _pick();
                    if (f != null) await _cubit.pickAndUploadLogo(f);
                  },
                  onUrl: (url) => _cubit.setLogoUrl(url),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ImageUploadTile(
                  label: 'الأيقونة',
                  url: draft.favicon ?? '',
                  circular: false,
                  uploading: uploadingField == 'favicon',
                  onPick: () async {
                    final f = await _pick();
                    if (f != null) await _cubit.pickAndUploadFavicon(f);
                  },
                  onUrl: (url) => _cubit.setFaviconUrl(url),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2 — Website
  Widget _websiteSection(BuildContext context) {
    return _sectionCard(
      context: context,
      title: 'الموقع الرسمي',
      icon: Icons.public_rounded,
      child: _WebsiteField(
        controller: _website,
        onChanged: (v) => _debounce.run(() => _cubit.setWebsite(v.trim())),
      ),
    );
  }

  // 3 — Colors
  Widget _colorsSection(BuildContext context, StorefrontSettings draft) {
    const roles = <(ColorRole, String)>[
      (ColorRole.primary, 'الأساسي'),
      (ColorRole.secondary, 'الثانوي'),
      (ColorRole.accent, 'التمييز'),
      (ColorRole.background, 'الخلفية'),
      (ColorRole.surface, 'السطح'),
      (ColorRole.text, 'النص'),
    ];
    String hexOf(ColorRole r) => switch (r) {
          ColorRole.primary => draft.primaryColor,
          ColorRole.secondary => draft.secondaryColor,
          ColorRole.accent => draft.accentColor,
          ColorRole.background => draft.backgroundColor,
          ColorRole.surface => draft.surfaceColor,
          ColorRole.text => draft.textColor,
        };

    return _sectionCard(
      context: context,
      title: 'الألوان',
      icon: Icons.palette_outlined,
      trailing: TextButton.icon(
        onPressed: () => _confirmResetColors(context),
        icon: const Icon(Icons.restart_alt, size: 18),
        label: const Text('إعادة الضبط'),
      ),
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.9,
            children: [
              for (final (role, label) in roles)
                _ColorSwatch(
                  label: label,
                  hex: hexOf(role),
                  onTap: () => _openColorPicker(context, role, hexOf(role)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          _LivePreview(draft: draft),
        ],
      ),
    );
  }

  // 4 — Shape & type
  Widget _shapeTypeSection(BuildContext context, StorefrontSettings draft) {
    const fonts = ['Tajawal', 'Cairo'];
    final family = fonts.contains(draft.fontFamily) ? draft.fontFamily : 'Tajawal';
    final cs = Theme.of(context).colorScheme;

    return _sectionCard(
      context: context,
      title: 'الشكل والخط',
      icon: Icons.format_shapes_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('استدارة الحواف',
                  style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              Text('${draft.borderRadius.round()}',
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: draft.borderRadius.clamp(0, 32),
                  min: 0,
                  max: 32,
                  divisions: 32,
                  label: '${draft.borderRadius.round()}',
                  onChanged: (v) => _cubit.setRadius(v),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: cs.primary,
                  borderRadius:
                      BorderRadius.circular(draft.borderRadius.clamp(0, 32)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: family,
            decoration: const InputDecoration(
              labelText: 'الخط',
              prefixIcon: Icon(Icons.text_fields_rounded),
            ),
            items: [
              for (final f in fonts)
                DropdownMenuItem(value: f, child: Text(f)),
            ],
            onChanged: (v) {
              if (v != null) _cubit.setFontFamily(v);
            },
          ),
        ],
      ),
    );
  }

  // 5 — Hero slides
  Widget _heroSection(
    BuildContext context,
    StorefrontSettings draft,
    String? uploadingField,
  ) {
    final slides = draft.heroSlides;
    return _sectionCard(
      context: context,
      title: 'السلايدر',
      icon: Icons.view_carousel_outlined,
      trailing: IconButton.filledTonal(
        onPressed: () => _cubit.addHero(),
        icon: const Icon(Icons.add),
        tooltip: 'إضافة شريحة',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (slides.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text('لا توجد شرائح بعد — اضغط + للإضافة.',
                  style: Theme.of(context).textTheme.bodySmall),
            )
          else
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              itemCount: slides.length,
              onReorder: (o, n) => _cubit.reorderHero(o, n),
              itemBuilder: (context, i) => _HeroCard(
                key: ValueKey('hero_$i'),
                index: i,
                slide: slides[i],
                uploading: uploadingField == 'hero:$i',
                onChanged: (s) => _cubit.updateHero(i, s),
                onRemove: () => _cubit.removeHero(i),
                onPickImage: () async {
                  final f = await _pick();
                  if (f != null) await _cubit.pickAndUploadHeroImage(f, i);
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('الشرائح بدون صورة تُتجاهَل عند الحفظ.',
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }

  // 6 — Social
  Widget _socialSection(BuildContext context) {
    return _sectionCard(
      context: context,
      title: 'روابط التواصل',
      icon: Icons.share_outlined,
      child: Column(
        children: [
          TextField(
            controller: _instagram,
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              labelText: 'إنستغرام',
              hintText: 'https://instagram.com/yourshop',
              prefixIcon: Icon(Icons.camera_alt_outlined),
            ),
            onChanged: (_) => _debounce.run(_pushSocial),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _facebook,
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              labelText: 'فيسبوك',
              hintText: 'https://facebook.com/yourpage',
              prefixIcon: Icon(Icons.facebook_outlined),
            ),
            onChanged: (_) => _debounce.run(_pushSocial),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _whatsApp,
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d+\-\s()]'))
            ],
            decoration: const InputDecoration(
              labelText: 'واتساب',
              hintText: '+966501234567',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            onChanged: (_) => _debounce.run(_pushSocial),
          ),
        ],
      ),
    );
  }

  // 7 — Theme source
  Widget _themeSourceSection(BuildContext context, StorefrontSettings draft) {
    return _sectionCard(
      context: context,
      title: 'مصدر ألوان الثيم',
      icon: Icons.contrast_rounded,
      child: BlocBuilder<ThemeCubit, ThemeSettings>(
        builder: (context, themeState) {
          final source = themeState.source;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ThemeSourceOption(
                label: 'ألوان الهوية البصرية',
                selected: source == ThemeSource.identity,
                palette: ThemePalette.fromSettings(draft),
                onTap: () => context
                    .read<ThemeCubit>()
                    .setThemeSource(ThemeSource.identity),
              ),
              const SizedBox(height: 12),
              _ThemeSourceOption(
                label: 'الثيم الافتراضي',
                selected: source == ThemeSource.appDefault,
                palette: kDefaultPalette,
                onTap: () => context
                    .read<ThemeCubit>()
                    .setThemeSource(ThemeSource.appDefault),
              ),
              const SizedBox(height: 8),
              Text(
                source == ThemeSource.appDefault
                    ? 'التطبيق يعرض الثيم الافتراضي — تعديلات ألوان الهوية تُحفظ للمتجر لكنها لا تغيّر مظهر التطبيق.'
                    : 'التطبيق يتبع ألوان هوية المعرض.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Dialogs ───────────────────────────────────────────────────────────────

  void _openColorPicker(BuildContext context, ColorRole role, String hex) {
    var picked = hexToColor(hex);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('اختر اللون'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: picked,
            enableAlpha: false,
            portraitOnly: true,
            onColorChanged: (c) => picked = c,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              _cubit.setColor(role, colorToHex(picked));
              Navigator.pop(dialogContext);
            },
            child: const Text('تم'),
          ),
        ],
      ),
    );
  }

  void _confirmResetColors(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('إعادة ضبط الألوان'),
        content: const Text(
            'سيتم إرجاع الألوان واستدارة الحواف إلى القيم الافتراضية. متابعة؟'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              _cubit.resetColorsToDefault();
              Navigator.pop(dialogContext);
            },
            child: Text('إعادة الضبط', style: TextStyle(color: cs.error)),
          ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────────────────────

class _SaveBar extends StatelessWidget {
  final bool saving;
  final VoidCallback onSave;
  const _SaveBar({required this.saving, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: FilledButton.icon(
          onPressed: saving ? null : onSave,
          icon: saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : const Icon(Icons.save_outlined),
          label: const Text('حفظ التغييرات'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
        ),
      ),
    );
  }
}

class _WebsiteField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _WebsiteField({required this.controller, required this.onChanged});

  @override
  State<_WebsiteField> createState() => _WebsiteFieldState();
}

class _WebsiteFieldState extends State<_WebsiteField> {
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

  Future<void> _open() async {
    final uri = Uri.tryParse(widget.controller.text.trim());
    if (uri == null || !uri.hasScheme) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasValue = widget.controller.text.trim().isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          textDirection: TextDirection.ltr,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'رابط الموقع',
            hintText: 'https://example.com',
            prefixIcon: Icon(Icons.link_rounded),
          ),
          onChanged: widget.onChanged,
        ),
        if (hasValue) ...[
          const SizedBox(height: 8),
          ActionChip(
            avatar: Icon(Icons.open_in_new, size: 16, color: cs.primary),
            label: const Text('فتح'),
            onPressed: _open,
          ),
        ],
      ],
    );
  }
}

class _ImageUploadTile extends StatelessWidget {
  final String label;
  final String url;
  final bool circular;
  final bool uploading;
  final Future<void> Function() onPick;
  final ValueChanged<String> onUrl;

  const _ImageUploadTile({
    required this.label,
    required this.url,
    required this.circular,
    required this.uploading,
    required this.onPick,
    required this.onUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final radius = circular ? 40.0 : 12.0;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: cs.outlineVariant),
              ),
              clipBehavior: Clip.antiAlias,
              child: url.isEmpty
                  ? Icon(Icons.image_outlined, color: cs.onSurfaceVariant)
                  : CachedNetworkImage(
                      imageUrl: _resolveImageUrl(url),
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) =>
                          Icon(Icons.broken_image_outlined,
                              color: cs.onSurfaceVariant),
                    ),
            ),
            if (uploading)
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: const Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: uploading ? null : onPick,
              child: Text(url.isEmpty ? 'رفع' : 'تغيير'),
            ),
            IconButton(
              tooltip: 'إدخال رابط',
              onPressed: uploading
                  ? null
                  : () => _promptUrl(context),
              icon: const Icon(Icons.link, size: 18),
            ),
          ],
        ),
      ],
    );
  }

  void _promptUrl(BuildContext context) {
    final controller = TextEditingController(text: url);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('رابط $label'),
        content: TextField(
          controller: controller,
          textDirection: TextDirection.ltr,
          decoration: const InputDecoration(hintText: 'https://…'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              onUrl(controller.text.trim());
              Navigator.pop(dialogContext);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final String label;
  final String hex;
  final VoidCallback onTap;
  const _ColorSwatch(
      {required this.label, required this.hex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            height: 44,
            decoration: BoxDecoration(
              color: hexToColor(hex),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.outlineVariant),
            ),
          ),
          const SizedBox(height: 6),
          Text(label,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          Text(hex.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

class _LivePreview extends StatelessWidget {
  final StorefrontSettings draft;
  const _LivePreview({required this.draft});

  @override
  Widget build(BuildContext context) {
    final primary = hexToColor(draft.primaryColor);
    final accent = hexToColor(draft.accentColor);
    final surface = hexToColor(draft.surfaceColor);
    final text = hexToColor(draft.textColor);
    final radius = draft.borderRadius.clamp(0, 32).toDouble();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: hexToColor(draft.backgroundColor),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('معاينة',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: text)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(radius / 2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('منتج تجريبي',
                          style: TextStyle(
                              color: text, fontWeight: FontWeight.w600)),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(radius / 2),
                        ),
                        child: Text('جديد',
                            style: TextStyle(color: accent, fontSize: 11)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: const Text('زر',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _ThemeSourceOption extends StatelessWidget {
  final String label;
  final bool selected;
  final ThemePalette palette;
  final VoidCallback onTap;
  const _ThemeSourceOption({
    required this.label,
    required this.selected,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? cs.primary : cs.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label)),
            for (final c in [
              palette.primary,
              palette.secondary,
              palette.accent,
              palette.background,
            ])
              Container(
                width: 18,
                height: 18,
                margin: const EdgeInsets.only(left: 4),
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(color: cs.outlineVariant),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatefulWidget {
  final int index;
  final HeroSlide slide;
  final bool uploading;
  final ValueChanged<HeroSlide> onChanged;
  final VoidCallback onRemove;
  final Future<void> Function() onPickImage;

  const _HeroCard({
    super.key,
    required this.index,
    required this.slide,
    required this.uploading,
    required this.onChanged,
    required this.onRemove,
    required this.onPickImage,
  });

  @override
  State<_HeroCard> createState() => _HeroCardState();
}

class _HeroCardState extends State<_HeroCard> {
  late final TextEditingController _title;
  late final TextEditingController _subtitle;
  late final TextEditingController _ctaText;
  late final TextEditingController _ctaHref;
  final _debounce = _Debouncer();

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.slide.title ?? '');
    _subtitle = TextEditingController(text: widget.slide.subtitle ?? '');
    _ctaText = TextEditingController(text: widget.slide.ctaText ?? '');
    _ctaHref = TextEditingController(text: widget.slide.ctaHref ?? '');
  }

  @override
  void dispose() {
    _title.dispose();
    _subtitle.dispose();
    _ctaText.dispose();
    _ctaHref.dispose();
    _debounce.dispose();
    super.dispose();
  }

  void _emit() {
    _debounce.run(() => widget.onChanged(HeroSlide(
          imageUrl: widget.slide.imageUrl,
          title: _title.text.trim(),
          subtitle: _subtitle.text.trim(),
          ctaText: _ctaText.text.trim(),
          ctaHref: _ctaHref.text.trim(),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final noImage = widget.slide.imageUrl.isEmpty;
    return Padding(
      key: ValueKey('hero_card_${widget.index}'),
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: noImage ? cs.error.withValues(alpha: 0.5) : cs.outlineVariant,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ReorderableDragStartListener(
                  index: widget.index,
                  child: Icon(Icons.drag_handle, color: cs.onSurfaceVariant),
                ),
                const SizedBox(width: 8),
                Text('شريحة ${widget.index + 1}',
                    style: Theme.of(context).textTheme.titleSmall),
                const Spacer(),
                IconButton(
                  onPressed: widget.onRemove,
                  icon: Icon(Icons.delete_outline, color: cs.error),
                  tooltip: 'حذف',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: cs.outlineVariant),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: noImage
                          ? Icon(Icons.add_photo_alternate_outlined,
                              color: cs.onSurfaceVariant)
                          : CachedNetworkImage(
                              imageUrl: _resolveImageUrl(widget.slide.imageUrl),
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Icon(
                                  Icons.broken_image_outlined,
                                  color: cs.onSurfaceVariant),
                            ),
                    ),
                    if (widget.uploading)
                      const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      OutlinedButton.icon(
                        onPressed:
                            widget.uploading ? null : widget.onPickImage,
                        icon: const Icon(Icons.upload_outlined, size: 18),
                        label: Text(noImage ? 'رفع صورة' : 'تغيير الصورة'),
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40)),
                      ),
                      if (noImage)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text('بدون صورة — لن تُحفظ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: cs.error)),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _slim(_title, 'العنوان'),
            _slim(_subtitle, 'العنوان الفرعي'),
            _slim(_ctaText, 'نص الزر'),
            _slim(_ctaHref, 'رابط الزر', ltr: true),
          ],
        ),
      ),
    );
  }

  Widget _slim(TextEditingController c, String label, {bool ltr = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextField(
        controller: c,
        textDirection: ltr ? TextDirection.ltr : null,
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        onChanged: (_) => _emit(),
      ),
    );
  }
}

/// Simple trailing-edge debouncer for text→cubit writes.
class _Debouncer {
  Timer? _timer;
  void run(VoidCallback action,
      {Duration delay = const Duration(milliseconds: 350)}) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() => _timer?.cancel();
}
