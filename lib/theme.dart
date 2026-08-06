import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primary = Color(0xFFC0446A);
const _secondary = Color(0xFF3C2A34);
const _accent = Color(0xFFD4A02A);
const _lightSurface = Color(0xFFFFFFFF);
const _lightBackground = Color(0xFFF5EFF2);
const _lightText = Color(0xFF1D1418);
const _radius = 16.0;

class AppTheme {
  static ThemeData build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final seedScheme = ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: brightness,
    );

    final colorScheme = seedScheme.copyWith(
      primary: _primary,
      onPrimary: Colors.white,
      primaryContainer: _primary.withValues(alpha: isDark ? 0.22 : 0.10),
      onPrimaryContainer: isDark ? seedScheme.onPrimaryContainer : _primary,
      secondary: _secondary,
      onSecondary: Colors.white,
      tertiary: _accent,
      onTertiary: Colors.white,
      surface: isDark ? seedScheme.surface : _lightSurface,
      onSurface: isDark ? seedScheme.onSurface : _lightText,
      error: isDark ? const Color(0xFFFFB4AB) : const Color(0xFFBA1A1A),
      onError: isDark ? const Color(0xFF690005) : Colors.white,
    );

    final scaffoldBg =
        isDark ? colorScheme.surfaceContainerLowest : _lightBackground;

    final textMain = colorScheme.onSurface;
    final textSecondary = colorScheme.onSurfaceVariant;
    final borderStrong = colorScheme.outline;
    final borderSubtle = colorScheme.outlineVariant;
    final surfaceHigh = colorScheme.surfaceContainerHighest;
    final surfaceMid = colorScheme.surfaceContainer;

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBg,
    );

    return base.copyWith(
      textTheme: _buildTextTheme(base.textTheme, textMain, textSecondary),

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: textMain,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: borderSubtle,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: _font(color: textMain, size: 18, weight: FontWeight.w700),
        iconTheme: IconThemeData(color: textSecondary),
        actionsIconTheme: IconThemeData(color: textSecondary),
      ),

      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: BorderSide(color: borderSubtle),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius)),
          textStyle: _font(size: 16, weight: FontWeight.w600),
          elevation: 0,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius)),
          textStyle: _font(size: 16, weight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _primary,
          side: const BorderSide(color: _primary),
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius)),
          textStyle: _font(size: 16, weight: FontWeight.w600),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primary,
          textStyle: _font(size: 14, weight: FontWeight.w600),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceHigh.withValues(alpha: isDark ? 1.0 : 0.45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: borderStrong),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: const BorderSide(color: _primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: _font(color: textSecondary, size: 14),
        hintStyle: _font(color: textSecondary, size: 14),
        floatingLabelStyle: _font(color: _primary, size: 12),
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surfaceHigh,
        selectedColor: _primary.withValues(alpha: 0.15),
        labelStyle: _font(size: 13, color: textMain),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(color: borderSubtle),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: _primary,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: _font(size: 12, weight: FontWeight.w600),
        unselectedLabelStyle: _font(size: 12),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark
            ? colorScheme.surfaceContainerHigh
            : colorScheme.inverseSurface,
        contentTextStyle: _font(
          color: isDark
              ? colorScheme.onSurface
              : colorScheme.onInverseSurface,
          size: 14,
        ),
        actionTextColor: isDark ? _primary : colorScheme.inversePrimary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      dividerTheme: DividerThemeData(
        color: borderSubtle,
        thickness: 1,
        space: 1,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return _primary;
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primary.withValues(alpha: 0.3);
          }
          return null;
        }),
      ),

      listTileTheme: ListTileThemeData(
        iconColor: textSecondary,
        textColor: textMain,
        tileColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius)),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: surfaceMid,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderSubtle),
        ),
        elevation: 4,
        textStyle: _font(size: 14, color: textMain),
        labelTextStyle: WidgetStateProperty.all(
          _font(size: 14, color: textMain),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: surfaceMid,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
        titleTextStyle:
            _font(size: 18, weight: FontWeight.w600, color: textMain),
        contentTextStyle: _font(size: 14, color: textMain),
      ),

      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return _primary;
            return textSecondary;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _primary.withValues(alpha: 0.12);
            }
            return Colors.transparent;
          }),
          side: WidgetStateProperty.all(BorderSide(color: borderSubtle)),
          textStyle: WidgetStateProperty.all(
            _font(size: 13, weight: FontWeight.w500),
          ),
          iconSize: WidgetStateProperty.all(18),
        ),
      ),

      badgeTheme: const BadgeThemeData(
        backgroundColor: _primary,
        textColor: Colors.white,
        smallSize: 8,
      ),

      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: _primary),

      iconTheme: IconThemeData(color: textSecondary),
    );
  }

  static TextStyle _font({
    Color? color,
    double? size,
    FontWeight? weight,
  }) {
    return GoogleFonts.tajawal(
        color: color, fontSize: size, fontWeight: weight);
  }

  static TextTheme _buildTextTheme(
    TextTheme base,
    Color text,
    Color textSecondary,
  ) {
    final fontTheme = GoogleFonts.tajawalTextTheme(base);
    return fontTheme.copyWith(
      displayLarge: fontTheme.displayLarge
          ?.copyWith(color: text, fontWeight: FontWeight.w700),
      displayMedium: fontTheme.displayMedium
          ?.copyWith(color: text, fontWeight: FontWeight.w700),
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
          ?.copyWith(color: textSecondary, fontSize: 12),
      labelLarge: fontTheme.labelLarge?.copyWith(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
      labelMedium: fontTheme.labelMedium?.copyWith(
          color: textSecondary, fontWeight: FontWeight.w500, fontSize: 12),
      labelSmall:
          fontTheme.labelSmall?.copyWith(color: textSecondary, fontSize: 11),
    );
  }
}
