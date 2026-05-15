import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/circles/presentation/pages/circles_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/journal/presentation/pages/journal_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/welcome_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/resource_library_page.dart';
import '../../features/sessions/presentation/pages/in_session_page.dart';
import '../../features/sessions/presentation/pages/waiting_room_page.dart';
import '../../features/therapists/presentation/pages/booking_page.dart';
import '../../features/therapists/presentation/pages/therapists_page.dart';
import '../../features/therapists/presentation/pages/therapist_profile_page.dart';
import '../../features/therapists/presentation/pages/voice_preview_page.dart';
import '../../features/therapists/presentation/pages/match_quiz_flow_page.dart';
import '../../features/therapists/presentation/pages/quiz_results_page.dart';
import '../widgets/app_shell.dart';

class AppRouter {
  AppRouter._();

  // TODO: Enable once real auth state exists.
  // With this disabled, the app keeps the current splash/onboarding -> app flow.
  static const bool _isAuthGuardEnabled = false;

  static bool get _isAuthenticated => true;
  static bool get _isEmailVerified => true;

  static final router = GoRouter(
    initialLocation: '/splash',
    redirect: _redirect,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: '/verify-email',
        builder: (context, state) => const _PlaceholderPage(
          title: 'Email Verification',
          route: '/verify-email',
        ),
      ),
      GoRoute(
        path: '/gift/redeem/:code',
        builder: (context, state) {
          final code = state.pathParameters['code'] ?? '';
          return _PlaceholderPage(
            title: 'Gift Redemption',
            route: '/gift/redeem/$code',
          );
        },
      ),
      GoRoute(
        path: '/app',
        redirect: (context, state) => '/app/home',
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(
            navigationShell: navigationShell,
            location: state.uri.path,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/home',
                builder: (context, state) => const HomePage(),
                routes: [
                  GoRoute(
                    path: 'check-in',
                    builder: (context, state) => const _PlaceholderPage(
                      title: 'Quick Check-In',
                      route: '/app/home/check-in',
                    ),
                  ),
                  GoRoute(
                    path: 'session-prep',
                    builder: (context, state) => const _PlaceholderPage(
                      title: 'Session Prep Card',
                      route: '/app/home/session-prep',
                    ),
                  ),
                  GoRoute(
                    path: 'intake/entry',
                    builder: (context, state) => const _PlaceholderPage(
                      title: 'AI Intake - Entry Prompt',
                      route: '/app/home/intake/entry',
                    ),
                  ),
                  GoRoute(
                    path: 'intake/chat',
                    builder: (context, state) => const _PlaceholderPage(
                      title: 'AI Intake - Chat',
                      route: '/app/home/intake/chat',
                    ),
                  ),
                  GoRoute(
                    path: 'intake/summary',
                    builder: (context, state) => const _PlaceholderPage(
                      title: 'AI Intake - Summary',
                      route: '/app/home/intake/summary',
                    ),
                  ),
                  GoRoute(
                    path: 'waiting-room/:sessionId',
                    builder: (context, state) {
                      return WaitingRoomPage(
                        sessionId: state.pathParameters['sessionId'] ?? '',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/therapists',
                builder: (context, state) => const TherapistsPage(),
                routes: [
                  GoRoute(
                    path: 'quiz',
                    builder: (context, state) => const MatchQuizFlowPage(),
                  ),
                  GoRoute(
                    path: 'quiz/results',
                    builder: (context, state) => const QuizResultsPage(),
                  ),
                  GoRoute(
                    path: 'gift',
                    builder: (context, state) => const _PlaceholderPage(
                      title: 'Gift a Session',
                      route: '/app/therapists/gift',
                    ),
                    routes: [
                      GoRoute(
                        path: 'share',
                        builder: (context, state) => const _PlaceholderPage(
                          title: 'Gift Link Share',
                          route: '/app/therapists/gift/share',
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'session/:id/waiting',
                    builder: (context, state) {
                      return WaitingRoomPage(
                        sessionId: state.pathParameters['id'] ?? '',
                      );
                    },
                  ),
                  GoRoute(
                    path: 'session/:id/active',
                    builder: (context, state) => const InSessionPage(),
                  ),
                  GoRoute(
                    path: 'session/:id/feedback',
                    builder: (context, state) {
                      final id = state.pathParameters['id'] ?? '';
                      return _PlaceholderPage(
                        title: 'Post-Session Feedback',
                        route: '/app/therapists/session/$id/feedback',
                      );
                    },
                  ),
                  GoRoute(
                    path: 'session/:id/tasks',
                    builder: (context, state) {
                      final id = state.pathParameters['id'] ?? '';
                      return _PlaceholderPage(
                        title: 'Post-Session Micro-Tasks',
                        route: '/app/therapists/session/$id/tasks',
                      );
                    },
                  ),
                  GoRoute(
                    path: ':therapistId',
                    builder: (context, state) {
                      final therapistId = state.pathParameters['therapistId'] ?? '';
                      return TherapistProfilePage(therapistId: therapistId);
                    },
                    routes: [
                      GoRoute(
                        path: 'voice-preview',
                        builder: (context, state) {
                          final therapistId =
                              state.pathParameters['therapistId'] ?? '';
                          return VoicePreviewPage(therapistId: therapistId);
                        },
                      ),
                      GoRoute(
                        path: 'book',
                        builder: (context, state) => const BookingPage(),
                      ),
                      GoRoute(
                        path: 'confirm',
                        builder: (context, state) {
                          final therapistId =
                              state.pathParameters['therapistId'] ?? '';
                          return _PlaceholderPage(
                            title: 'Booking Confirmation',
                            route: '/app/therapists/$therapistId/confirm',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/journal',
                builder: (context, state) => const JournalPage(),
                routes: [
                  GoRoute(
                    path: 'new',
                    builder: (context, state) => const _PlaceholderPage(
                      title: 'New Journal Entry',
                      route: '/app/journal/new',
                    ),
                  ),
                  GoRoute(
                    path: 'insights',
                    builder: (context, state) => const _PlaceholderPage(
                      title: 'Mood Trend Insights',
                      route: '/app/journal/insights',
                    ),
                  ),
                  GoRoute(
                    path: ':entryId',
                    builder: (context, state) {
                      final entryId = state.pathParameters['entryId'] ?? '';
                      return _PlaceholderPage(
                        title: 'Journal Entry Detail',
                        route: '/app/journal/$entryId',
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'prep-note',
                        builder: (context, state) {
                          final entryId =
                              state.pathParameters['entryId'] ?? '';
                          return _PlaceholderPage(
                            title: 'Expanded Prep Note',
                            route: '/app/journal/$entryId/prep-note',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/circles',
                builder: (context, state) => const CirclesPage(),
                routes: [
                  GoRoute(
                    path: ':circleId',
                    builder: (context, state) {
                      final circleId = state.pathParameters['circleId'] ?? '';
                      return _PlaceholderPage(
                        title: 'Circle Detail',
                        route: '/app/circles/$circleId',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/profile',
                builder: (context, state) => const ProfilePage(),
                routes: [
                  GoRoute(
                    path: 'resources',
                    builder: (context, state) => const ResourceLibraryPage(),
                  ),
                  GoRoute(
                    path: 'gift',
                    builder: (context, state) => const _PlaceholderPage(
                      title: 'Gift a Session',
                      route: '/app/profile/gift',
                    ),
                    routes: [
                      GoRoute(
                        path: 'share',
                        builder: (context, state) => const _PlaceholderPage(
                          title: 'Gift Link Share',
                          route: '/app/profile/gift/share',
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'success-story',
                    builder: (context, state) => const _PlaceholderPage(
                      title: 'Submit Success Story',
                      route: '/app/profile/success-story',
                    ),
                  ),
                  GoRoute(
                    path: 'audio-upload',
                    builder: (context, state) => const _PlaceholderPage(
                      title: 'Therapist Audio Upload',
                      route: '/app/profile/audio-upload',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static String? _redirect(BuildContext context, GoRouterState state) {
    final path = state.uri.path;

    if (path == '/app') {
      return '/app/home';
    }

    if (!_isAuthGuardEnabled) {
      return null;
    }

    final isGiftRedemption = path.startsWith('/gift/redeem/');
    final isPublicAuthRoute = path == '/splash' ||
        path == '/onboarding' ||
        path == '/welcome' ||
        path == '/login' ||
        path == '/signup' ||
        path == '/verify-email' ||
        isGiftRedemption;
    final isProtectedRoute = !isPublicAuthRoute;

    if (!_isAuthenticated && isProtectedRoute) {
      return '/login';
    }

    final isAuthEntryRoute = path == '/splash' ||
        path == '/onboarding' ||
        path == '/welcome' ||
        path == '/login' ||
        path == '/signup';
    if (_isAuthenticated && isAuthEntryRoute) {
      return '/app/home';
    }

    if (_isAuthenticated && path == '/verify-email' && _isEmailVerified) {
      return '/app/home';
    }

    return null;
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;
  final String route;

  const _PlaceholderPage({
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1B4332)),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1B4332),
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.construction_rounded,
              color: Color(0xFF52B788),
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Coming Soon',
              style: TextStyle(
                color: Color(0xFF1B4332),
                fontFamily: 'Manrope',
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              route,
              style: const TextStyle(
                color: Color(0xFF708D81),
                fontFamily: 'Manrope',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
