import 'package:go_router/go_router.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/welcome_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/therapists/presentation/pages/therapists_page.dart';
import '../../features/journal/presentation/pages/journal_page.dart';
import '../../features/circles/presentation/pages/circles_page.dart';
import '../../features/crisis_protocol/presentation/pages/crisis_protocol_page.dart';
import '../../features/sessions/presentation/pages/session_page.dart';
import '../../features/sessions/presentation/pages/in_session_page.dart';
import '../../features/therapists/presentation/pages/booking_page.dart';
import '../../features/therapists/presentation/pages/resource_library_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
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
      GoRoute(
        path: '/crisis',
        builder: (context, state) => const CrisisProtocolPage(),
      ),
      GoRoute(
        path: '/session',
        builder: (context, state) => const SessionPage(),
      ),
      GoRoute(
        path: '/booking',
        builder: (context, state) => const BookingPage(),
      ),
      GoRoute(
        path: '/call',
        builder: (context, state) => const InSessionPage(),
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
