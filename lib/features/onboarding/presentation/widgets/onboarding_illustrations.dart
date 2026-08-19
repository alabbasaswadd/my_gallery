import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ============================================================================
// Shared helper — a small floating accent dot with an entrance animation
// ============================================================================

Widget _dot({
  required Color color,
  required double size,
  required Alignment alignment,
  required Duration delay,
}) {
  return Align(
    alignment: alignment,
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    )
        .animate(delay: delay)
        .fadeIn(duration: 500.ms)
        .scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          duration: 500.ms,
          curve: Curves.easeOutBack,
        ),
  );
}

// ============================================================================
// ILLUSTRATION 0 — CatalogIllustration
// "Add your products easily"
// Scene: smartphone showing a product catalog with cards + FAB
// ============================================================================

class _PhoneCatalogPainter extends CustomPainter {
  const _PhoneCatalogPainter({required this.cs});
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(cx, cy);

    final phoneW = r * 0.92;
    final phoneH = r * 1.58;
    final phoneRadius = r * 0.155;

    // ── Phone shadow ────────────────────────────────────────────────────────
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx + r * 0.025, cy + r * 0.04), width: phoneW, height: phoneH),
        Radius.circular(phoneRadius),
      ),
      Paint()
        ..color = cs.primary.withValues(alpha: 0.13)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.07),
    );

    // ── Phone body ───────────────────────────────────────────────────────────
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy), width: phoneW, height: phoneH),
        Radius.circular(phoneRadius),
      ),
      Paint()..color = cs.surfaceContainerLowest,
    );

    // Phone border
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy), width: phoneW, height: phoneH),
        Radius.circular(phoneRadius),
      ),
      Paint()
        ..color = cs.primary.withValues(alpha: 0.22)
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.020,
    );

    // ── Camera notch ─────────────────────────────────────────────────────────
    canvas.drawCircle(
      Offset(cx, cy - phoneH / 2 + r * 0.063),
      r * 0.021,
      Paint()..color = cs.outline.withValues(alpha: 0.35),
    );

    // ── Screen area ──────────────────────────────────────────────────────────
    final scPadX = r * 0.058;
    final scTop = cy - phoneH / 2 + r * 0.115;
    final scBot = cy + phoneH / 2 - r * 0.095;
    final scLeft = cx - phoneW / 2 + scPadX;
    final scRight = cx + phoneW / 2 - scPadX;
    final scW = scRight - scLeft;
    final scH = scBot - scTop;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(scLeft, scTop, scW, scH),
        Radius.circular(r * 0.075),
      ),
      Paint()..color = cs.surface,
    );

    // ── App-bar inside screen ─────────────────────────────────────────────────
    final abH = r * 0.110;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(scLeft, scTop, scW, abH),
        Radius.circular(r * 0.075),
      ),
      Paint()..color = cs.primaryContainer.withValues(alpha: 0.70),
    );
    // App-bar title line
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(scLeft + scW * 0.28, scTop + abH * 0.30, scW * 0.44, r * 0.040),
        Radius.circular(r * 0.020),
      ),
      Paint()..color = cs.primary.withValues(alpha: 0.45),
    );
    // Search icon dot
    canvas.drawCircle(
      Offset(scRight - r * 0.055, scTop + abH * 0.50),
      r * 0.024,
      Paint()..color = cs.primary.withValues(alpha: 0.40),
    );

    // ── Product cards ─────────────────────────────────────────────────────────
    final cardGap = r * 0.030;
    final cardPad = r * 0.032;
    final imgSz = r * 0.196;
    final cardH = imgSz + cardPad * 2;
    final cardW = scW - cardPad * 2;
    final firstCardY = scTop + abH + r * 0.028;

    for (int i = 0; i < 3; i++) {
      final cardY = firstCardY + (cardH + cardGap) * i;
      if (cardY + cardH > scBot - r * 0.08) break;
      final cardX = scLeft + cardPad;

      // Card background
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(cardX, cardY, cardW, cardH),
          Radius.circular(r * 0.065),
        ),
        Paint()..color = cs.surfaceContainerLow,
      );

      // Product image thumbnail
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(cardX + cardPad, cardY + cardPad, imgSz, imgSz),
          Radius.circular(r * 0.045),
        ),
        Paint()..color = cs.primaryContainer.withValues(alpha: i == 0 ? 1.0 : 0.70),
      );

      // Tiny diamond product icon inside thumbnail
      final tc = Offset(cardX + cardPad + imgSz / 2, cardY + cardPad + imgSz / 2);
      final dPath = Path()
        ..moveTo(tc.dx, tc.dy - imgSz * 0.24)
        ..lineTo(tc.dx + imgSz * 0.20, tc.dy)
        ..lineTo(tc.dx, tc.dy + imgSz * 0.24)
        ..lineTo(tc.dx - imgSz * 0.20, tc.dy)
        ..close();
      canvas.drawPath(
        dPath,
        Paint()..color = cs.primary.withValues(alpha: 0.45),
      );

      // Text content
      final tX = cardX + cardPad + imgSz + r * 0.045;
      final tW = cardW - imgSz - cardPad * 2 - r * 0.045;

      // Title line (full width)
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(tX, cardY + r * 0.040, tW * 0.82, r * 0.038),
          Radius.circular(r * 0.019),
        ),
        Paint()..color = cs.onSurface.withValues(alpha: 0.50),
      );
      // Subtitle line
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(tX, cardY + r * 0.040 + r * 0.055, tW * 0.58, r * 0.030),
          Radius.circular(r * 0.015),
        ),
        Paint()..color = cs.onSurface.withValues(alpha: 0.28),
      );

      // Star rating (4 micro-dots)
      final starY = cardY + r * 0.040 + r * 0.055 + r * 0.062;
      for (int s = 0; s < 4; s++) {
        canvas.drawCircle(
          Offset(tX + s * r * 0.044, starY),
          r * 0.012,
          Paint()..color = cs.primary.withValues(alpha: s < 3 ? 0.72 : 0.28),
        );
      }

      // Price tag chip
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(tX, cardY + cardH - r * 0.072, tW * 0.52, r * 0.048),
          Radius.circular(r * 0.024),
        ),
        Paint()..color = cs.primary.withValues(alpha: 0.18),
      );
    }

    // ── Floating FAB (+) ──────────────────────────────────────────────────────
    final fabX = scRight - r * 0.115;
    final fabY = scBot - r * 0.105;
    canvas.drawCircle(Offset(fabX, fabY), r * 0.108, Paint()..color = cs.primary);
    // Plus symbol
    final plusPaint = Paint()
      ..color = cs.onPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.022
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(fabX - r * 0.046, fabY), Offset(fabX + r * 0.046, fabY), plusPaint);
    canvas.drawLine(Offset(fabX, fabY - r * 0.046), Offset(fabX, fabY + r * 0.046), plusPaint);

    // ── Home indicator ────────────────────────────────────────────────────────
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy + phoneH / 2 - r * 0.052), width: r * 0.24, height: r * 0.018),
        Radius.circular(r * 0.009),
      ),
      Paint()..color = cs.outline.withValues(alpha: 0.30),
    );
  }

  @override
  bool shouldRepaint(_PhoneCatalogPainter old) => old.cs != cs;
}

