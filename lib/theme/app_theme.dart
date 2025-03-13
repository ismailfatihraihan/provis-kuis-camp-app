import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF132A13), // Deep Forest Green
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF132A13),
        secondary: const Color(0xFFA68A64), // Muted Gold
        background: const Color(0xFFF5F5F5), // Soft Off-White
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF212121), // Charcoal Black
        ),
        displayMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF212121),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Color(0xFF424242),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color(0xFF616161),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF132A13),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF132A13),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF132A13),
          side: const BorderSide(color: Color(0xFF132A13)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF132A13)),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
}
