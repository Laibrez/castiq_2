import 'package:flutter/material.dart';

class AppTheme {
  // Black and White Theme Colors
  static const Color primaryBlack = Color(0xFF000000);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color darkGrey = Color(0xFF2C2C2C);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color mediumGrey = Color(0xFF757575);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryBlack,
      scaffoldBackgroundColor: primaryWhite,
      colorScheme: const ColorScheme.light(
        primary: primaryBlack,
        secondary: darkGrey,
        surface: primaryWhite,
        background: primaryWhite,
        error: Colors.red,
        onPrimary: primaryWhite,
        onSecondary: primaryWhite,
        onSurface: primaryBlack,
        onBackground: primaryBlack,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlack,
        foregroundColor: primaryWhite,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlack,
          foregroundColor: primaryWhite,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlack,
          side: const BorderSide(color: primaryBlack),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlack, width: 2),
        ),
        filled: true,
        fillColor: primaryWhite,
      ),
      cardTheme: CardTheme(
        color: primaryWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: lightGrey, width: 1),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryWhite,
      scaffoldBackgroundColor: primaryBlack,
      colorScheme: const ColorScheme.dark(
        primary: primaryWhite,
        secondary: lightGrey,
        surface: darkGrey,
        background: primaryBlack,
        error: Colors.red,
        onPrimary: primaryBlack,
        onSecondary: primaryBlack,
        onSurface: primaryWhite,
        onBackground: primaryWhite,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlack,
        foregroundColor: primaryWhite,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryWhite,
          foregroundColor: primaryBlack,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryWhite,
          side: const BorderSide(color: primaryWhite),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: mediumGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: mediumGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryWhite, width: 2),
        ),
        filled: true,
        fillColor: darkGrey,
      ),
      cardTheme: CardTheme(
        color: darkGrey,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: mediumGrey, width: 1),
        ),
      ),
    );
  }
}
