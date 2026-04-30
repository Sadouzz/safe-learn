import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/onboarding/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/auth_screen.dart';
import '../features/home/home_screen.dart';
import '../features/games/games_home_screen.dart';
import '../features/games/games_map_screen.dart';
import '../features/games/monument_intro_screen.dart';
import '../features/games/monument_ar_screen.dart';
import '../features/explore/explore_screen.dart';
import '../features/explore/explore_details_screen.dart';
import '../features/map/map_home_screen.dart';
import '../features/map/map_nearby_events_screen.dart';
import '../features/map/map_transport_screen.dart';
import '../features/profil/profil_screen.dart';
import '../features/community/feed_screen.dart';
import '../features/community/hashtag_screen.dart';
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
            path: '/quiz', // We keep the path to not break bottom nav if it relies on this string
            builder: (context, state) => const GamesHomeScreen(),
          ),
          GoRoute(
            path: '/games/map',
            builder: (context, state) => const GamesMapScreen(),
          ),
          GoRoute(
            path: '/games/monument',
            builder: (context, state) => const MonumentIntroScreen(),
          ),
          GoRoute(
            path: '/games/monument/ar',
            builder: (context, state) => const MonumentARScreen(),
          ),
          GoRoute(
            path: '/explore',
            builder: (context, state) => const ExploreScreen(),
            routes: [
              GoRoute(
                path: 'details',
                builder: (context, state) => const DetailScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/map',
            builder: (context, state) => const MapHomeScreen(),
            routes: [
              GoRoute(
                path: 'events',
                builder: (context, state) => const MapNearbyEventsScreen(),
              ),
              GoRoute(
                path: 'transport',
                builder: (context, state) => const MapTransportScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/profil',
            builder: (context, state) => const ProfilScreen(),
          ),
          GoRoute(
            path: '/community',
            builder: (context, state) => const FeedScreen(),
            routes: [
              GoRoute(
                path: 'hashtag',
                builder: (context, state) => const HashtagScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
