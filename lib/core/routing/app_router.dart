import 'package:go_router/go_router.dart';
import 'package:intervew_task/features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/verify_page.dart';
import '../../features/auth/presentation/pages/success_page.dart';
import '../../features/home/presentation/pages/home_page.dart'; // Ensure HomePage is imported

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboard',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/verify',
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return VerifyPage(email: email);
      },
    ),
    GoRoute(
      path: '/success',
      builder: (context, state) => const SuccessPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);