class CatalogIllustration extends StatelessWidget {
  const CatalogIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ss = MediaQuery.of(context).size.shortestSide;
    final outer = ss * 1.0;
    final inner = ss * 0.58;

    return Center(
      child: SizedBox(
        width: outer,
        height: outer,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow ring
            Container(
              width: outer,
              height: outer,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.primaryContainer.withValues(alpha: 0.55),
                border: Border.all(color: cs.primary.withValues(alpha: 0.12), width: 2),
              ),
            ),
            // Inner glow
            Container(
              width: outer * 0.72,
              height: outer * 0.72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.primary.withValues(alpha: 0.06),
              ),
            ),
            // Phone illustration
            SizedBox(
              width: inner,
              height: inner,
              child: CustomPaint(painter: _PhoneCatalogPainter(cs: cs)),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.62, 0.62), end: const Offset(1, 1), duration: 650.ms, curve: Curves.easeOutBack),

            // Floating accent dots
            _dot(color: cs.primary.withValues(alpha: 0.55), size: 11, alignment: const Alignment(-0.74, -0.64), delay: 200.ms),
            _dot(color: cs.primary.withValues(alpha: 0.35), size: 7, alignment: const Alignment(0.80, -0.58), delay: 310.ms),
            _dot(color: cs.primaryContainer, size: 13, alignment: const Alignment(0.68, 0.74), delay: 420.ms),
            _dot(color: cs.primary.withValues(alpha: 0.42), size: 8, alignment: const Alignment(-0.82, 0.70), delay: 360.ms),
            _dot(color: cs.primary.withValues(alpha: 0.22), size: 6, alignment: const Alignment(0.12, -0.84), delay: 480.ms),

            // Floating tag badge (top-right of phone area)
            Align(
              alignment: const Alignment(0.62, -0.52),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: cs.primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: cs.primary.withValues(alpha: 0.35), blurRadius: 8, offset: const Offset(0, 3))],
                ),
                child: Icon(Icons.shopping_bag_outlined, color: cs.onPrimary, size: 16),
              )
                  .animate(delay: 550.ms)
                  .fadeIn(duration: 400.ms)
                  .scale(begin: const Offset(0, 0), end: const Offset(1, 1), duration: 400.ms, curve: Curves.easeOutBack),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// ILLUSTRATION 1 — StoreIllustration
