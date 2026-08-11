import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:my_gallery/shared/services/share_service.dart';
import 'package:my_gallery/shared/widgets/network_image.dart';
import 'package:my_gallery/shared/widgets/qr_card.dart';

/// Full-screen QR preview + export surface, shared by both product QR and store
/// QR. Renders a [QrCard] inside a [RepaintBoundary] and exposes
/// Save-as-PNG / Share-image / Copy-URL / Share-URL / Open actions.
class QrExportScreen extends StatefulWidget {
  final String appBarTitle;
  final String url;
  final String storeName;
  final String? logoUrl;
  final String? productName;

  /// Base name (no extension) for the exported PNG file.
  final String fileBaseName;

  const QrExportScreen({
    super.key,
    required this.appBarTitle,
    required this.url,
    required this.storeName,
    required this.fileBaseName,
    this.logoUrl,
    this.productName,
  });

  @override
  State<QrExportScreen> createState() => _QrExportScreenState();
}

class _QrExportScreenState extends State<QrExportScreen> {
  final GlobalKey _cardKey = GlobalKey();
  bool _busy = false;
  bool _logoPrecached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheLogo();
  }

  Future<void> _precacheLogo() async {
    if (_logoPrecached) return;
    _logoPrecached = true;
    final url = resolveImageUrl(widget.logoUrl);
    if (url == null) return;
    try {
      await precacheImage(CachedNetworkImageProvider(url), context);
      // Give the freshly-cached logo a frame to paint before any capture.
      if (mounted) setState(() {});
    } catch (_) {
      // Non-fatal — the card falls back to the store initial.
    }
  }

  Future<Uint8List?> _capture() async {
    try {
      final boundary =
          _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      return data?.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }

  Future<void> _run(Future<void> Function(Uint8List bytes) action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final bytes = await _capture();
      if (bytes == null) {
        if (mounted) {
          AppSnackbar.showError(context, 'تعذّر إنشاء صورة رمز QR');
        }
        return;
      }
      await action(bytes);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: RepaintBoundary(
                    key: _cardKey,
                    child: QrCard(
                      url: widget.url,
                      storeName: widget.storeName,
                      logoUrl: widget.logoUrl,
                      productName: widget.productName,
                      accentColor: cs.primary,
                    ),
                  ),
                ),
              ),
            ),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _run(
                          (b) => ShareService.saveImageToGallery(
                            context,
                            b,
                            name: widget.fileBaseName,
                          ),
                        ),
                  icon: _busy
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.download_rounded),
                  label: const Text('حفظ كصورة'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: _busy
                      ? null
                      : () => _run(
                          (b) => ShareService.shareImage(
                            b,
                            fileName: '${widget.fileBaseName}.png',
                            text: widget.url,
                            subject: widget.productName ?? widget.storeName,
                          ),
                        ),
                  icon: const Icon(Icons.ios_share_rounded),
                  label: const Text('مشاركة الصورة'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => ShareService.copyText(context, widget.url),
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  label: const Text('نسخ الرابط'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => ShareService.openUrl(context, widget.url),
                  icon: const Icon(Icons.open_in_new_rounded, size: 18),
                  label: const Text('فتح'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
