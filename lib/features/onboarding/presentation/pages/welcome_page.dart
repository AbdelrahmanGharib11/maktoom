import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/maktom_button.dart';
import '../../../../core/utils/responsive_helper.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softOffWhite,
      body: Stack(
        children: [
          // Botanical Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/images/splash_bg.png', // Reusing splash bg as a placeholder for the botanical one
                fit: BoxFit.cover,
              ),
            ),
          ).animate().fadeIn(duration: 1.seconds),
          
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w(24)),
              child: Column(
                children: [
                  SizedBox(height: context.h(40)),
                  
                  // Logo with Gold Underline
                  Image.asset(
                    'assets/images/logo.png',
                    width: context.w(120),
                    fit: BoxFit.contain,
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: -0.2, end: 0),
                  
                  const Spacer(),
                  
                  // Headline
                  Text(
                    'Your feelings.\nSafe. Anonymous.\nHeard.',
                    textAlign: TextAlign.center,
                    style: AppTypography.displayLarge(context).copyWith(
                      fontSize: context.w(40),
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
                  
                  SizedBox(height: context.h(24)),
                  
                  // Subtitle
                  Text(
                    'Enter a quiet sanctuary where your voice is valued and your privacy is sacred. Start your journey toward clarity today.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyLarge(context).copyWith(
                      color: AppColors.textMuted.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
                  
                  const Spacer(),
                  
                  // Buttons
                  Column(
                    children: [
                      MaktomButton(
                        text: 'Enter The Sanctuary',
                        onPressed: () => context.go('/'),
                      ),
                      SizedBox(height: context.h(16)),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, context.h(56)),
                          side: BorderSide(color: AppColors.forestGreen.withOpacity(0.3)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Already a Member?',
                          style: AppTypography.bodyLarge(context).copyWith(
                            color: AppColors.forestGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),
                  
                  SizedBox(height: context.h(40)),
                  
                  // Footer
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.verified_user_outlined, size: 14, color: AppColors.textMuted.withOpacity(0.6)),
                          const SizedBox(width: 4),
                          Text(
                            'End-to-end encrypted & private',
                            style: AppTypography.bodySmall(context).copyWith(
                              color: AppColors.textMuted.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Privacy Policy',
                            style: AppTypography.bodySmall(context).copyWith(
                              decoration: TextDecoration.underline,
                              color: AppColors.textMuted.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Terms of Use',
                            style: AppTypography.bodySmall(context).copyWith(
                              decoration: TextDecoration.underline,
                              color: AppColors.textMuted.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).animate().fadeIn(delay: 1.seconds),
                  
                  SizedBox(height: context.h(20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
