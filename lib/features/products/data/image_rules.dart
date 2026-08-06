import 'dart:io';

import 'package:my_gallery/core/network/api_exception.dart';

const allowedImageExts = {'jpg', 'jpeg', 'png', 'webp', 'gif'};
const maxImageBytes = 5 * 1024 * 1024; // 5 MB

/// Validates every [files] entry against allowed types and size.
/// Throws an [ApiException] with kind=validation on the first failure.
Future<void> assertValidImages(List<File> files) async {
  for (final file in files) {
    final ext = file.path.split('.').last.toLowerCase();
    if (!allowedImageExts.contains(ext)) {
      throw const ApiException(
        kind: ApiErrorKind.validation,
        message: 'نوع الملف غير مدعوم. يُسمح فقط بـ: jpeg، png، webp، gif',
      );
    }
    final size = await file.length();
    if (size > maxImageBytes) {
      throw const ApiException(
        kind: ApiErrorKind.validation,
        message: 'حجم الملف يتجاوز 5 ميجابايت',
      );
    }
  }
}