// "Customize your store's identity"
// Scene: branding palette — store sign, color swatches, font preview, wand
// ============================================================================

class _BrandingPainter extends CustomPainter {
  const _BrandingPainter({required this.cs});
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(cx, cy);

    // ── Store sign / banner ────────────────────────────────────────────────
    final banW = r * 1.38;
    final banH = r * 0.58;
    final banX = cx - banW / 2;
    final banY = cy - r * 0.64;

    // Banner shadow
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(banX + r * 0.025, banY + r * 0.030, banW, banH),
        Radius.circular(r * 0.085),
      ),
      Paint()
        ..color = cs.secondary.withValues(alpha: 0.15)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.06),
    );

    // Banner body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(banX, banY, banW, banH),
        Radius.circular(r * 0.085),
      ),
      Paint()..color = cs.secondaryContainer,
    );

    // Banner border
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(banX, banY, banW, banH),
        Radius.circular(r * 0.085),
      ),
      Paint()
        ..color = cs.secondary.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.018,
    );

    // Logo placeholder circle
    final lgCx = banX + r * 0.22;
    final lgCy = banY + banH / 2;
    canvas.drawCircle(Offset(lgCx, lgCy), r * 0.17, Paint()..color = cs.secondary.withValues(alpha: 0.30));
    canvas.drawCircle(Offset(lgCx, lgCy), r * 0.17,
        Paint()..color = cs.secondary.withValues(alpha: 0.45)..style = PaintingStyle.stroke..strokeWidth = r * 0.016);
    // Logo star/sparkle in circle
    _drawStar(canvas, Offset(lgCx, lgCy), r * 0.09, cs.secondary.withValues(alpha: 0.70));

    // Store name lines
    final nmX = banX + r * 0.46;
    final nmW = banW - r * 0.52;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(nmX, banY + banH * 0.26, nmW * 0.78, r * 0.055), Radius.circular(r * 0.028)),
      Paint()..color = cs.onSecondaryContainer.withValues(alpha: 0.55),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(nmX, banY + banH * 0.26 + r * 0.080, nmW * 0.48, r * 0.038), Radius.circular(r * 0.019)),
      Paint()..color = cs.onSecondaryContainer.withValues(alpha: 0.30),
    );

    // Verified badge
    canvas.drawCircle(
      Offset(banX + banW - r * 0.115, banY + r * 0.115),
      r * 0.068,
      Paint()..color = cs.secondary,
    );
    // Checkmark in badge
    final badgePaint = Paint()
      ..color = cs.onSecondary
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.018
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final bCx = banX + banW - r * 0.115;
    final bCy = banY + r * 0.115;
    canvas.drawPath(
      Path()
        ..moveTo(bCx - r * 0.030, bCy + r * 0.005)
        ..lineTo(bCx - r * 0.006, bCy + r * 0.028)
        ..lineTo(bCx + r * 0.036, bCy - r * 0.022),
      badgePaint,
    );

    // ── Color palette row ──────────────────────────────────────────────────
    final palY = cy - r * 0.00;
    final colors = [
      cs.primary,
      cs.secondary,
      cs.tertiary,
      cs.error,
      cs.primary.withValues(alpha: 0.45),
    ];
    final swatchR = r * 0.092;
    final totalW = colors.length * (swatchR * 2 + r * 0.045) - r * 0.045;
    var swX = cx - totalW / 2 + swatchR;

    for (int i = 0; i < colors.length; i++) {
      // Swatch circle
      canvas.drawCircle(Offset(swX, palY), swatchR, Paint()..color = colors[i]);
      // Check on first (active) swatch
      if (i == 0) {
        canvas.drawCircle(Offset(swX, palY), swatchR,
            Paint()..color = Colors.white.withValues(alpha: 0.50)..style = PaintingStyle.stroke..strokeWidth = r * 0.020);
        canvas.drawPath(
          Path()
            ..moveTo(swX - swatchR * 0.34, palY + swatchR * 0.04)
            ..lineTo(swX - swatchR * 0.06, palY + swatchR * 0.30)
            ..lineTo(swX + swatchR * 0.38, palY - swatchR * 0.28),
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = r * 0.020
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round,
        );
      }
      swX += swatchR * 2 + r * 0.045;
    }

    // Palette label line
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, palY + swatchR + r * 0.065), width: r * 0.60, height: r * 0.032),
        Radius.circular(r * 0.016),
      ),
      Paint()..color = cs.onSurface.withValues(alpha: 0.22),
    );

    // ── Font / design panel ───────────────────────────────────────────────
    final panW = r * 1.38;
    final panH = r * 0.42;
    final panX = cx - panW / 2;
    final panY = cy + r * 0.44;

    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(panX, panY, panW, panH), Radius.circular(r * 0.075)),
      Paint()..color = cs.surfaceContainerLow,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(panX, panY, panW, panH), Radius.circular(r * 0.075)),
      Paint()
        ..color = cs.secondary.withValues(alpha: 0.18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.016,
    );

    // Large font "Aa" indicator
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(panX + r * 0.10, panY + r * 0.09, r * 0.24, r * 0.12),
        Radius.circular(r * 0.030),
      ),
      Paint()..color = cs.secondary.withValues(alpha: 0.18),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(panX + r * 0.10, panY + r * 0.24, r * 0.24, r * 0.08),
        Radius.circular(r * 0.020),
      ),
      Paint()..color = cs.secondary.withValues(alpha: 0.12),
    );

    // Font style lines (right)
    for (int k = 0; k < 3; k++) {
      final lw = panW * [0.48, 0.38, 0.28][k];
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(panX + r * 0.44, panY + r * 0.075 + k * r * 0.108, lw, r * 0.036),
          Radius.circular(r * 0.018),
        ),
        Paint()..color = cs.onSurface.withValues(alpha: [0.42, 0.28, 0.18][k]),
      );
    }

    // Corner edit badge
    canvas.drawCircle(
      Offset(panX + panW - r * 0.095, panY + r * 0.095),
      r * 0.065,
      Paint()..color = cs.secondary,
    );
    _drawPencil(canvas, Offset(panX + panW - r * 0.095, panY + r * 0.095), r * 0.036, cs.onSecondary);
  }

  void _drawStar(Canvas canvas, Offset center, double r, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.22
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 4; i++) {
      final angle = i * math.pi / 4;
      canvas.drawLine(
        center + Offset(math.cos(angle) * r * 0.30, math.sin(angle) * r * 0.30),
        center + Offset(math.cos(angle) * r, math.sin(angle) * r),
        paint,
      );
    }
  }

  void _drawPencil(Canvas canvas, Offset center, double r, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.28
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(
      Path()
        ..moveTo(center.dx - r * 0.20, center.dy + r * 0.50)
        ..lineTo(center.dx + r * 0.50, center.dy - r * 0.30)
        ..lineTo(center.dx + r * 0.20, center.dy - r * 0.60)
        ..lineTo(center.dx - r * 0.50, center.dy + r * 0.20)
        ..close(),
      paint,
    );
  }

  @override
  bool shouldRepaint(_BrandingPainter old) => old.cs != cs;
}

