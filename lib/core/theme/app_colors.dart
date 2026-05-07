import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color forestGreen = Color(0xFF2D6A4F);
  static const Color warmSage = Color(0xFF52B788);
  static const Color softOffWhite = Color(0xFFF8F9F0);
  static const Color mutedGold = Color(0xFFD4A843);

  // Backgrounds & Surfaces
  static const Color background = softOffWhite;
  static const Color surface = Colors.white;
  static const Color surfaceGreen = Color(0xFFE8F3ED);
  
  // Text
  static const Color textDark = Color(0xFF1B4332);
  static const Color textMuted = Color(0xFF708D81);
  
  // Support & Alerts
  static const Color amber = Color(0xFFFFBF00); // Warm amber for crisis
  static const Color error = Color(0xFFD90429);
  
  // Gradients
  static const LinearGradient calmingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE8F3ED),
      Color(0xFFF8F9F0),
    ],
  );
}
