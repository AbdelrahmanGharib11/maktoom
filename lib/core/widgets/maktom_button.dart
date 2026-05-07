import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MaktomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;
  final double? width;

  const MaktomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? AppColors.surfaceGreen : AppColors.forestGreen,
          foregroundColor: isSecondary ? AppColors.forestGreen : Colors.white,
          elevation: isSecondary ? 0 : 2,
          shadowColor: AppColors.forestGreen.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
