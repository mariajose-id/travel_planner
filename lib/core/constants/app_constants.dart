class AppConstants {
  static const String appName = 'Travel Planner';
  static const String appVersion = '1.0.0';
  
  static const String homeRoute = 'home';
  static const String settingsRoute = 'settings';
  static const String tripsRoute = 'trips';
  static const String tripDetailRoute = 'trip-detail';
  static const String authRoute = 'auth';
  static const String signInRoute = 'sign-in';
  static const String signUpRoute = 'sign-up';
  
  static const String homePath = '/home';
  static const String settingsPath = '/settings';
  static const String tripsPath = '/trips';
  static const String tripDetailPath = '/trips/:id';
  static const String authPath = '/auth';
  static const String signInPath = '/auth/sign-in';
  static const String signUpPath = '/auth/sign-up';
  
  static const String userTokenKey = 'user_token';
  static const String userPreferencesKey = 'user_preferences';
  static const String themeModeKey = 'theme_mode';
  static const String languageCodeKey = 'language_code';
  
  static const String baseUrl = 'https://api.travel-planner.com';
  static const int apiTimeout = 30000;
  
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int maxEmailLength = 100;
  
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
  static const double cardCornerRadius = 16.0;
  static const double buttonHeight = 56.0;
  
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 300);
  static const Duration longDuration = Duration(milliseconds: 500);
  
  static const String networkErrorMessage = 'Network error occurred';
  static const String unknownErrorMessage = 'An unknown error occurred';
  static const String timeoutErrorMessage = 'Request timed out';
  
  static const String successMessage = 'Operation completed successfully';
}