import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../widgets/auth_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    // TODO: Implement actual signup
    await Future.delayed(800.ms);
    if (mounted) {
      setState(() => _isLoading = false);
      context.go('/app/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7F2),
      body: Stack(
        children: [
          // Botanical top-left accent
          Positioned(
            top: -40,
            left: -40,
            child: Opacity(
              opacity: 0.12,
              child: Icon(
                Icons.eco_rounded,
                size: 220,
                color: AppColors.forestGreen,
              ),
            ),
          ).animate().fadeIn(duration: 1.2.seconds),

          // Botanical bottom-right accent
          Positioned(
            bottom: -30,
            right: -30,
            child: Opacity(
              opacity: 0.07,
              child: Icon(
                Icons.spa_rounded,
                size: 180,
                color: AppColors.forestGreen,
              ),
            ),
          ).animate().fadeIn(duration: 1.2.seconds),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w(24),
                  vertical: context.h(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ── Header ───────────────────────────────────────────
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.forestGreen,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.forestGreen.withAlpha(80),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.spa_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Maktom',
                          style: AppTypography.headingLarge(context).copyWith(
                            color: AppColors.forestGreen,
                            fontWeight: FontWeight.w900,
                            fontSize: 28,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ).animate().fadeIn().slideY(begin: -0.2, end: 0),

                    SizedBox(height: context.h(32)),

                    // ── White card ────────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(context.w(28)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.forestGreen.withAlpha(18),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start your journey.',
                              style: AppTypography.headingLarge(context).copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.textDark,
                                fontSize: 26,
                              ),
                            ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.05, end: 0),

                            const SizedBox(height: 6),

                            RichText(
                              text: TextSpan(
                                style: AppTypography.bodyMedium(context).copyWith(
                                  color: AppColors.textMuted,
                                  height: 1.5,
                                ),
                                children: const [
                                  TextSpan(text: 'No real name needed. Your '),
                                  TextSpan(
                                    text: 'alias',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.forestGreen,
                                    ),
                                  ),
                                  TextSpan(text: ' is auto-generated, preserving your sanctuary.'),
                                ],
                              ),
                            ).animate().fadeIn(delay: 300.ms),

                            SizedBox(height: context.h(28)),

                            AuthTextField(
                              label: 'Email',
                              hint: 'alias@example.com',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.mail_outline_rounded,
                              validator: (v) => (v == null || v.isEmpty) ? 'Please enter your email' : null,
                            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),

                            SizedBox(height: context.h(16)),

                            AuthTextField(
                              label: 'Password',
                              hint: 'Create a password',
                              isPassword: true,
                              controller: _passwordController,
                              prefixIcon: Icons.lock_outline_rounded,
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Please enter your password';
                                if (v.length < 8) return 'Password must be at least 8 characters';
                                return null;
                              },
                            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),

                            SizedBox(height: context.h(16)),

                            AuthTextField(
                              label: 'Confirm Password',
                              hint: 'Repeat your password',
                              isPassword: true,
                              controller: _confirmPasswordController,
                              prefixIcon: Icons.lock_outline_rounded,
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Please confirm your password';
                                if (v != _passwordController.text) return 'Passwords do not match';
                                return null;
                              },
                            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),

                            SizedBox(height: context.h(28)),

                            // Create Account button
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleSignup,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.forestGreen,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : Text(
                                        'Create Account',
                                        style: AppTypography.bodyLarge(context).copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              ),
                            ).animate().fadeIn(delay: 700.ms).scale(
                              begin: const Offset(0.96, 0.96),
                              end: const Offset(1, 1),
                            ),

                            SizedBox(height: context.h(16)),

                            // Privacy policy
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.warmSage,
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 32),
                                ),
                                child: Text(
                                  'Privacy Policy',
                                  style: AppTypography.bodySmall(context).copyWith(
                                    color: AppColors.warmSage,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.warmSage,
                                  ),
                                ),
                              ),
                            ).animate().fadeIn(delay: 800.ms),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.1, end: 0),

                    SizedBox(height: context.h(24)),

                    // Log in link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: AppTypography.bodyMedium(context).copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go('/login');
                            }
                          },
                          child: Text(
                            'Log in',
                            style: AppTypography.bodyMedium(context).copyWith(
                              color: AppColors.forestGreen,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 900.ms),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
