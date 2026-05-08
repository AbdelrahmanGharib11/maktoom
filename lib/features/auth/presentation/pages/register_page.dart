import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/maktom_button.dart';
import '../../../../core/widgets/maktom_text_field.dart';
import '../../../../injection_container.dart';
import '../cubit/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration successful! Please login.')),
            );
            context.go('/login');
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
                        'Join Maktom',
                        style: AppTypography.headingLarge(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.forestGreen,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start your healing journey today.',
                        style: AppTypography.bodyMedium(context).copyWith(color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 48),
                      MaktomTextField(
                        label: 'FULL NAME',
                        hint: 'Enter your name',
                        controller: _nameController,
                        prefixIcon: Icons.person_outline,
                        validator: (value) => value == null || value.isEmpty ? 'Name required' : null,
                      ),
                      const SizedBox(height: 24),
                      MaktomTextField(
                        label: 'EMAIL ADDRESS',
                        hint: 'Enter your email',
                        controller: _emailController,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => value == null || !value.contains('@') ? 'Invalid email' : null,
                      ),
                      const SizedBox(height: 24),
                      MaktomTextField(
                        label: 'PASSWORD',
                        hint: 'Enter your password',
                        isPassword: true,
                        controller: _passwordController,
                        prefixIcon: Icons.lock_outline_rounded,
                        validator: (value) => value == null || value.length < 6 ? 'Password too short' : null,
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
                        text: state is AuthLoading ? 'Creating Account...' : 'Register',
                        onPressed: state is AuthLoading
                            ? () {}
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().register(
                                        _emailController.text,
                                        _passwordController.text,
                                        _nameController.text,
                                      );
                                }
                              },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: AppTypography.bodySmall(context),
                          ),
                          GestureDetector(
                            onTap: () => context.push('/login'),
                            child: Text(
                              'Login',
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
