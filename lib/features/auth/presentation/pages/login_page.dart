import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../widgets/auth_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    // TODO: Implement actual authentication
    await Future.delayed(800.ms);
    if (mounted) {
      setState(() => _isLoading = false);
      context.go('/app/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7F2), // soft sage green bg
      body: Stack(
        children: [
          // Botanical top-right accent
          Positioned(
            top: -40,
            right: -40,
            child: Opacity(
              opacity: 0.12,
              child: Icon(
                Icons.spa_rounded,
                size: 220,
                color: AppColors.forestGreen,
              ),
            ),
          ).animate().fadeIn(duration: 1.2.seconds),

          // Botanical bottom-left accent
          Positioned(
            bottom: -30,
            left: -30,
            child: Opacity(
              opacity: 0.07,
              child: Icon(
                Icons.eco_rounded,
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
                              'Welcome Back',
                              style: AppTypography.headingLarge(context).copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.textDark,
                                fontSize: 26,
                              ),
                            ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.05, end: 0),

                            const SizedBox(height: 6),

                            Text(
                              'Enter your details to access your sanctuary.',
                              style: AppTypography.bodyMedium(context).copyWith(
                                color: AppColors.textMuted,
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
                              hint: 'Enter your password',
                              isPassword: true,
                              controller: _passwordController,
                              prefixIcon: Icons.lock_outline_rounded,
                              validator: (v) => (v == null || v.isEmpty) ? 'Please enter your password' : null,
                            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),

                            const SizedBox(height: 8),

                            // Forgot password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.warmSage,
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 32),
                                ),
                                child: Text(
                                  'Forgot password?',
                                  style: AppTypography.bodySmall(context).copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.warmSage,
                                  ),
                                ),
                              ),
                            ).animate().fadeIn(delay: 600.ms),

                            SizedBox(height: context.h(24)),

                            // Sign In button
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleLogin,
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
                                        'Sign In',
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
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.1, end: 0),

                    SizedBox(height: context.h(24)),

                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New here? ',
                          style: AppTypography.bodyMedium(context).copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/signup'),
                          child: Text(
                            'Sign Up',
                            style: AppTypography.bodyMedium(context).copyWith(
                              color: AppColors.forestGreen,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 800.ms),
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
