import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/entities/onboarding_entity.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';

class OnboardingItemWidget extends StatelessWidget {
  final OnboardingEntity item;

  const OnboardingItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.w(40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            item.imagePath,
            height: context.h(300),
          ).animate().fadeIn(duration: 600.ms).scale(),
          
          SizedBox(height: context.h(48)),
          
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: AppTypography.headingLarge(context),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
          
          SizedBox(height: context.h(16)),
          
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge(context).copyWith(
              color: AppColors.textMuted,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
        ],
      ),
    );
  }
}