class StoreIllustration extends StatelessWidget {
  const StoreIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ss = MediaQuery.of(context).size.shortestSide;
    final outer = ss * 1.0;
    final inner = ss * 0.58;

    return Center(
      child: SizedBox(
        width: outer,
        height: outer,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: outer,
              height: outer,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.secondaryContainer.withValues(alpha: 0.55),
                border: Border.all(color: cs.secondary.withValues(alpha: 0.12), width: 2),
              ),
            ),
            Container(
              width: outer * 0.72,
              height: outer * 0.72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.secondary.withValues(alpha: 0.06),
              ),
            ),
            SizedBox(
              width: inner,
              height: inner,
              child: CustomPaint(painter: _BrandingPainter(cs: cs)),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.62, 0.62), end: const Offset(1, 1), duration: 650.ms, curve: Curves.easeOutBack),

            _dot(color: cs.secondary.withValues(alpha: 0.55), size: 11, alignment: const Alignment(-0.74, -0.64), delay: 200.ms),
            _dot(color: cs.secondary.withValues(alpha: 0.35), size: 7, alignment: const Alignment(0.80, -0.58), delay: 310.ms),
            _dot(color: cs.secondaryContainer, size: 13, alignment: const Alignment(0.68, 0.74), delay: 420.ms),
            _dot(color: cs.secondary.withValues(alpha: 0.42), size: 8, alignment: const Alignment(-0.82, 0.70), delay: 360.ms),
            _dot(color: cs.secondary.withValues(alpha: 0.22), size: 6, alignment: const Alignment(0.12, -0.84), delay: 480.ms),

            // Floating palette badge
            Align(
              alignment: const Alignment(-0.62, -0.52),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: cs.secondary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: cs.secondary.withValues(alpha: 0.35), blurRadius: 8, offset: const Offset(0, 3))],
                ),
                child: Icon(Icons.palette_outlined, color: cs.onSecondary, size: 16),
              )
                  .animate(delay: 550.ms)
                  .fadeIn(duration: 400.ms)
                  .scale(begin: const Offset(0, 0), end: const Offset(1, 1), duration: 400.ms, curve: Curves.easeOutBack),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// ILLUSTRATION 2 — SuccessIllustration
