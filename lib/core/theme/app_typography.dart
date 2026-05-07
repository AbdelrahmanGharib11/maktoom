import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  // English Font: Outfit (Modern, Rounded, Premium)
  // Arabic Font: Cairo (Clear, Professional, Elegant)
  
  static String get _enFont => GoogleFonts.outfit().fontFamily!;
  static String get _arFont => GoogleFonts.cairo().fontFamily!;

  static TextStyle _baseStyle(BuildContext context, {
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColors.textDark,
  }) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return TextStyle(
      fontFamily: isAr ? _arFont : _enFont,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: isAr ? 1.4 : 1.2,
    );
  }

  // Display Styles
  static TextStyle displayLarge(BuildContext context) => _baseStyle(
    context,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.forestGreen,
  );

  static TextStyle displayMedium(BuildContext context) => _baseStyle(
    context,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  // Heading Styles
  static TextStyle headingLarge(BuildContext context) => _baseStyle(
    context,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headingMedium(BuildContext context) => _baseStyle(
    context,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headingSmall(BuildContext context) => _baseStyle(
    context,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // Body Styles
  static TextStyle bodyLarge(BuildContext context) => _baseStyle(
    context,
    fontSize: 16,
  );

  static TextStyle bodyMedium(BuildContext context) => _baseStyle(
    context,
    fontSize: 14,
  );

  static TextStyle bodySmall(BuildContext context) => _baseStyle(
    context,
    fontSize: 12,
    color: AppColors.textMuted,
  );

  // Special Styles
  static TextStyle button(BuildContext context) => _baseStyle(
    context,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle labelLarge(BuildContext context) => _baseStyle(
    context,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
  );

  static TextStyle tagline(BuildContext context) => _baseStyle(
    context,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark.withOpacity(0.7),
  ).copyWith(fontStyle: FontStyle.italic);
}
