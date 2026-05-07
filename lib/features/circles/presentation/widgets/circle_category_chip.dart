import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';

class CircleCategoryChip extends StatelessWidget {
  final String label;

  const CircleCategoryChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: context.w(12)),
      padding: EdgeInsets.symmetric(horizontal: context.w(16)),
      decoration: BoxDecoration(
        color: AppColors.surfaceGreen,
        borderRadius: BorderRadius.circular(context.w(20)),
      ),
      child: Center(
        child: Text(
          label,
          style: AppTypography.bodySmall(context).copyWith(
            color: AppColors.forestGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
