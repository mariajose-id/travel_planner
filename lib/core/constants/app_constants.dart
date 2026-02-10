/// App-wide constants following Clean Code principles.
/// Only includes actively used constants.
class AppConstants {
  AppConstants._();

  // App metadata
  static const String appName = 'Wanderly';
  static const String appVersion = '1.0.0';

  // Storage keys
  static const String userTokenKey = 'user_token';
  static const String userPreferencesKey = 'user_preferences';
  static const String themeModeKey = 'theme_mode';
  static const String languageCodeKey = 'language_code';

  // API
  static const int apiTimeout = 30000;

  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int maxEmailLength = 100;

  // Layout
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
  static const double cardCornerRadius = 16.0;
  static const double buttonHeight = 56.0;

  // Animation durations
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 300);
  static const Duration longDuration = Duration(milliseconds: 500);

  // Contact
  static const String supportEmail = 'support@travelplanner.com';

  // Footer
  static const String footerAddress =
      '1234 Adventure Way\nSeattle, WA 98101\nUnited States';
  static const String footerPhoneNumber = '+1 (555) 123-4567';
  static const String footerCompany = 'Wanderly Inc.';
  static const String footerCommunity = 'Wanderly Community';
  static const String footerOwnerCreator = 'Wanderly Team';
  static const String createdBy = 'Created by';
  static const String allRightsReserved = 'All rights reserved';

  // Currency
  static const String defaultCurrencySymbol = '\$';
  static const String defaultCurrencyCode = 'USD';
  static const Map<String, String> currencySymbols = {
    'en': '\$',
    'es': '€',
    'id': 'Rp',
  };
}
