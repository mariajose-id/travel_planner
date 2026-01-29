import 'package:travel_planner/core/constants/app_constants.dart';
abstract class AppRouteNames {
  static const home = AppConstants.homeRoute;
  static const settings = AppConstants.settingsRoute;
  static const trips = AppConstants.tripsRoute;
  static const tripDetail = AppConstants.tripDetailRoute;
  static const auth = AppConstants.authRoute;
  static const signIn = AppConstants.signInRoute;
  static const signUp = AppConstants.signUpRoute;
}
abstract class AppRoutePaths {
  static const home = AppConstants.homePath;
  static const settings = AppConstants.settingsPath;
  static const trips = AppConstants.tripsPath;
  static const tripDetail = AppConstants.tripDetailPath;
  static const auth = AppConstants.authPath;
  static const signIn = AppConstants.signInPath;
  static const signUp = AppConstants.signUpPath;
}