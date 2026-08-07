import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ---------------------------------------------------------------------------
// Shared CustomPainter — draws a stylised flower using bezier curves
// ---------------------------------------------------------------------------

class _FlowerPainter extends CustomPainter {
  const _FlowerPainter({
    required this.petalColor,
    required this.leafColor,
    required this.centerColor,
    required this.petals,
    required this.rotation,
  });

  final Color petalColor;
  final Color leafColor;
  final Color centerColor;
  final int petals;
  final double rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = math.min(cx, cy);

    final petalPaint = Paint()
      ..color = petalColor
      ..style = PaintingStyle.fill;

    final leafPaint = Paint()
      ..color = leafColor
      ..style = PaintingStyle.fill;

    final centerPaint = Paint()
      ..color = centerColor
      ..style = PaintingStyle.fill;

    // --- petals ---
    final petalLength = radius * 0.72;
    final petalWidth = radius * 0.28;

    for (int i = 0; i < petals; i++) {
      final angle = rotation + (i * 2 * math.pi / petals);
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(angle);

      final path = Path();
      path.moveTo(0, 0);
      path.cubicTo(
        -petalWidth, -petalLength * 0.3,
        -petalWidth * 0.6, -petalLength * 0.7,
        0, -petalLength,
      );
      path.cubicTo(
        petalWidth * 0.6, -petalLength * 0.7,
        petalWidth, -petalLength * 0.3,
        0, 0,
      );
      canvas.drawPath(path, petalPaint);
      canvas.restore();
    }

    // --- leaves (4 diagonal positions) ---
    final leafLength = radius * 0.45;
    final leafWidth = radius * 0.14;
    final leafAngles = [
      math.pi * 0.25,
      math.pi * 0.75,
      math.pi * 1.25,
      math.pi * 1.75,
    ];

    for (final angle in leafAngles) {
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(angle);

      final lx = radius * 0.38;
      final path = Path();
      path.moveTo(lx, 0);
      path.quadraticBezierTo(
        lx + leafWidth, -leafLength * 0.5,
        lx, -leafLength,
      );
      path.quadraticBezierTo(
        lx - leafWidth, -leafLength * 0.5,
        lx, 0,
      );
      canvas.drawPath(path, leafPaint);
      canvas.restore();
    }

    // --- center circle ---
    canvas.drawCircle(
      Offset(cx, cy),
      radius * 0.18,
      centerPaint,
    );
    // subtle highlight on center (white, intentional brand-neutral accent)
    canvas.drawCircle(
      Offset(cx - radius * 0.05, cy - radius * 0.05),
      radius * 0.06,
      Paint()..color = Colors.white.withValues(alpha: 0.55),
    );
  }

  @override
  bool shouldRepaint(_FlowerPainter oldDelegate) =>
      oldDelegate.petalColor != petalColor ||
      oldDelegate.petals != petals ||
      oldDelegate.rotation != rotation;
}

// ---------------------------------------------------------------------------
// Compass-ring painter for JourneyIllustration
// ---------------------------------------------------------------------------

class _CompassRingPainter extends CustomPainter {
  const _CompassRingPainter({required this.dotColor});

  final Color dotColor;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(cx, cy) * 0.86;
    final dotRadius = math.min(cx, cy) * 0.045;

    final paint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    // Cardinal points: N, E, S, W
    final angles = [
      -math.pi / 2, // N (top)
      0.0,          // E (right)
      math.pi / 2,  // S (bottom)
      math.pi,      // W (left)
    ];

