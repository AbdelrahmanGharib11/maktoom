import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktoom/core/theme/app_colors.dart';
import 'package:maktoom/core/theme/app_typography.dart';
import 'package:maktoom/core/widgets/maktom_button.dart';
import 'package:maktoom/core/widgets/maktom_text_field.dart';
import '../../../../injection_container.dart';
import '../cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go('/');
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Welcome Back',
                        style: AppTypography.headingLarge(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.forestGreen,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to continue your journey.',
                        style: AppTypography.bodyMedium(
                          context,
                        ).copyWith(color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 48),
                      MaktomTextField(
                        label: 'EMAIL ADDRESS',
                        hint: 'Enter your email',
                        controller: _emailController,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value == null || !value.contains('@')
                            ? 'Invalid email'
                            : null,
                      ),
                      const SizedBox(height: 24),
                      MaktomTextField(
                        label: 'PASSWORD',
                        hint: 'Enter your password',
                        isPassword: true,
                        controller: _passwordController,
                        prefixIcon: Icons.lock_outline_rounded,
                        validator: (value) => value == null || value.length < 6
                            ? 'Password too short'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.push('/forgot-password'),
                          child: Text(
                            'Forgot Password?',
                            style: AppTypography.bodySmall(context).copyWith(
                              color: AppColors.forestGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (state is AuthError)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      MaktomButton(
                        text: state is AuthLoading
                            ? 'Signing in...'
                            : 'Sign In',
                        onPressed: state is AuthLoading
                            ? () {}
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().login(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                }
                              },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppTypography.bodySmall(context),
                          ),
                          GestureDetector(
                            onTap: () => context.push('/register'),
                            child: Text(
                              'Register',
                              style: AppTypography.bodySmall(context).copyWith(
                                color: AppColors.forestGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
