import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color blue = Color(0xFF0047FF);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static ThemeData get lightTheme {
    final base = ThemeData.light();

    return base.copyWith(
      useMaterial3: false, // <-- Evita problemas en web con M3
      primaryColor: blue,
      scaffoldBackgroundColor: const Color(0xFFF5F5F7),

      /// TIPOGRAFÍA – 100% estable
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),

      /// APPBAR
      appBarTheme: AppBarTheme(
        backgroundColor: black,
        foregroundColor: white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: white,
        ),
      ),

      /// COLOR SCHEME
      colorScheme: base.colorScheme.copyWith(
        primary: blue,
        secondary: blue,
      ),

      /// TARJETAS
      cardTheme: const CardThemeData(
  elevation: 6,
  shadowColor: Colors.black12,
  margin: EdgeInsets.all(12),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
),


      /// BOTTOM NAVBAR
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
