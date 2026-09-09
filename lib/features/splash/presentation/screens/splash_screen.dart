import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// Fully-animated Flutter splash screen.
///
/// Background gradient is derived from [ColorScheme.primary] so the screen
/// automatically adopts the shop's live brand colour (identity or app-default).
/// After the animation sequence (≈2.2 s) + a 400 ms hold, navigates to `/`
/// and lets the GoRouter redirect handle auth routing.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ── Controllers ────────────────────────────────────────────────────────────
  late final AnimationController _seq; // main 2 200 ms sequence
  late final AnimationController _pulse; // repeating sonar ring
  late final AnimationController _dots; // repeating loading dots

  // ── Sequence animations ─────────────────────────────────────────────────────
  late final Animation<double> _glowFade;
  late final Animation<double> _glowSize;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoSize;
  late final Animation<double> _tagFade; // 0 → 0.72
  late final Animation<double> _dotsFade; // 0 → 0.65

  // ── Pulse animations ────────────────────────────────────────────────────────
  late final Animation<double> _ringFade; // 0.38 → 0
  late final Animation<double> _ringSize; // 1.00 → 1.44

  @override
  void initState() {
    super.initState();

    // ── Main sequence (2 200 ms) ──────────────────────────────────────────────
    _seq = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    Animation<double> interval(double t0, double t1, Curve c) =>
        CurvedAnimation(
          parent: _seq,
          curve: Interval(t0, t1, curve: c),
        );

    // Glow halo: 0–484 ms (0.00–0.22)
    _glowFade = interval(0.00, 0.22, Curves.easeOut);
    _glowSize = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(interval(0.00, 0.22, Curves.easeOut));

    // Flower logo: 154–836 ms (0.07–0.38)
    _logoFade = interval(0.07, 0.38, Curves.easeOut);
    _logoSize = Tween<double>(
      begin: 0.68,
      end: 1.00,
    ).animate(interval(0.07, 0.38, Curves.easeOutBack));

    // Tagline: 1 100–1 540 ms (0.50–0.70)
    _tagFade = Tween<double>(
      begin: 0.0,
      end: 0.72,
    ).animate(interval(0.50, 0.70, Curves.easeOut));

    // Dots: 1 100–1 496 ms (0.50–0.68)
    _dotsFade = Tween<double>(
      begin: 0.0,
      end: 0.65,
    ).animate(interval(0.50, 0.68, Curves.easeOut));

    // ── Pulse ring (starts at 850 ms, repeats every 1 800 ms) ─────────────────
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _ringFade = Tween<double>(
      begin: 0.38,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeOut));
    _ringSize = Tween<double>(
      begin: 1.00,
      end: 1.44,
    ).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeOut));

    // ── Dots (repeating) ──────────────────────────────────────────────────────
    _dots = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();

    // Start sequence
    _seq.forward();

    // Kick off the sonar ring after the logo finishes appearing
    Future.delayed(const Duration(milliseconds: 850), () {
      if (mounted) _pulse.repeat();
    });

    // Navigate when sequence completes
    _seq.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) context.go('/');
        });
      }
    });
  }

  @override
  void dispose() {
    _seq.dispose();
    _pulse.dispose();
    _dots.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final fg = cs.onPrimary;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: Stack(
        children: [
          // Full-screen background — gradient + subtle decorative bubbles.
          const Positioned.fill(child: _SplashBackground()),

          // Single centered composition: logo and text are ONE visual unit.
          // Shifted 12 % above mathematical center for optical balance.
          Align(
            alignment: const Alignment(0, -0.12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLogoArea(fg),
                const SizedBox(height: 28),
                _buildText(textTheme, fg),
              ],
            ),
          ),

          // Loading dots pinned to the safe-area bottom edge.
          Positioned(
            bottom: bottomInset + 44,
            left: 0,
            right: 0,
            child: Center(child: _buildDots(fg)),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoArea(Color fg) {
    return AnimatedBuilder(
      animation: Listenable.merge([_seq, _pulse]),
      builder: (_, __) => SizedBox(
        width: 210,
        height: 210,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer radial glow
            Opacity(
              opacity: _glowFade.value,
              child: Transform.scale(
                scale: _glowSize.value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        fg.withValues(alpha: 0.13),
                        fg.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Sonar / pulse ring
            Opacity(
              opacity: _ringFade.value,
              child: Transform.scale(
                scale: _ringSize.value,
                child: Container(
                  width: 152,
                  height: 152,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: fg.withValues(alpha: 0.55),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            // Flower SVG
            Opacity(
              opacity: _logoFade.value,
              child: Transform.scale(
                scale: _logoSize.value,
                child: SvgPicture.asset(
                  'assets/images/flower_logo.svg',
                  width: 144,
                  height: 144,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(TextTheme textTheme, Color fg) {
    return AnimatedBuilder(
      animation: _seq,
      builder: (_, __) => Opacity(
        opacity: _tagFade.value,
        child: Text(
          'منصة إدارة متجرك الإلكتروني',
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(
            color: fg.withValues(alpha: 0.72),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildDots(Color fg) {
    return AnimatedBuilder(
      animation: Listenable.merge([_seq, _dots]),
      builder: (_, __) => Opacity(
        opacity: _dotsFade.value,
        child: _LoadingDots(progress: _dots.value, color: fg),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Background
// ─────────────────────────────────────────────────────────────────────────────

// Pure full-screen background — no child, no layout responsibility.
class _SplashBackground extends StatelessWidget {
  const _SplashBackground();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final primary = cs.primary;
    // Darken the primary 45 % toward black for the gradient's far corner.
    final dark = Color.lerp(primary, Colors.black, 0.45)!;
    final fg = cs.onPrimary;
    final screenH = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        // Gradient covers the entire screen.
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primary, dark],
            ),
          ),
        ),
        // Subtle decorative bubbles — overflow intentionally outside the frame.
        _bubble(right: -70, top: -70, size: 230, color: fg, alpha: 0.052),
        _bubble(left: -55, bottom: -95, size: 265, color: fg, alpha: 0.042),
        _bubble(
          left: -30,
          top: screenH * 0.26,
          size: 130,
          color: fg,
          alpha: 0.032,
        ),
      ],
    );
  }

  Widget _bubble({
    double? left,
    double? right,
    double? top,
    double? bottom,
    required double size,
    required Color color,
    required double alpha,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: alpha),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Loading dots indicator
// ─────────────────────────────────────────────────────────────────────────────

class _LoadingDots extends StatelessWidget {
  const _LoadingDots({required this.progress, required this.color});

  final double progress; // 0.0 – 1.0, repeating
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        // Each dot peaks at a different phase so they appear sequential.
        final phase = i / 3.0;
        final t = ((progress - phase + 1.0) % 1.0);
        final wave = math.sin(t * math.pi);
        final size = 6.0 + wave * 3.5;
        final opacity = 0.28 + 0.62 * wave;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: opacity),
            ),
          ),
        );
      }),
    );
  }
}
