import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primary = Color(0xFFC0446A);
const _secondary = Color(0xFF3C2A34);
const _accent = Color(0xFFD4A02A);
const _background = Color(0xFFFBF7F4);
const _surface = Color(0xFFFFFFFF);
const _textColor = Color(0xFF2A2024);

TextTheme _buildTextTheme(TextTheme base) {
  final tajawal = GoogleFonts.tajawalTextTheme(base);
  return tajawal.copyWith(
    displayLarge: tajawal.displayLarge?.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: tajawal.displayMedium?.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w700,
    ),
    headlineLarge: tajawal.headlineLarge?.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    headlineMedium: tajawal.headlineMedium?.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
    titleLarge: tajawal.titleLarge?.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    titleMedium: tajawal.titleMedium?.copyWith(
      color: _textColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodyLarge: tajawal.bodyLarge?.copyWith(color: _textColor, fontSize: 16),
    bodyMedium: tajawal.bodyMedium?.copyWith(color: _textColor, fontSize: 14),
    bodySmall: tajawal.bodySmall?.copyWith(
      color: _textColor.withOpacity(0.6),
      fontSize: 12,
    ),
    labelLarge: tajawal.labelLarge?.copyWith(
      color: _surface,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
  );
}

ThemeData get lightTheme {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: _primary,
    brightness: Brightness.light,
  ).copyWith(
    primary: _primary,
    secondary: _secondary,
    tertiary: _accent,
    surface: _surface,
    onSurface: _textColor,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    error: const Color(0xFFD32F2F),
  );

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: _background,
  );

  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    appBarTheme: AppBarTheme(
      backgroundColor: _surface,
      foregroundColor: _textColor,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.tajawal(
        color: _textColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardTheme: CardThemeData(
      color: _surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: _secondary.withOpacity(0.08)),
      ),
      margin: EdgeInsets.zero,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: GoogleFonts.tajawal(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primary,
        side: const BorderSide(color: _primary),
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: GoogleFonts.tajawal(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primary,
        textStyle: GoogleFonts.tajawal(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _background,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: _secondary.withOpacity(0.15)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: _secondary.withOpacity(0.15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFD32F2F)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: GoogleFonts.tajawal(
        color: _textColor.withOpacity(0.4),
        fontSize: 14,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: _background,
      selectedColor: _primary.withOpacity(0.12),
      labelStyle: GoogleFonts.tajawal(fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide(color: _secondary.withOpacity(0.12)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _surface,
      selectedItemColor: _primary,
      unselectedItemColor: Color(0xFF9E9E9E),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: _secondary,
    ),
    dividerTheme: DividerThemeData(
      color: _secondary.withOpacity(0.08),
      thickness: 1,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _primary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: _surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
  );
}

ThemeData get darkTheme => lightTheme;
