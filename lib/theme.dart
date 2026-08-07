import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';

/// Which palette drives the live app theme.
/// - [identity]   → the shop's [StorefrontSettings] colors (default).
/// - [appDefault] → the built-in attractive [kDefaultPalette]; identity color
///   edits still save for the storefront but no longer restyle the app.
enum ThemeSource { identity, appDefault }

/// The theme-relevant slice of an identity: the 6 role colors, corner radius,
/// and font family. Rendering reads from here rather than raw settings.
class ThemePalette {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color text;
  final double radius;
  final String fontFamily;

  const ThemePalette({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.text,
    required this.radius,
    required this.fontFamily,
  });

  factory ThemePalette.fromSettings(StorefrontSettings s) => ThemePalette(
    primary: hexToColor(s.primaryColor, fallback: kDefaultPalette.primary),
    secondary: hexToColor(
      s.secondaryColor,
      fallback: kDefaultPalette.secondary,
    ),
    accent: hexToColor(s.accentColor, fallback: kDefaultPalette.accent),
    background: hexToColor(
      s.backgroundColor,
      fallback: kDefaultPalette.background,
    ),
    surface: hexToColor(s.surfaceColor, fallback: kDefaultPalette.surface),
    text: hexToColor(s.textColor, fallback: kDefaultPalette.text),
    radius: s.borderRadius,
    fontFamily: supportedFonts.contains(s.fontFamily)
        ? s.fontFamily
        : 'Tajawal',
  );
}

/// Font families the app can render (Google Fonts). Anything else falls back to
/// Tajawal, so a stray server value never crashes `GoogleFonts.getFont`.
const supportedFonts = ['Tajawal', 'Cairo'];

/// Curated, brand-neutral default palette. Looks good with no shop identity
/// loaded — the theme fallback, distinct from [kDefaultSettings].
const kDefaultPalette = ThemePalette(
  primary: Color(0xFFC0446A),
  secondary: Color(0xFF3C2A34),
  accent: Color(0xFFD4A02A),
  background: Color(0xFFFBF7F4),
  surface: Color(0xFFFFFFFF),
  text: Color(0xFF2A2024),
  radius: 16,
  fontFamily: 'Tajawal',
);

/// Picks the palette that drives the live theme, based on the user's choice.
ThemePalette activePalette(StorefrontSettings settings, ThemeSource source) =>
    source == ThemeSource.appDefault
    ? kDefaultPalette
    : ThemePalette.fromSettings(settings);

class AppTheme {
  static ThemeData build(Brightness brightness, ThemePalette palette) {
    final isDark = brightness == Brightness.dark;

    final primary = palette.primary;
    final radius = palette.radius;

    final seedScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
    );

    final colorScheme = seedScheme.copyWith(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: primary.withValues(alpha: isDark ? 0.22 : 0.10),
      onPrimaryContainer: isDark ? seedScheme.onPrimaryContainer : primary,
      secondary: palette.secondary,
      onSecondary: Colors.white,
      tertiary: palette.accent,
      onTertiary: Colors.white,
      surface: isDark ? seedScheme.surface : palette.surface,
      onSurface: isDark ? seedScheme.onSurface : palette.text,
      error: isDark ? const Color(0xFFFFB4AB) : const Color(0xFFBA1A1A),
      onError: isDark ? const Color(0xFF690005) : Colors.white,
    );

    final scaffoldBg = isDark
        ? colorScheme.surfaceContainerLowest
        : palette.background;

