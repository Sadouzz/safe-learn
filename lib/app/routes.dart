import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/onboarding/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/auth_screen.dart';
import '../features/home/home_screen.dart';
import '../features/quiz/quiz_list_screen.dart';
import '../features/missions/missions_screen.dart';
import '../features/cultures/cultures_screen.dart';
import '../features/profil/profil_screen.dart';
import '../core/widgets/bottom_nav.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return AppBottomNavShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/quiz',
            builder: (context, state) => const QuizListScreen(),
          ),
          GoRoute(
            path: '/missions',
            builder: (context, state) => const MissionsScreen(),
          ),
          GoRoute(
            path: '/cultures',
            builder: (context, state) => const CulturesScreen(),
          ),
          GoRoute(
            path: '/profil',
            builder: (context, state) => const ProfilScreen(),
          ),
        ],
      ),
    ],
  );
});
