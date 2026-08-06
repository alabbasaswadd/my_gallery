import 'package:flutter/material.dart';

/// Semantic color constants that are fixed by design and not derived from the
/// Material 3 color scheme. Use [Theme.of(context).colorScheme] for all
/// theme-driven colors; only reach for [AppColors] for values that have a
/// fixed meaning independent of light/dark mode.
class AppColors {
  AppColors._();

  // ── Order / product status ────────────────────────────────────────────────
  static const Color statusNew = Color(0xFFD4A02A);       // amber – matches accent
  static const Color statusReviewed = Color(0xFFC0446A);  // rose  – matches primary
  static const Color statusConfirmed = Color(0xFF1565C0); // blue
  static const Color statusCompleted = Color(0xFF2E7D32); // green
  static const Color statusActive = Color(0xFF2E7D32);    // green – product active
  static const Color statusCancelled = Color(0xFFBA1A1A); // error red (M3 light)

  // ── Brand / external ──────────────────────────────────────────────────────
  static const Color whatsApp = Color(0xFF25D366); // WhatsApp brand green

  // ── Overlays / scrims ────────────────────────────────────────────────────
  static const Color imageScrim = Color(0x73000000); // ~45 % black over images
}