// "Receive your customers' orders"
// Scene: order confirmation receipt + package + notification badge
// ============================================================================

class _OrdersPainter extends CustomPainter {
  const _OrdersPainter({required this.cs});
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(cx, cy);

    // ── Notification bell at top ───────────────────────────────────────────
    _drawBell(canvas, Offset(cx, cy - r * 0.76), r * 0.175, cs);

    // ── Order receipt card ─────────────────────────────────────────────────
    final cardW = r * 1.36;
    final cardH = r * 1.02;
    final cardX = cx - cardW / 2;
    final cardY = cy - r * 0.52;

    // Card shadow
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cardX + r * 0.024, cardY + r * 0.032, cardW, cardH),
        Radius.circular(r * 0.090),
      ),
      Paint()
        ..color = cs.tertiary.withValues(alpha: 0.12)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.065),
    );

    // Card body
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(cardX, cardY, cardW, cardH), Radius.circular(r * 0.090)),
      Paint()..color = cs.surfaceContainerLowest,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(cardX, cardY, cardW, cardH), Radius.circular(r * 0.090)),
      Paint()
        ..color = cs.tertiary.withValues(alpha: 0.20)
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.016,
    );

    // Card header strip
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(cardX, cardY, cardW, r * 0.18), Radius.circular(r * 0.090)),
      Paint()..color = cs.tertiaryContainer.withValues(alpha: 0.80),
    );
    // Cover bottom edge of header strip
    canvas.drawRect(
      Rect.fromLTWH(cardX, cardY + r * 0.09, cardW, r * 0.09),
      Paint()..color = cs.tertiaryContainer.withValues(alpha: 0.80),
    );
    // "Order Confirmed" lines in header
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(cardX + r * 0.24, cardY + r * 0.050, r * 0.55, r * 0.048), Radius.circular(r * 0.024)),
      Paint()..color = cs.onTertiaryContainer.withValues(alpha: 0.58),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(cardX + r * 0.36, cardY + r * 0.112, r * 0.30, r * 0.034), Radius.circular(r * 0.017)),
      Paint()..color = cs.onTertiaryContainer.withValues(alpha: 0.35),
    );
    // Confirmed check in header
    canvas.drawCircle(Offset(cardX + r * 0.145, cardY + r * 0.090), r * 0.060, Paint()..color = cs.tertiary);
    final chk = Paint()
      ..color = cs.onTertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.018
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final hCx = cardX + r * 0.145, hCy = cardY + r * 0.090;
    canvas.drawPath(
      Path()
        ..moveTo(hCx - r * 0.026, hCy + r * 0.002)
        ..lineTo(hCx - r * 0.006, hCy + r * 0.022)
        ..lineTo(hCx + r * 0.030, hCy - r * 0.018),
      chk,
    );

    // ── Order line items ────────────────────────────────────────────────────
    final itemsY0 = cardY + r * 0.22;
    final itemGap = r * 0.072;

    for (int i = 0; i < 3; i++) {
      final iy = itemsY0 + i * (r * 0.055 + itemGap);
      if (iy + r * 0.055 > cardY + cardH - r * 0.14) break;

      // Product dot
      canvas.drawCircle(
        Offset(cardX + r * 0.115, iy + r * 0.027),
        r * 0.028,
        Paint()..color = cs.tertiary.withValues(alpha: 0.55 - i * 0.08),
      );

      // Item name line
      final lw = [0.60, 0.50, 0.42][i];
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cardX + r * 0.175, iy, cardW * lw, r * 0.040), Radius.circular(r * 0.020)),
        Paint()..color = cs.onSurface.withValues(alpha: 0.42 - i * 0.05),
      );

      // Price on right
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(cardX + cardW - r * 0.290, iy + r * 0.005, r * 0.25, r * 0.036), Radius.circular(r * 0.018)),
        Paint()..color = cs.tertiary.withValues(alpha: 0.28 - i * 0.04),
      );
    }

    // Divider
    final divY = cardY + cardH - r * 0.165;
    canvas.drawLine(
      Offset(cardX + r * 0.095, divY),
      Offset(cardX + cardW - r * 0.095, divY),
      Paint()..color = cs.outline.withValues(alpha: 0.22)..strokeWidth = r * 0.012,
    );

    // Total row
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(cardX + r * 0.115, divY + r * 0.040, r * 0.30, r * 0.044), Radius.circular(r * 0.022)),
      Paint()..color = cs.onSurface.withValues(alpha: 0.38),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(cardX + cardW - r * 0.380, divY + r * 0.040, r * 0.34, r * 0.044), Radius.circular(r * 0.022)),
      Paint()..color = cs.tertiary.withValues(alpha: 0.55),
    );

    // ── Package / delivery box ─────────────────────────────────────────────
    _drawPackage(canvas, Offset(cx + r * 0.46, cy + r * 0.63), r * 0.20, cs);
  }

  void _drawBell(Canvas canvas, Offset center, double r, ColorScheme cs) {
    final bellPaint = Paint()..color = cs.tertiaryContainer;
    final strokePaint = Paint()
      ..color = cs.tertiary.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.14;

    // Bell body (rounded rect + handle)
    final bellPath = Path()
      ..moveTo(center.dx - r * 0.70, center.dy + r * 0.30)
      ..quadraticBezierTo(center.dx - r * 0.72, center.dy - r * 0.20, center.dx - r * 0.40, center.dy - r * 0.60)
      ..quadraticBezierTo(center.dx, center.dy - r * 0.90, center.dx + r * 0.40, center.dy - r * 0.60)
      ..quadraticBezierTo(center.dx + r * 0.72, center.dy - r * 0.20, center.dx + r * 0.70, center.dy + r * 0.30)
      ..close();

    canvas.drawPath(bellPath, bellPaint);
    canvas.drawPath(bellPath, strokePaint);

    // Bell clapper
    canvas.drawCircle(center + Offset(0, r * 0.55), r * 0.18, Paint()..color = cs.tertiary.withValues(alpha: 0.60));
    canvas.drawCircle(center + Offset(0, r * 0.55), r * 0.18,
        Paint()..color = cs.tertiary.withValues(alpha: 0.60)..style = PaintingStyle.stroke..strokeWidth = r * 0.10);

    // Notification dot (top-right)
    canvas.drawCircle(center + Offset(r * 0.55, -r * 0.52), r * 0.22, Paint()..color = cs.error);
    // Number "3" line
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center + Offset(r * 0.55, -r * 0.52), width: r * 0.20, height: r * 0.12),
        Radius.circular(r * 0.06),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.90),
    );
  }

  void _drawPackage(Canvas canvas, Offset center, double r, ColorScheme cs) {
    final boxColor = cs.tertiaryContainer;
    final faceColor = cs.tertiary.withValues(alpha: 0.22);
    final lineColor = cs.tertiary.withValues(alpha: 0.55);

    // Box body (isometric-ish front face)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: r * 1.50, height: r * 1.20),
        Radius.circular(r * 0.12),
      ),
      Paint()..color = boxColor,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: r * 1.50, height: r * 1.20),
        Radius.circular(r * 0.12),
      ),
      Paint()
        ..color = lineColor.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.10,
    );

    // Tape line (horizontal stripe)
    canvas.drawRect(
      Rect.fromCenter(center: Offset(center.dx, center.dy - r * 0.04), width: r * 1.50, height: r * 0.22),
      Paint()..color = cs.tertiary.withValues(alpha: 0.30),
    );
    // Vertical tape line
    canvas.drawRect(
      Rect.fromCenter(center: Offset(center.dx, center.dy - r * 0.04), width: r * 0.22, height: r * 1.20),
      Paint()..color = cs.tertiary.withValues(alpha: 0.18),
    );

    // Inner face (top flap lighter)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(center.dx - r * 0.75, center.dy - r * 0.60, r * 1.50, r * 0.36),
        Radius.circular(r * 0.12),
      ),
      Paint()..color = faceColor,
    );

    // Small check overlay
    canvas.drawCircle(center, r * 0.30, Paint()..color = cs.tertiary);
    final ck = Paint()
      ..color = cs.onTertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.14
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(
      Path()
        ..moveTo(center.dx - r * 0.14, center.dy + r * 0.02)
        ..lineTo(center.dx - r * 0.02, center.dy + r * 0.14)
        ..lineTo(center.dx + r * 0.18, center.dy - r * 0.10),
      ck,
    );
  }

  @override
  bool shouldRepaint(_OrdersPainter old) => old.cs != cs;
}

