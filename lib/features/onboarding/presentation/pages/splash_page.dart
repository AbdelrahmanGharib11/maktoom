import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:maktoom/features/auth/presentation/cubit/auth_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/l10n_extensions.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../injection_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Check auth status
    await sl<AuthCubit>().checkAuthStatus();

    // Minimum splash time
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softOffWhite,
      body: Stack(
        children: [
          // Botanical Background
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                'assets/images/splash_bg.png',
                fit: BoxFit.cover,
              ),
            ),
          ).animate().fadeIn(duration: 1500.ms),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Placeholder / Text
                Image.asset(
                      'assets/images/logo.png',
                      width: context.w(180),
                      fit: BoxFit.contain,
                    )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      curve: Curves.easeOutBack,
                    ),

                SizedBox(height: context.h(16)),

                Text(
                      context.l10n.tagline,
                      textAlign: TextAlign.center,
                      style: AppTypography.tagline(context),
                    )
                    .animate()
                    .fadeIn(delay: 500.ms, duration: 800.ms)
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1, 1),
                    ),
              ],
            ),
          ),

          // Bottom loading indicator
          Positioned(
            bottom: context.h(60),
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: context.w(40),
                height: context.w(40),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.forestGreen.withOpacity(0.3),
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 1000.ms),
          ),
        ],
      ),
    );
  }
}
