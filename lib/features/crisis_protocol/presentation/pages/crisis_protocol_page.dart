import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/maktom_button.dart';
import '../../../../core/utils/responsive_helper.dart';

class CrisisProtocolPage extends StatelessWidget {
  const CrisisProtocolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1), // Very soft amber background
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.w(40)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_rounded,
                color: AppColors.amber,
                size: context.w(80),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: 2.seconds),
              
              SizedBox(height: context.h(40)),
              
              Text(
                'We are here for you.', // Could be localized
                textAlign: TextAlign.center,
                style: AppTypography.headingLarge(context).copyWith(
                  color: const Color(0xFF795548), // Warm brown text
                ),
              ).animate().fadeIn(),
              
              SizedBox(height: context.h(16)),
              
              Text(
                'It is okay to not be okay. If you are feeling overwhelmed, we can connect you with someone immediately.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge(context).copyWith(
                  color: const Color(0xFF8D6E63),
                  height: 1.5,
                ),
              ).animate().fadeIn(delay: 300.ms),
              
              SizedBox(height: context.h(60)),
              
              MaktomButton(
                text: 'Talk to someone now',
                onPressed: () {},
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
              
              SizedBox(height: context.h(16)),
              
              TextButton(
                onPressed: () => context.pop(),
                child: Text(
                  'I’m okay, continue',
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: const Color(0xFF8D6E63),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ).animate().fadeIn(delay: 900.ms),
            ],
          ),
        ),
      ),
    );
  }
}
