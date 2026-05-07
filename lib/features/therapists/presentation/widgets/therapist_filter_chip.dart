import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';

class TherapistFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const TherapistFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: context.w(8), top: context.h(12), bottom: context.h(12)),
        padding: EdgeInsets.symmetric(horizontal: context.w(20), vertical: context.h(8)),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.forestGreen : Colors.white,
          borderRadius: BorderRadius.circular(context.w(24)),
          border: Border.all(
            color: isSelected ? AppColors.forestGreen : AppColors.surfaceGreen,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.bodySmall(context).copyWith(
              color: isSelected ? Colors.white : AppColors.textMuted,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