    for (final angle in angles) {
      canvas.drawCircle(
        Offset(cx + r * math.cos(angle), cy + r * math.sin(angle)),
        dotRadius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_CompassRingPainter oldDelegate) =>
      oldDelegate.dotColor != dotColor;
}

// ---------------------------------------------------------------------------
// Helper: floating decorative dot
// ---------------------------------------------------------------------------

Widget _floatingDot({
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
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
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

// ---------------------------------------------------------------------------
// GardenIllustration — Page 0
// ---------------------------------------------------------------------------

class GardenIllustration extends StatelessWidget {
  const GardenIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size.shortestSide * 0.58;

    return Center(
      child: SizedBox(
        width: size / 0.58,
        height: size / 0.58,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer ring border
            Container(
              width: size / 0.58,
              height: size / 0.58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.primaryContainer,
                border: Border.all(
                  color: cs.primary.withValues(alpha: 0.15),
                  width: 2,
                ),
              ),
            ),
            // Inner glow
            Container(
              width: size / 0.58 * 0.75,
              height: size / 0.58 * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.primary.withValues(alpha: 0.08),
              ),
            ),
            // Flower
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: _FlowerPainter(
                  petalColor: cs.primary,
                  leafColor: cs.primaryContainer.withValues(alpha: 0.9),
                  centerColor: cs.primary.withValues(alpha: 0.85),
                  petals: 6,
                  rotation: 0,
                ),
              ),
            )
                .animate()
                .scale(
                  begin: const Offset(0.3, 0.3),
                  end: const Offset(1, 1),
                  duration: 700.ms,
                  curve: Curves.easeOutBack,
                )
                .rotate(begin: -0.1, end: 0, duration: 700.ms),

            // Floating dots
            _floatingDot(
              color: cs.primary.withValues(alpha: 0.5),
              size: 10,
              alignment: const Alignment(-0.75, -0.65),
              delay: 200.ms,
            ),
            _floatingDot(
              color: cs.primary.withValues(alpha: 0.35),
              size: 7,
              alignment: const Alignment(0.78, -0.6),
              delay: 300.ms,
            ),
            _floatingDot(
              color: cs.primaryContainer,
              size: 12,
              alignment: const Alignment(0.7, 0.72),
              delay: 400.ms,
            ),
            _floatingDot(
              color: cs.primary.withValues(alpha: 0.4),
              size: 8,
              alignment: const Alignment(-0.8, 0.68),
              delay: 350.ms,
            ),
            _floatingDot(
              color: cs.primary.withValues(alpha: 0.25),
              size: 6,
              alignment: const Alignment(0.1, -0.85),
              delay: 450.ms,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// HallIllustration — Page 1
// ---------------------------------------------------------------------------

class HallIllustration extends StatelessWidget {
  const HallIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final containerSize = MediaQuery.of(context).size.shortestSide * 0.58 / 0.58;
    final outerFlowerSize = containerSize * 0.58;
    final innerFlowerSize = containerSize * 0.45;

    return Center(
      child: SizedBox(
        width: containerSize,
        height: containerSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer ring border
            Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.secondaryContainer,
                border: Border.all(
                  color: cs.secondary.withValues(alpha: 0.15),
                  width: 2,
                ),
              ),
            ),
            // Inner glow
            Container(
              width: containerSize * 0.75,
              height: containerSize * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.secondary.withValues(alpha: 0.08),
              ),
            ),
            // Outer flower — 8 petals
            SizedBox(
              width: outerFlowerSize,
              height: outerFlowerSize,
              child: CustomPaint(
                painter: _FlowerPainter(
                  petalColor: cs.secondary,
                  leafColor: cs.secondaryContainer.withValues(alpha: 0.9),
                  centerColor: cs.secondary.withValues(alpha: 0.85),
                  petals: 8,
                  rotation: 0,
                ),
              ),
            )
                .animate()
                .scale(
                  begin: const Offset(0.3, 0.3),
                  end: const Offset(1, 1),
                  duration: 700.ms,
                  curve: Curves.easeOutBack,
                )
                .rotate(begin: -0.08, end: 0, duration: 700.ms),

            // Inner flower — 8 petals at PI/8 offset (creates 16-ray star)
            SizedBox(
              width: innerFlowerSize,
              height: innerFlowerSize,
              child: CustomPaint(
                painter: _FlowerPainter(
                  petalColor: cs.secondary.withValues(alpha: 0.55),
                  leafColor: cs.secondaryContainer,
                  centerColor: cs.secondary,
                  petals: 8,
                  rotation: math.pi / 8,
                ),
              ),
            )
                .animate()
                .scale(
                  begin: const Offset(0.2, 0.2),
                  end: const Offset(1, 1),
                  duration: 750.ms,
                  curve: Curves.easeOutBack,
                )
                .rotate(begin: 0.1, end: 0, duration: 750.ms),

            // Floating dots
            _floatingDot(
              color: cs.secondary.withValues(alpha: 0.5),
              size: 10,
              alignment: const Alignment(-0.75, -0.65),
              delay: 200.ms,
            ),
            _floatingDot(
              color: cs.secondary.withValues(alpha: 0.35),
              size: 7,
              alignment: const Alignment(0.78, -0.6),
              delay: 300.ms,
            ),
            _floatingDot(
              color: cs.secondaryContainer,
              size: 12,
              alignment: const Alignment(0.7, 0.72),
              delay: 400.ms,
            ),
            _floatingDot(
              color: cs.secondary.withValues(alpha: 0.4),
              size: 8,
              alignment: const Alignment(-0.8, 0.68),
              delay: 350.ms,
            ),
            _floatingDot(
              color: cs.secondary.withValues(alpha: 0.25),
              size: 6,
              alignment: const Alignment(0.1, -0.85),
              delay: 450.ms,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// JourneyIllustration — Page 2
// ---------------------------------------------------------------------------

class JourneyIllustration extends StatelessWidget {
  const JourneyIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final containerSize = MediaQuery.of(context).size.shortestSide * 0.58 / 0.58;
    final flowerSize = containerSize * 0.58;

    return Center(
      child: SizedBox(
        width: containerSize,
        height: containerSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer ring border
            Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.tertiaryContainer,
                border: Border.all(
                  color: cs.tertiary.withValues(alpha: 0.15),
                  width: 2,
                ),
              ),
            ),
            // Compass ring dots
            SizedBox(
              width: containerSize,
              height: containerSize,
              child: CustomPaint(
                painter: _CompassRingPainter(
                  dotColor: cs.tertiary.withValues(alpha: 0.45),
                ),
              ),
            ),
            // Inner glow
            Container(
              width: containerSize * 0.75,
              height: containerSize * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.tertiary.withValues(alpha: 0.08),
              ),
            ),
            // Flower — 12 narrow petals (compass-rose look)
            SizedBox(
              width: flowerSize,
              height: flowerSize,
              child: CustomPaint(
                painter: _FlowerPainter(
                  petalColor: cs.tertiary,
                  leafColor: cs.tertiaryContainer.withValues(alpha: 0.9),
                  centerColor: cs.tertiary.withValues(alpha: 0.85),
                  petals: 12,
                  rotation: math.pi / 12,
                ),
              ),
            )
                .animate()
                .scale(
                  begin: const Offset(0.3, 0.3),
                  end: const Offset(1, 1),
                  duration: 700.ms,
                  curve: Curves.easeOutBack,
                )
                .rotate(begin: -0.08, end: 0, duration: 700.ms),

            // Floating dots
            _floatingDot(
              color: cs.tertiary.withValues(alpha: 0.5),
              size: 10,
              alignment: const Alignment(-0.75, -0.65),
              delay: 200.ms,
            ),
            _floatingDot(
              color: cs.tertiary.withValues(alpha: 0.35),
              size: 7,
              alignment: const Alignment(0.78, -0.6),
              delay: 300.ms,
            ),
            _floatingDot(
              color: cs.tertiaryContainer,
              size: 12,
              alignment: const Alignment(0.7, 0.72),
              delay: 400.ms,
            ),
            _floatingDot(
              color: cs.tertiary.withValues(alpha: 0.4),
              size: 8,
              alignment: const Alignment(-0.8, 0.68),
              delay: 350.ms,
            ),
            _floatingDot(
              color: cs.tertiary.withValues(alpha: 0.25),
              size: 6,
              alignment: const Alignment(0.1, -0.85),
              delay: 450.ms,
            ),
          ],
        ),
      ),
    );
  }
}