class SuccessIllustration extends StatelessWidget {
  const SuccessIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ss = MediaQuery.of(context).size.shortestSide;
    final outer = ss * 1.0;
    final inner = ss * 0.60;

    return Center(
      child: SizedBox(
        width: outer,
        height: outer,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: outer,
              height: outer,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.tertiaryContainer.withValues(alpha: 0.55),
                border: Border.all(color: cs.tertiary.withValues(alpha: 0.12), width: 2),
              ),
            ),
            Container(
              width: outer * 0.72,
              height: outer * 0.72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.tertiary.withValues(alpha: 0.06),
              ),
            ),
            SizedBox(
              width: inner,
              height: inner,
              child: CustomPaint(painter: _OrdersPainter(cs: cs)),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.62, 0.62), end: const Offset(1, 1), duration: 650.ms, curve: Curves.easeOutBack),

            _dot(color: cs.tertiary.withValues(alpha: 0.55), size: 11, alignment: const Alignment(-0.74, -0.64), delay: 200.ms),
            _dot(color: cs.tertiary.withValues(alpha: 0.35), size: 7, alignment: const Alignment(0.80, -0.58), delay: 310.ms),
            _dot(color: cs.tertiaryContainer, size: 13, alignment: const Alignment(0.68, 0.74), delay: 420.ms),
            _dot(color: cs.tertiary.withValues(alpha: 0.42), size: 8, alignment: const Alignment(-0.82, 0.70), delay: 360.ms),
            _dot(color: cs.tertiary.withValues(alpha: 0.22), size: 6, alignment: const Alignment(0.12, -0.84), delay: 480.ms),

            // Floating order count badge
            Align(
              alignment: const Alignment(0.65, 0.52),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: cs.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: cs.tertiary.withValues(alpha: 0.35), blurRadius: 8, offset: const Offset(0, 3))],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_shipping_outlined, color: cs.onTertiary, size: 14),
                    const SizedBox(width: 4),
                    Text('+12', style: TextStyle(color: cs.onTertiary, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
                  .animate(delay: 600.ms)
                  .fadeIn(duration: 400.ms)
                  .scale(begin: const Offset(0, 0), end: const Offset(1, 1), duration: 400.ms, curve: Curves.easeOutBack),
            ),
          ],
        ),
      ),
    );
  }
}
