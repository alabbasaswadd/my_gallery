import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:my_gallery/core/components/app_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Central helper for every "share / copy / open / save" interaction so the
/// behaviour (and the Arabic feedback shown to the user) stays consistent across
/// product sharing, QR export and the store links.
///
/// Uses the share_plus 12.x API (`SharePlus.instance.share(ShareParams(...))`)
/// and `gal` for saving PNGs into the device gallery.
class ShareService {
  ShareService._();

  static const String _galAlbum = 'MyGallery';

  /// Copies [text] to the clipboard and confirms with a SnackBar.
  static Future<void> copyText(
    BuildContext context,
    String text, {
    String confirmation = 'تم نسخ الرابط',
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) AppSnackbar.showSuccess(context, confirmation);
  }

  /// Opens the native share sheet with plain [text] (a link, typically).
  static Future<void> shareText(String text, {String? subject}) async {
    await SharePlus.instance.share(ShareParams(text: text, subject: subject));
  }

  /// Opens [url] in an external browser. Returns `false` (and shows an error) on
  /// failure or when [url] is not a valid URI.
  static Future<bool> openUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      if (context.mounted) AppSnackbar.showError(context, 'رابط غير صالح');
      return false;
    }
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      AppSnackbar.showError(context, 'تعذّر فتح الرابط');
    }
    return ok;
  }

  /// Shares raw PNG [bytes] as an image file through the native share sheet.
  ///
  /// Writes to a temporary file first (share_plus shares files, not bytes).
  static Future<void> shareImage(
    Uint8List bytes, {
    required String fileName,
    String? text,
    String? subject,
  }) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'image/png')],
        text: text,
        subject: subject,
      ),
    );
  }

  /// Saves PNG [bytes] into the device photo gallery (album "MyGallery").
  /// Returns `true` on success. Handles the "access denied" case gracefully.
  static Future<bool> saveImageToGallery(
    BuildContext context,
    Uint8List bytes, {
    required String name,
  }) async {
    try {
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final granted = await Gal.requestAccess();
        if (!granted) {
          if (context.mounted) {
            AppSnackbar.showError(context, 'لم يتم منح إذن الوصول إلى المعرض');
          }
          return false;
        }
      }
      await Gal.putImageBytes(bytes, album: _galAlbum, name: name);
      if (context.mounted) AppSnackbar.showSuccess(context, 'تم حفظ الصورة في المعرض');
      return true;
    } on GalException catch (e) {
      if (context.mounted) {
        AppSnackbar.showError(context, 'تعذّر حفظ الصورة: ${e.type.message}');
      }
      return false;
    } catch (_) {
      if (context.mounted) AppSnackbar.showError(context, 'تعذّر حفظ الصورة');
      return false;
    }
  }
}
