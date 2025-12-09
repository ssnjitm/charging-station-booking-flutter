import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/map/presentation/screens/map_screen.dart';
import '../features/map/presentation/screens/station_details_screen.dart';
import '../features/charging/presentation/screens/charging_session_screen.dart';
import '../features/payment/presentation/screens/payment_screen.dart';
import '../features/payment/presentation/screens/payment_success_screen.dart';
import '../features/bookings/presentation/screens/bookings_screen.dart';
import '../features/favorites/presentation/screens/favorites_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/settings_screen.dart';
import '../features/support/presentation/screens/support_screen.dart';
import '../features/admin/presentation/screens/admin_panel_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => const MapScreen(),
    ),
    GoRoute(
      path: '/station/:id',
      builder: (context, state) {
        final stationId = state.pathParameters['id']!;
        return StationDetailsScreen(stationId: stationId);
      },
    ),
    GoRoute(
      path: '/charging',
      builder: (context, state) {
        final stationId = state.extra as String?;
        return ChargingSessionScreen(stationId: stationId);
      },
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final amount = state.extra as double?;
        return PaymentScreen(amount: amount ?? 0);
      },
    ),
    GoRoute(
      path: '/payment-success',
      builder: (context, state) {
        final transactionId = state.extra as String?;
        return PaymentSuccessScreen(transactionId: transactionId ?? '');
      },
    ),
    GoRoute(
      path: '/bookings',
      builder: (context, state) => const BookingsScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/support',
      builder: (context, state) => const SupportScreen(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminPanelScreen(),
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    );
  },
);