    final textMain = colorScheme.onSurface;
    final textSecondary = colorScheme.onSurfaceVariant;
    final borderStrong = colorScheme.outline;
    final borderSubtle = colorScheme.outlineVariant;
    final surfaceHigh = colorScheme.surfaceContainerHighest;
    final surfaceMid = colorScheme.surfaceContainer;
    final font = palette.fontFamily;

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBg,
    );

    return base.copyWith(
      textTheme: _buildTextTheme(base.textTheme, textMain, textSecondary, font),

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: textMain,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: borderSubtle,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: _font(
          font,
          color: textMain,
          size: 18,
          weight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: textSecondary),
        actionsIconTheme: IconThemeData(color: textSecondary),
      ),

      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: borderSubtle),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: _font(font, size: 16, weight: FontWeight.w600),
          elevation: 0,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: _font(font, size: 16, weight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: _font(font, size: 16, weight: FontWeight.w600),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: _font(font, size: 14, weight: FontWeight.w600),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceHigh.withValues(alpha: isDark ? 1.0 : 0.45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderStrong),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: _font(font, color: textSecondary, size: 14),
        hintStyle: _font(font, color: textSecondary, size: 14),
        floatingLabelStyle: _font(font, color: primary, size: 12),
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surfaceHigh,
        selectedColor: primary.withValues(alpha: 0.15),
        labelStyle: _font(font, size: 13, color: textMain),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(color: borderSubtle),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: primary,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: _font(font, size: 12, weight: FontWeight.w600),
        unselectedLabelStyle: _font(font, size: 12),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark
            ? colorScheme.surfaceContainerHigh
            : colorScheme.inverseSurface,
        contentTextStyle: _font(
          font,
          color: isDark ? colorScheme.onSurface : colorScheme.onInverseSurface,
          size: 14,
        ),
        actionTextColor: isDark ? primary : colorScheme.inversePrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      dividerTheme: DividerThemeData(
        color: borderSubtle,
        thickness: 1,
        space: 1,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primary.withValues(alpha: 0.3);
          }
          return null;
        }),
      ),

      listTileTheme: ListTileThemeData(
        iconColor: textSecondary,
        textColor: textMain,
        tileColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: surfaceMid,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderSubtle),
        ),
        elevation: 4,
        textStyle: _font(font, size: 14, color: textMain),
        labelTextStyle: WidgetStateProperty.all(
          _font(font, size: 14, color: textMain),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: surfaceMid,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
        titleTextStyle: _font(
          font,
          size: 18,
          weight: FontWeight.w600,
          color: textMain,
        ),
        contentTextStyle: _font(font, size: 14, color: textMain),
      ),

      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return primary;
            return textSecondary;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primary.withValues(alpha: 0.12);
            }
            return Colors.transparent;
          }),
          side: WidgetStateProperty.all(BorderSide(color: borderSubtle)),
          textStyle: WidgetStateProperty.all(
            _font(font, size: 13, weight: FontWeight.w500),
          ),
          iconSize: WidgetStateProperty.all(18),
        ),
      ),

      badgeTheme: BadgeThemeData(
        backgroundColor: primary,
        textColor: Colors.white,
        smallSize: 8,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),

      iconTheme: IconThemeData(color: textSecondary),
    );
  }

  static TextStyle _font(
    String family, {
    Color? color,
    double? size,
    FontWeight? weight,
  }) {
    return GoogleFonts.getFont(
      family,
      color: color,
      fontSize: size,
      fontWeight: weight,
    );
  }

  static TextTheme _buildTextTheme(
    TextTheme base,
    Color text,
    Color textSecondary,
    String family,
  ) {
    final fontTheme = GoogleFonts.getTextTheme(family, base);
    return fontTheme.copyWith(
      displayLarge: fontTheme.displayLarge?.copyWith(
        color: text,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: fontTheme.displayMedium?.copyWith(
        color: text,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: fontTheme.headlineLarge?.copyWith(
        color: text,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      headlineMedium: fontTheme.headlineMedium?.copyWith(
        color: text,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      titleLarge: fontTheme.titleLarge?.copyWith(
        color: text,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      titleMedium: fontTheme.titleMedium?.copyWith(
        color: text,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      bodyLarge: fontTheme.bodyLarge?.copyWith(color: text, fontSize: 16),
      bodyMedium: fontTheme.bodyMedium?.copyWith(color: text, fontSize: 14),
      bodySmall: fontTheme.bodySmall?.copyWith(
        color: textSecondary,
        fontSize: 12,
      ),
      labelLarge: fontTheme.labelLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      labelMedium: fontTheme.labelMedium?.copyWith(
        color: textSecondary,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      labelSmall: fontTheme.labelSmall?.copyWith(
        color: textSecondary,
        fontSize: 11,
      ),
    );
  }
}
