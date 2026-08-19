import 'dart:io';
import 'dart:math' as math;
import 'package:image/image.dart' as img;

void main() async {
  final file = File('assets/images/logo.jpg');
  final bytes = await file.readAsBytes();
  final source = img.decodeImage(bytes)!;

  print('Source: ${source.width}x${source.height}');

  // --- Step 1: Find content bounding box (trim whitespace) ---
  int minX = source.width, minY = source.height, maxX = 0, maxY = 0;
  for (int y = 0; y < source.height; y++) {
    for (int x = 0; x < source.width; x++) {
      final pixel = source.getPixel(x, y);
      final r = pixel.r.toInt();
      final g = pixel.g.toInt();
      final b = pixel.b.toInt();
      // Treat very-light pixels as background
      if (!(r > 235 && g > 235 && b > 235)) {
        if (x < minX) minX = x;
        if (y < minY) minY = y;
        if (x > maxX) maxX = x;
        if (y > maxY) maxY = y;
      }
    }
  }

  print('Content bounds: ($minX,$minY) to ($maxX,$maxY)');
  final contentW = maxX - minX + 1;
  final contentH = maxY - minY + 1;

  // Add 10% padding
  final padX = (contentW * 0.12).round();
  final padY = (contentH * 0.12).round();
  final cropX = (minX - padX).clamp(0, source.width - 1);
  final cropY = (minY - padY).clamp(0, source.height - 1);
  final cropW = (contentW + padX * 2).clamp(1, source.width - cropX);
  final cropH = (contentH + padY * 2).clamp(1, source.height - cropY);

  final cropped = img.copyCrop(source, x: cropX, y: cropY, width: cropW, height: cropH);

  // --- Step 2: Make square ---
  final side = math.max(cropped.width, cropped.height);
  final squareSrc = img.Image(width: side, height: side);
  img.fill(squareSrc, color: img.ColorRgba8(255, 255, 255, 255));
  final oX = (side - cropped.width) ~/ 2;
  final oY = (side - cropped.height) ~/ 2;
  img.compositeImage(squareSrc, cropped, dstX: oX, dstY: oY);

  // --- Step 3: Replace white/near-white pixels with target bg color ---
  // Background color: #1B7FC4
  const bgR = 0x1B, bgG = 0x7F, bgC = 0xC4;

  // Scale to 1024 first
  final iconSz = 1024;
  final scaled = img.copyResize(squareSrc, width: iconSz, height: iconSz, interpolation: img.Interpolation.cubic);

  // For each pixel, blend white areas into the blue background
  for (int y = 0; y < iconSz; y++) {
    for (int x = 0; x < iconSz; x++) {
      final pixel = scaled.getPixel(x, y);
      final r = pixel.r.toInt();
      final g = pixel.g.toInt();
      final b = pixel.b.toInt();

      // Compute how "white" this pixel is (0=not white, 1=perfectly white)
      final minChannel = math.min(r, math.min(g, b));
      final maxChannel = math.max(r, math.max(g, b));
      // Saturation: 0=gray/white, 1=fully saturated
      final sat = maxChannel > 0 ? (maxChannel - minChannel) / maxChannel : 0.0;
      // Brightness: 0=black, 1=white
      final bri = maxChannel / 255.0;

      // "Whiteness" = high brightness + low saturation
      final whiteness = (bri * (1 - sat * 2)).clamp(0.0, 1.0);

      if (whiteness > 0.78) {
        // Fully replace with background color
        scaled.setPixel(x, y, img.ColorRgba8(bgR, bgG, bgC, 255));
      } else if (whiteness > 0.50) {
        // Smooth blend from original to bg
        final t = ((whiteness - 0.50) / 0.28).clamp(0.0, 1.0);
        final nr = (r + (bgR - r) * t).round().clamp(0, 255);
        final ng = (g + (bgG - g) * t).round().clamp(0, 255);
        final nb = (b + (bgC - b) * t).round().clamp(0, 255);
        scaled.setPixel(x, y, img.ColorRgba8(nr, ng, nb, 255));
      }
      // Otherwise: keep original color (cart itself)
    }
  }

  // --- Step 4: Build final icon = blue background + processed logo ---
  final iconImg = img.Image(width: iconSz, height: iconSz);
  img.fill(iconImg, color: img.ColorRgba8(bgR, bgG, bgC, 255));
  img.compositeImage(iconImg, scaled);

  await File('assets/images/app_icon.png').writeAsBytes(img.encodePng(iconImg));
  print('Wrote app_icon.png');

  // --- Step 5: Adaptive foreground = same result (fg also on blue bg) ---
  // For adaptive icons the fg is placed on a separate layer; we embed the bg
  // in the fg so it shows the cart on blue in any adaptive-icon shape.
  final fgImg = img.copyResize(iconImg, width: iconSz, height: iconSz);
  await File('assets/images/app_icon_fg.png').writeAsBytes(img.encodePng(fgImg));
  print('Wrote app_icon_fg.png');
}
