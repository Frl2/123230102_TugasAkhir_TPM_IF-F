import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../shared/widgets/main_scaffold.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/routes/screens/route_search_screen.dart';
import '../../features/routes/screens/route_detail_screen.dart';
import '../../features/tools/screens/tools_screen.dart';
import '../../features/tools/screens/currency_converter_screen.dart';
import '../../features/tools/screens/time_converter_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';
import '../../features/sensors/screens/sensor_monitor_screen.dart';
import '../../features/game/screens/game_screen.dart';
import '../../features/feedback/screens/feedback_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';

// Named routes
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String routes = '/routes';
  static const String routeDetail = '/routes/detail';
  static const String tools = '/tools';
  static const String currency = '/tools/currency';
  static const String timeZone = '/tools/timezone';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String sensorMonitor = '/sensors';
  static const String game = '/game';
  static const String feedback = '/feedback';
  static const String notifications = '/notifications';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull?.isLoggedIn ?? false;
      final isAuthRoute = state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register ||
          state.matchedLocation == AppRoutes.splash;

      if (!isLoggedIn && !isAuthRoute) return AppRoutes.login;
      if (isLoggedIn && state.matchedLocation == AppRoutes.login) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.feedback,
        builder: (context, state) => const FeedbackScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/routes/:id',
        builder: (context, state) => RouteDetailScreen(
          routeId: state.pathParameters['id'] ?? '0',
        ),
      ),
      GoRoute(
        path: AppRoutes.currency,
        builder: (context, state) => const CurrencyConverterScreen(),
      ),
      GoRoute(
        path: AppRoutes.timeZone,
        builder: (context, state) => const TimeConverterScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.sensorMonitor,
        builder: (context, state) => const SensorMonitorScreen(),
      ),
      GoRoute(
        path: AppRoutes.game,
        builder: (context, state) => const GameScreen(),
      ),
      // Main scaffold with bottom nav
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.routes,
            builder: (context, state) => const RouteSearchScreen(),
          ),
          GoRoute(
            path: AppRoutes.tools,
            builder: (context, state) => const ToolsScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Halaman tidak ditemukan: ${state.error}'),
      ),
    ),
  );
});
