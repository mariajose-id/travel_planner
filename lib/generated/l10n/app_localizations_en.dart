import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';


class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Travel Planner';

  @override
  String get appTitle => 'Travel Planner';

  @override
  String get auth_signIn => 'Sign In';

  @override
  String get auth_signUp => 'Sign Up';

  @override
  String get auth_email => 'Email';

  @override
  String get auth_password => 'Password';

  @override
  String get auth_confirmPassword => 'Confirm Password';

  @override
  String get auth_forgotPassword => 'Forgot Password?';

  @override
  String get auth_noAccount => 'Don\'t have an account? ';

  @override
  String get auth_haveAccount => 'Already have an account? ';

  @override
  String get auth_signInErrorTitle => 'Sign In Failed';

  @override
  String get auth_signUpErrorTitle => 'Sign Up Failed';

  @override
  String get home_welcome => 'Welcome';

  @override
  String get home_upcomingTrips => 'Upcoming Trips';

  @override
  String get home_recentlyViewed => 'Recently Viewed';

  @override
  String get errors_invalidEmail => 'Please enter a valid email address';

  @override
  String get errors_shortPassword => 'Password must be at least 6 characters';

  @override
  String get errors_passwordsDontMatch => 'Passwords don\'t match';

  @override
  String get errors_requiredField => 'This field is required';

  @override
  String get errors_genericError => 'An error occurred. Please try again.';

  @override
  String get signInSubtitle => 'Sign in to continue';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get createAccount => 'Create Account';

  @override
  String get or => 'OR';

  @override
  String get alreadyHaveAccount => 'Already have account? Sign In';

  @override
  String get fullName => 'Full Name';

  @override
  String get enterFullName => 'Enter your full name';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get enterConfirmPassword => 'Confirm your password';

  @override
  String get createAccountButton => 'Create Account';

  @override
  String get signInButton => 'Sign In';

  @override
  String get joinUsToStartPlanning => 'Join us to start planning';

  @override
  String get fillInDetails => 'Fill in your details to get started';

  @override
  String get journeyStartsHere => 'Your journey starts here';

  @override
  String get travelPlannerWelcome => 'Welcome to Travel Planner!';

  @override
  String get signOut => 'Sign Out';

  @override
  String get failedToSignOut => 'Failed to sign out';

  @override
  String get settings => 'Settings';

  @override
  String get appSettings => 'App Settings';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get footerAddress =>
      '1234 Adventure Way\nSeattle, WA 98101\nUnited States';

  @override
  String get footerPhoneNumber => '+1 (555) 123-4567';

  @override
  String get footerCompany => 'Wanderly Inc.';

  @override
  String get footerCommunity => 'Wanderly Community';

  @override
  String get footerOwnerCreator => 'Wanderly Team';

  @override
  String get save => 'Save';

  @override
  String get allRightsReserved => 'All rights reserved';

  @override
  String get createdBy => 'Created by';

  @override
  String get profile => 'Profile';

  @override
  String get manageYourProfile => 'Manage your profile and preferences';

  @override
  String get preferences => 'Preferences';

  @override
  String get theme => 'Theme';

  @override
  String get chooseTheme => 'Choose your preferred theme';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose your preferred language';

  @override
  String get account => 'Account';

  @override
  String get signOutConfirmation => 'Are you sure you want to sign out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get explore => 'Explore';

  @override
  String get favorites => 'Favorites';

  @override
  String get yourTrips => 'Your Trips';

  @override
  String get errorLoadingTrips => 'Error loading trips';

  @override
  String get noTripsYet => 'No trips yet';

  @override
  String get startPlanningNextAdventure => 'Start planning your next adventure';

  @override
  String get addTrip => 'Add Trip';

  @override
  String get totalTrips => 'Total Trips';

  @override
  String get totalBudget => 'Total Budget';

  @override
  String get planned => 'Planned';

  @override
  String get ongoing => 'Ongoing';

  @override
  String get completed => 'Completed';

  @override
  String get tripDetails => 'Trip Details';

  @override
  String get searchTrips => 'Search Trips';

  @override
  String get enterTripTitle => 'Enter trip title...';

  @override
  String get close => 'Close';

  @override
  String get filterTrips => 'Filter Trips';

  @override
  String get filterByStatus => 'Filter by status';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get tripNotFound => 'Trip not found';

  @override
  String get destination => 'Destination';

  @override
  String get budget => 'Budget';

  @override
  String get status => 'Status';

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String get tags => 'Tags';

  @override
  String get tripStatusPlanned => 'Planned';

  @override
  String get tripStatusOngoing => 'Ongoing';

  @override
  String get tripStatusCompleted => 'Completed';

  @override
  String get tripStatusCancelled => 'Cancelled';

  @override
  String get addNewTrip => 'Add New Trip';

  @override
  String get editTrip => 'Edit Trip';

  @override
  String get delete => 'Delete';

  @override
  String get loading => 'Loading...';

  @override
  String get authenticating => 'Authenticating...';

  @override
  String get connecting => 'Connecting...';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get thePageYoureLookingForDoesntExist =>
      'The page you\'re looking for doesn\'t exist.';

  @override
  String get networkError => 'Network Error';

  @override
  String get pleaseCheckYourInternetConnection =>
      'Please check your internet connection and try again.';

  @override
  String get serverError => 'Server Error';

  @override
  String get ourServersAreExperiencingIssues =>
      'Our servers are experiencing issues. Please try again later.';

  @override
  String get retry => 'Retry';

  @override
  String get goHome => 'Go Home';

  @override
  String get deleteTrip => 'Delete Trip';

  @override
  String deleteTripConfirmation(Object tripTitle) {
    return 'Are you sure you want to delete \"$tripTitle\"?';
  }

  @override
  String get tripTitle => 'Trip Title';

  @override
  String get updateTrip => 'Update Trip';

  @override
  String get description => 'Description';

  @override
  String get enterTripDescription => 'Enter trip description';

  @override
  String get enterDestination => 'Enter destination';

  @override
  String get selectStartDate => 'Select start date';

  @override
  String get selectEndDate => 'Select end date';

  @override
  String get enterBudget => 'Enter budget';

  @override
  String get pleaseEnterTripTitle => 'Please enter a trip title';

  @override
  String get pleaseEnterDescription => 'Please enter a description';

  @override
  String get pleaseEnterDestination => 'Please enter a destination';

  @override
  String get pleaseSelectStartDate => 'Please select a start date';

  @override
  String get pleaseSelectEndDate => 'Please select an end date';

  @override
  String get pleaseEnterBudget => 'Please enter a budget';

  @override
  String get pleaseEnterValidNumber => 'Please enter a valid number';

  @override
  String get toast_welcomeBack => 'Welcome back!';

  @override
  String get toast_invalidCredentials => 'Invalid email or password';

  @override
  String get toast_accountCreated => 'Account created successfully!';

  @override
  String get toast_signUpFailed => 'Failed to create account';

  @override
  String get toast_selectBothDates => 'Please select both start and end dates';

  @override
  String get toast_endDateAfterStart => 'End date must be after start date';

  @override
  String get toast_tripCreated => 'Trip created successfully!';

  @override
  String toast_tripError(Object error) {
    return 'Error: $error';
  }

  @override
  String get toast_unexpectedError => 'An unexpected error occurred';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_explore => 'Explore';

  @override
  String get nav_trips => 'Trips';

  @override
  String get nav_saved => 'Saved';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get viewYourTrips => 'View your trips';

  @override
  String get recentPlaces => 'Recent places';

  @override
  String get discover => 'Discover';

  @override
  String get savedPlaces => 'Saved places';

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get noRecentTrips => 'No recent trips';

  @override
  String get startPlanning => 'Start planning your next adventure';

  @override
  String get noTrips => 'No trips yet';

  @override
  String get discoverNewPlaces => 'Discover new places';

  @override
  String get favoriteDestinations => 'Your favorite destinations';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get tab_profile => 'Profile';

  @override
  String get tab_preferences => 'Preferences';

  @override
  String get tab_account => 'Account';

  @override
  String get notifications => 'Notifications';

  @override
  String get privacy => 'Privacy';

  @override
  String get notificationsSettings => 'Notifications Settings';

  @override
  String get manageNotifications => 'Manage your notification preferences';

  @override
  String get emailNotifications => 'Email Notifications';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get privacySettings => 'Privacy Settings';

  @override
  String get managePrivacy => 'Manage your privacy and data settings';

  @override
  String get dataUsage => 'Data Usage';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountWarning => 'This action cannot be undone';

  @override
  String get deleteAccountConfirmation =>
      'Are you sure you want to delete your account? All your data will be permanently removed.';

  @override
  String get failedToDeleteAccount => 'Failed to delete account';

  @override
  String get signInWithGoogle => 'Continue with Google';
}
