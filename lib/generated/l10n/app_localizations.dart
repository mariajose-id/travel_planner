import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('id'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Travel Planner'**
  String get app_title;

  /// No description provided for @toast_account_created.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get toast_account_created;

  /// No description provided for @label_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get label_email;

  /// No description provided for @label_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get label_password;

  /// No description provided for @label_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get label_confirm_password;

  /// No description provided for @label_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get label_welcome;

  /// No description provided for @heading_upcoming_trips.
  ///
  /// In en, this message translates to:
  /// **'My Trips'**
  String get heading_upcoming_trips;

  /// No description provided for @heading_recently_viewed.
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed'**
  String get heading_recently_viewed;

  /// No description provided for @error_invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get error_invalid_email;

  /// No description provided for @error_short_password.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get error_short_password;

  /// No description provided for @error_passwords_dont_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get error_passwords_dont_match;

  /// No description provided for @error_required_field.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get error_required_field;

  /// No description provided for @error_generic.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get error_generic;

  /// No description provided for @error_email_exists.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists'**
  String get error_email_exists;

  /// No description provided for @error_user_not_found.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get error_user_not_found;

  /// No description provided for @heading_sign_in_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get heading_sign_in_subtitle;

  /// No description provided for @heading_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get heading_welcome_back;

  /// No description provided for @heading_create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get heading_create_account;

  /// No description provided for @label_or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get label_or;

  /// No description provided for @label_already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have account? Sign In'**
  String get label_already_have_account;

  /// No description provided for @label_full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get label_full_name;

  /// No description provided for @hint_enter_full_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get hint_enter_full_name;

  /// No description provided for @hint_enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get hint_enter_email;

  /// No description provided for @hint_enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get hint_enter_password;

  /// No description provided for @hint_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get hint_confirm_password;

  /// No description provided for @action_create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get action_create_account;

  /// No description provided for @action_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get action_sign_in;

  /// No description provided for @heading_fill_details.
  ///
  /// In en, this message translates to:
  /// **'Fill in your details to get started'**
  String get heading_fill_details;

  /// No description provided for @heading_journey_starts.
  ///
  /// In en, this message translates to:
  /// **'Your journey starts here'**
  String get heading_journey_starts;

  /// No description provided for @action_sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get action_sign_out;

  /// No description provided for @heading_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get heading_settings;

  /// No description provided for @heading_app_settings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get heading_app_settings;

  /// No description provided for @label_terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get label_terms_of_service;

  /// No description provided for @label_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get label_privacy_policy;

  /// No description provided for @label_contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get label_contact_us;

  /// No description provided for @action_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get action_cancel;

  /// No description provided for @action_select_date.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get action_select_date;

  /// No description provided for @tab_explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get tab_explore;

  /// No description provided for @tab_favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get tab_favorites;

  /// No description provided for @tab_your_trips.
  ///
  /// In en, this message translates to:
  /// **'Your Trips'**
  String get tab_your_trips;

  /// No description provided for @error_loading_trips.
  ///
  /// In en, this message translates to:
  /// **'Error loading trips'**
  String get error_loading_trips;

  /// No description provided for @label_no_recent_trips.
  ///
  /// In en, this message translates to:
  /// **'No recent trips'**
  String get label_no_recent_trips;

  /// No description provided for @label_start_planning.
  ///
  /// In en, this message translates to:
  /// **'Start planning your next adventure'**
  String get label_start_planning;

  /// No description provided for @action_add_trip.
  ///
  /// In en, this message translates to:
  /// **'Add Trip'**
  String get action_add_trip;

  /// No description provided for @label_total_trips.
  ///
  /// In en, this message translates to:
  /// **'Total Trips'**
  String get label_total_trips;

  /// No description provided for @label_total_budget.
  ///
  /// In en, this message translates to:
  /// **'Total Budget'**
  String get label_total_budget;

  /// No description provided for @label_status_planned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get label_status_planned;

  /// No description provided for @label_status_ongoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get label_status_ongoing;

  /// No description provided for @label_status_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get label_status_completed;

  /// No description provided for @heading_trip_details.
  ///
  /// In en, this message translates to:
  /// **'Trip Details'**
  String get heading_trip_details;

  /// No description provided for @action_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get action_close;

  /// No description provided for @label_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get label_description;

  /// No description provided for @hint_enter_trip_description.
  ///
  /// In en, this message translates to:
  /// **'Enter trip description'**
  String get hint_enter_trip_description;

  /// No description provided for @label_destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get label_destination;

  /// No description provided for @hint_enter_destination.
  ///
  /// In en, this message translates to:
  /// **'Enter destination'**
  String get hint_enter_destination;

  /// No description provided for @label_start_date.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get label_start_date;

  /// No description provided for @label_end_date.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get label_end_date;

  /// No description provided for @label_budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get label_budget;

  /// No description provided for @label_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get label_status;

  /// No description provided for @action_add_new_trip.
  ///
  /// In en, this message translates to:
  /// **'Add New Trip'**
  String get action_add_new_trip;

  /// No description provided for @heading_edit_trip.
  ///
  /// In en, this message translates to:
  /// **'Edit Trip'**
  String get heading_edit_trip;

  /// No description provided for @action_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get action_edit;

  /// No description provided for @action_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get action_delete;

  /// No description provided for @action_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get action_retry;

  /// No description provided for @label_trip_title.
  ///
  /// In en, this message translates to:
  /// **'Trip Title'**
  String get label_trip_title;

  /// No description provided for @action_update_trip.
  ///
  /// In en, this message translates to:
  /// **'Update Trip'**
  String get action_update_trip;

  /// No description provided for @hint_enter_trip_title.
  ///
  /// In en, this message translates to:
  /// **'Enter trip title'**
  String get hint_enter_trip_title;

  /// No description provided for @error_invalid_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get error_invalid_number;

  /// No description provided for @toast_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get toast_welcome_back;

  /// No description provided for @error_invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get error_invalid_credentials;

  /// No description provided for @toast_trip_created.
  ///
  /// In en, this message translates to:
  /// **'Trip created successfully'**
  String get toast_trip_created;

  /// No description provided for @error_trip_generic.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error_trip_generic(String error);

  /// No description provided for @error_end_date_after_start.
  ///
  /// In en, this message translates to:
  /// **'End date must be after start date'**
  String get error_end_date_after_start;

  /// No description provided for @error_select_both_dates.
  ///
  /// In en, this message translates to:
  /// **'Please select both start and end dates'**
  String get error_select_both_dates;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get nav_explore;

  /// No description provided for @nav_trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get nav_trips;

  /// No description provided for @nav_saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get nav_saved;

  /// No description provided for @heading_quick_actions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get heading_quick_actions;

  /// No description provided for @label_view_your_trips.
  ///
  /// In en, this message translates to:
  /// **'View your trips'**
  String get label_view_your_trips;

  /// No description provided for @heading_recent_places.
  ///
  /// In en, this message translates to:
  /// **'Recent places'**
  String get heading_recent_places;

  /// No description provided for @heading_saved_places.
  ///
  /// In en, this message translates to:
  /// **'Saved places'**
  String get heading_saved_places;

  /// No description provided for @heading_recent_activity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get heading_recent_activity;

  /// No description provided for @heading_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get heading_profile;

  /// No description provided for @label_coming_soon.
  ///
  /// In en, this message translates to:
  /// **'{feature} - Coming Soon'**
  String label_coming_soon(String feature);

  /// No description provided for @label_status_planned_tag.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get label_status_planned_tag;

  /// No description provided for @label_status_ongoing_tag.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get label_status_ongoing_tag;

  /// No description provided for @label_status_completed_tag.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get label_status_completed_tag;

  /// No description provided for @label_status_cancelled_tag.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get label_status_cancelled_tag;

  /// No description provided for @action_sign_in_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get action_sign_in_google;

  /// No description provided for @tab_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tab_profile;

  /// No description provided for @tab_preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get tab_preferences;

  /// No description provided for @tab_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get tab_account;

  /// No description provided for @label_manage_profile.
  ///
  /// In en, this message translates to:
  /// **'Manage your profile and preferences'**
  String get label_manage_profile;

  /// No description provided for @label_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get label_theme;

  /// No description provided for @label_choose_theme.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme'**
  String get label_choose_theme;

  /// No description provided for @label_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get label_notifications;

  /// No description provided for @label_manage_notifications.
  ///
  /// In en, this message translates to:
  /// **'Manage your notification preferences'**
  String get label_manage_notifications;

  /// No description provided for @label_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get label_privacy;

  /// No description provided for @label_manage_privacy.
  ///
  /// In en, this message translates to:
  /// **'Manage your privacy and data settings'**
  String get label_manage_privacy;

  /// No description provided for @label_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get label_language;

  /// No description provided for @dialog_sign_out_title.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get dialog_sign_out_title;

  /// No description provided for @action_delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get action_delete_account;

  /// No description provided for @label_delete_account_warning.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone'**
  String get label_delete_account_warning;

  /// No description provided for @error_failed_sign_out.
  ///
  /// In en, this message translates to:
  /// **'Failed to sign out'**
  String get error_failed_sign_out;

  /// No description provided for @dialog_delete_account_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? All your data will be permanently removed.'**
  String get dialog_delete_account_confirm;

  /// No description provided for @error_failed_delete_account.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account'**
  String get error_failed_delete_account;

  /// No description provided for @action_delete_trip.
  ///
  /// In en, this message translates to:
  /// **'Delete Trip'**
  String get action_delete_trip;

  /// No description provided for @dialog_delete_trip_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{tripTitle}\"?'**
  String dialog_delete_trip_confirm(String tripTitle);

  /// No description provided for @label_no_trips.
  ///
  /// In en, this message translates to:
  /// **'No trips yet'**
  String get label_no_trips;

  /// No description provided for @error_something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error_something_went_wrong;

  /// No description provided for @action_go_home.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get action_go_home;

  /// No description provided for @heading_page_not_found.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get heading_page_not_found;

  /// No description provided for @label_page_not_found_desc.
  ///
  /// In en, this message translates to:
  /// **'The page you\'re looking for doesn\'t exist.'**
  String get label_page_not_found_desc;

  /// No description provided for @label_theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get label_theme_light;

  /// No description provided for @label_theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get label_theme_dark;

  /// No description provided for @label_theme_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get label_theme_system;

  /// No description provided for @error_network.
  ///
  /// In en, this message translates to:
  /// **'Network Error'**
  String get error_network;

  /// No description provided for @error_network_desc.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get error_network_desc;

  /// No description provided for @error_server.
  ///
  /// In en, this message translates to:
  /// **'Server Error'**
  String get error_server;

  /// No description provided for @error_server_desc.
  ///
  /// In en, this message translates to:
  /// **'Our servers are experiencing issues. Please try again later.'**
  String get error_server_desc;

  /// No description provided for @error_unknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get error_unknown;

  /// No description provided for @error_timeout.
  ///
  /// In en, this message translates to:
  /// **'Request timed out'**
  String get error_timeout;

  /// No description provided for @toast_success_generic.
  ///
  /// In en, this message translates to:
  /// **'Operation completed successfully'**
  String get toast_success_generic;

  /// No description provided for @heading_personal_info.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get heading_personal_info;

  /// No description provided for @label_email_simple.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get label_email_simple;

  /// No description provided for @label_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get label_name;

  /// No description provided for @hint_enter_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get hint_enter_name;

  /// No description provided for @heading_edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get heading_edit_profile;

  /// No description provided for @action_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get action_save;

  /// No description provided for @toast_welcome_to_wanderly.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Wanderly!'**
  String get toast_welcome_to_wanderly;

  /// No description provided for @heading_sign_up_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Join our community of travelers'**
  String get heading_sign_up_subtitle;

  /// No description provided for @heading_create_trip.
  ///
  /// In en, this message translates to:
  /// **'Create Trip'**
  String get heading_create_trip;

  /// No description provided for @hint_enter_description.
  ///
  /// In en, this message translates to:
  /// **'Enter trip description'**
  String get hint_enter_description;

  /// No description provided for @hint_enter_budget.
  ///
  /// In en, this message translates to:
  /// **'Enter your budget'**
  String get hint_enter_budget;

  /// No description provided for @action_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get action_create;

  /// No description provided for @action_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get action_sign_up;

  /// No description provided for @label_confirm_password_simple.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get label_confirm_password_simple;

  /// No description provided for @hint_confirm_password_simple.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get hint_confirm_password_simple;

  /// No description provided for @error_invalid_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid name'**
  String get error_invalid_name;

  /// No description provided for @label_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get label_all;

  /// No description provided for @heading_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get heading_welcome;

  /// No description provided for @label_profile_updated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get label_profile_updated;

  /// No description provided for @label_no_changes.
  ///
  /// In en, this message translates to:
  /// **'No changes to save'**
  String get label_no_changes;

  /// No description provided for @error_update_profile.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get error_update_profile;

  /// No description provided for @nav_lists.
  ///
  /// In en, this message translates to:
  /// **'My Lists'**
  String get nav_lists;

  /// No description provided for @label_currency_converter.
  ///
  /// In en, this message translates to:
  /// **'Converter'**
  String get label_currency_converter;

  /// No description provided for @heading_trip_lists.
  ///
  /// In en, this message translates to:
  /// **'Trip Lists'**
  String get heading_trip_lists;

  /// No description provided for @label_no_lists.
  ///
  /// In en, this message translates to:
  /// **'No lists yet'**
  String get label_no_lists;

  /// No description provided for @label_add_note.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get label_add_note;

  /// No description provided for @label_add_checklist.
  ///
  /// In en, this message translates to:
  /// **'Add Checklist'**
  String get label_add_checklist;

  /// No description provided for @hint_note_title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get hint_note_title;

  /// No description provided for @hint_note_content.
  ///
  /// In en, this message translates to:
  /// **'Write something...'**
  String get hint_note_content;

  /// No description provided for @hint_checklist_item.
  ///
  /// In en, this message translates to:
  /// **'New item'**
  String get hint_checklist_item;

  /// No description provided for @label_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get label_notes;

  /// No description provided for @label_checklists.
  ///
  /// In en, this message translates to:
  /// **'Checklists'**
  String get label_checklists;

  /// No description provided for @action_delete_note.
  ///
  /// In en, this message translates to:
  /// **'Delete Note'**
  String get action_delete_note;

  /// No description provided for @dialog_delete_note_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this note?'**
  String get dialog_delete_note_confirm;

  /// No description provided for @label_hello.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String label_hello(String name);

  /// No description provided for @heading_account_actions.
  ///
  /// In en, this message translates to:
  /// **'Account Actions'**
  String get heading_account_actions;

  /// No description provided for @heading_developer_tools.
  ///
  /// In en, this message translates to:
  /// **'Developer Tools'**
  String get heading_developer_tools;

  /// No description provided for @label_wanderly_console.
  ///
  /// In en, this message translates to:
  /// **'Wanderly Console'**
  String get label_wanderly_console;

  /// No description provided for @label_wanderly_console_desc.
  ///
  /// In en, this message translates to:
  /// **'Inspect system logs and diagnostics'**
  String get label_wanderly_console_desc;

  /// No description provided for @toast_account_deleted.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully'**
  String get toast_account_deleted;

  /// No description provided for @error_failed_delete_account_full.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account: {error}'**
  String error_failed_delete_account_full(String error);

  /// No description provided for @label_manage_data.
  ///
  /// In en, this message translates to:
  /// **'Manage device permissions'**
  String get label_manage_data;

  /// No description provided for @label_verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get label_verified;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
