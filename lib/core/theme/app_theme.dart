import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colores principales basados en el diseño de Banco Perla
  static const Color primaryNavy = Color(0xFF1A237E); // Azul oscuro
  static const Color backgroundLightBlue = Color(
    0xFFE3F2FD,
  ); // Azul claro sutil
  static const Color surfaceWhite = Colors.white; // Para tarjetas y legibilidad
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Colors.grey;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundLightBlue,
      primaryColor: primaryNavy,
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: const TextStyle(
          color: primaryNavy,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: const TextStyle(color: textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryNavy,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: textSecondary),
      ),
    );
  }
}
