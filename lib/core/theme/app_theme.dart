import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.forestGreen,
        primary: AppColors.forestGreen,
        secondary: AppColors.warmSage,
        tertiary: AppColors.mutedGold,
        background: AppColors.background,
        surface: AppColors.surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.background,
      // We will handle specific fonts in AppTypography, 
      // but we set a default here.
      fontFamily: GoogleFonts.outfit().fontFamily, 
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        bodyLarge: GoogleFonts.inter(fontSize: 16, color: AppColors.textDark),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.textDark.withOpacity(0.8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forestGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shadowColor: AppColors.forestGreen.withOpacity(0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  static ThemeData get darkTheme => lightTheme.copyWith(
    brightness: Brightness.dark,
  );
}
