import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maktoom/features/onboarding/presentation/pages/splash_page.dart';
import '../../injection_container.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import 'auth_listenable.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/therapists/presentation/pages/therapists_page.dart';
import '../../features/journal/presentation/pages/journal_page.dart';
import '../../features/circles/presentation/pages/circles_page.dart';
import '../../features/crisis_protocol/presentation/pages/crisis_protocol_page.dart';
import '../../features/sessions/presentation/pages/session_page.dart';
import '../../features/therapists/presentation/pages/booking_page.dart';
import '../../features/therapists/presentation/pages/resource_library_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    refreshListenable: sl<AuthListenable>(),
    redirect: (context, state) {
      final authState = sl<AuthListenable>().state;
      final bool isLoggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register' ||
          state.matchedLocation == '/splash' ||
          state.matchedLocation == '/onboarding';

      if (authState is AuthInitial) return null;

      if (authState is! AuthAuthenticated) {
        return isLoggingIn ? null : '/login';
      }

      if (isLoggingIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Forgot Password')),
          body: const Center(child: Text('Forgot Password Screen Placeholder')),
        ),
      ),
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/therapists',
        builder: (context, state) => const TherapistsPage(),
      ),
      GoRoute(
        path: '/journal',
        builder: (context, state) => const JournalPage(),
      ),
      GoRoute(
        path: '/circles',
        builder: (context, state) => const CirclesPage(),
      ),
      GoRoute(path: '/crisis', builder: (context, state) => const CrisisProtocolPage()),
      GoRoute(
        path: '/session',
        builder: (context, state) => const SessionPage(),
      ),

      GoRoute(
        path: '/booking',
        builder: (context, state) => const BookingPage(),
      ),
      GoRoute(
        path: '/resources',
        builder: (context, state) => const ResourceLibraryPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}
