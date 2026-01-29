import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_route_names.dart';
import 'package:travel_planner/shared/widgets/error_screen.dart';
import 'package:travel_planner/features/auth/screens/sign_in_screen.dart';
import 'package:travel_planner/features/auth/screens/sign_up_screen.dart';
import 'package:travel_planner/features/auth/screens/home_screen.dart';
import 'package:travel_planner/features/settings/screens/settings_screen.dart';
import 'package:travel_planner/features/trips/screens/trips_screen.dart';
import 'package:travel_planner/features/trips/screens/trip_detail_screen.dart';
import 'package:travel_planner/features/auth/services/auth_service.dart';
final appRouter = GoRouter(
  initialLocation: AppRoutePaths.auth,
  redirect: (context, state) {
    final authService = AuthService();
    final isLoggedIn = authService.isLoggedIn();
    
    
    if (!isLoggedIn && !state.uri.toString().startsWith('/auth')) {
      return AppRoutePaths.auth;
    }
    
    
    if (isLoggedIn && state.uri.toString().startsWith('/auth')) {
      return AppRoutePaths.home;
    }
    
    return null;
  },
  routes: [
    GoRoute(
      name: AppRouteNames.home,
      path: AppRoutePaths.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: AppRouteNames.settings,
      path: AppRoutePaths.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      name: AppRouteNames.trips,
      path: AppRoutePaths.trips,
      builder: (context, state) => const TripsScreen(),
      routes: [
        GoRoute(
          name: AppRouteNames.tripDetail,
          path: ':id', 
          builder: (context, state) {
            
            
            return const TripDetailScreen();
          },
        ),
      ],
    ),
    GoRoute(
      name: AppRouteNames.auth,
      path: AppRoutePaths.auth,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      name: AppRouteNames.signIn,
      path: AppRoutePaths.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      name: AppRouteNames.signUp,
      path: AppRoutePaths.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
