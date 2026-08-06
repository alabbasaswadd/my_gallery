import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';

class AppTheme {
  static ThemeData build(StorefrontSettings settings, Brightness brightness) {
    final primary = hexToColor(settings.primaryColor, const Color(0xFFC0446A));
    final secondary = hexToColor(settings.secondaryColor, const Color(0xFF3C2A34));
    final accent = hexToColor(settings.accentColor, const Color(0xFFD4A02A));
    final background = hexToColor(settings.backgroundColor, const Color(0xFFFBF7F4));
    final surface = hexToColor(settings.surfaceColor, const Color(0xFFFFFFFF));
    final textColor = hexToColor(settings.textColor, const Color(0xFF2A2024));
    final radius = settings.borderRadius;
    final isDark = brightness == Brightness.dark;

    final effectiveSurface = isDark ? const Color(0xFF1C1218) : surface;
    final effectiveBackground = isDark ? const Color(0xFF150F12) : background;
    final effectiveText = isDark ? const Color(0xFFEDE0E4) : textColor;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
    ).copyWith(
      primary: primary,
      secondary: secondary,
      tertiary: accent,
      surface: effectiveSurface,
      onSurface: effectiveText,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      error: const Color(0xFFD32F2F),
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: effectiveBackground,
    );

    return base.copyWith(
      textTheme: _buildTextTheme(base.textTheme, settings.fontFamily, effectiveText),
      appBarTheme: AppBarTheme(
        backgroundColor: effectiveSurface,
        foregroundColor: effectiveText,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: _font(
          settings.fontFamily,
          color: effectiveText,
          size: 18,
          weight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: effectiveSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: secondary.withValues(alpha: 0.08)),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          textStyle: _font(settings.fontFamily, size: 16, weight: FontWeight.w600),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          textStyle: _font(settings.fontFamily, size: 16, weight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: _font(settings.fontFamily, size: 14, weight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: effectiveBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: secondary.withValues(alpha: 0.15)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: secondary.withValues(alpha: 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Color(0xFFD32F2F)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: _font(
          settings.fontFamily,
          color: effectiveText.withValues(alpha: 0.4),
          size: 14,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: effectiveBackground,
        selectedColor: primary.withValues(alpha: 0.12),
        labelStyle: _font(settings.fontFamily, size: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(color: secondary.withValues(alpha: 0.12)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: effectiveSurface,
        selectedItemColor: primary,
        unselectedItemColor: const Color(0xFF9E9E9E),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: secondary,
      ),
      dividerTheme: DividerThemeData(
        color: secondary.withValues(alpha: 0.08),
        thickness: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: effectiveSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }

  static TextStyle _font(
    String fontFamily, {
    Color? color,
    double? size,
    FontWeight? weight,
  }) {
    try {
      return GoogleFonts.getFont(
        fontFamily,
        color: color,
        fontSize: size,
        fontWeight: weight,
      );
    } catch (_) {
      return GoogleFonts.tajawal(color: color, fontSize: size, fontWeight: weight);
    }
  }

  static TextTheme _buildTextTheme(
    TextTheme base,
    String fontFamily,
    Color text,
  ) {
    TextTheme fontTheme;
    try {
      fontTheme = GoogleFonts.getTextTheme(fontFamily, base);
    } catch (_) {
      fontTheme = GoogleFonts.tajawalTextTheme(base);
    }
    return fontTheme.copyWith(
      displayLarge:
          fontTheme.displayLarge?.copyWith(color: text, fontWeight: FontWeight.w700),
      displayMedium:
          fontTheme.displayMedium?.copyWith(color: text, fontWeight: FontWeight.w700),
      headlineLarge: fontTheme.headlineLarge
          ?.copyWith(color: text, fontWeight: FontWeight.w700, fontSize: 24),
      headlineMedium: fontTheme.headlineMedium
          ?.copyWith(color: text, fontWeight: FontWeight.w600, fontSize: 20),
      titleLarge: fontTheme.titleLarge
          ?.copyWith(color: text, fontWeight: FontWeight.w600, fontSize: 18),
      titleMedium: fontTheme.titleMedium
          ?.copyWith(color: text, fontWeight: FontWeight.w500, fontSize: 16),
      bodyLarge: fontTheme.bodyLarge?.copyWith(color: text, fontSize: 16),
      bodyMedium: fontTheme.bodyMedium?.copyWith(color: text, fontSize: 14),
      bodySmall: fontTheme.bodySmall
          ?.copyWith(color: text.withValues(alpha: 0.6), fontSize: 12),
      labelLarge: fontTheme.labelLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }
}
