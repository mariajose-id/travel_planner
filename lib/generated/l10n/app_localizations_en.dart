// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Travel Planner';

  @override
  String get toast_account_created => 'Account created successfully';

  @override
  String get label_email => 'Email';

  @override
  String get label_password => 'Password';

  @override
  String get label_confirm_password => 'Confirm Password';

  @override
  String get label_welcome => 'Welcome';

  @override
  String get heading_upcoming_trips => 'My Trips';

  @override
  String get heading_recently_viewed => 'Recently Viewed';

  @override
  String get error_invalid_email => 'Please enter a valid email address';

  @override
  String get error_short_password => 'Password must be at least 6 characters';

  @override
  String get error_passwords_dont_match => 'Passwords don\'t match';

  @override
  String get error_required_field => 'This field is required';

  @override
  String get error_generic => 'An error occurred. Please try again.';

  @override
  String get error_email_exists => 'An account with this email already exists';

  @override
  String get error_user_not_found => 'User not found';

  @override
  String get heading_sign_in_subtitle => 'Sign in to continue';

  @override
  String get heading_welcome_back => 'Welcome Back';

  @override
  String get heading_create_account => 'Create Account';

  @override
  String get label_or => 'OR';

  @override
  String get label_already_have_account => 'Already have account? Sign In';

  @override
  String get label_full_name => 'Full Name';

  @override
  String get hint_enter_full_name => 'Enter your full name';

  @override
  String get hint_enter_email => 'Enter your email';

  @override
  String get hint_enter_password => 'Enter your password';

  @override
  String get hint_confirm_password => 'Confirm your password';

  @override
  String get action_create_account => 'Create Account';

  @override
  String get action_sign_in => 'Sign In';

  @override
  String get heading_fill_details => 'Fill in your details to get started';

  @override
  String get heading_journey_starts => 'Your journey starts here';

  @override
  String get action_sign_out => 'Sign Out';

  @override
  String get heading_settings => 'Settings';

  @override
  String get heading_app_settings => 'App Settings';

  @override
  String get label_terms_of_service => 'Terms of Service';

  @override
  String get label_privacy_policy => 'Privacy Policy';

  @override
  String get label_contact_us => 'Contact Us';

  @override
  String get action_cancel => 'Cancel';

  @override
  String get action_select_date => 'Select a date';

  @override
  String get tab_explore => 'Explore';

  @override
  String get tab_favorites => 'Favorites';

  @override
  String get tab_your_trips => 'Your Trips';

  @override
  String get error_loading_trips => 'Error loading trips';

  @override
  String get label_no_recent_trips => 'No recent trips';

  @override
  String get label_start_planning => 'Start planning your next adventure';

  @override
  String get action_add_trip => 'Add Trip';

  @override
  String get label_total_trips => 'Total Trips';

  @override
  String get label_total_budget => 'Total Budget';

  @override
  String get label_status_planned => 'Planned';

  @override
  String get label_status_ongoing => 'Ongoing';

  @override
  String get label_status_completed => 'Completed';

  @override
  String get heading_trip_details => 'Trip Details';

  @override
  String get action_close => 'Close';

  @override
  String get label_description => 'Description';

  @override
  String get hint_enter_trip_description => 'Enter trip description';

  @override
  String get label_destination => 'Destination';

  @override
  String get hint_enter_destination => 'Enter destination';

  @override
  String get label_start_date => 'Start Date';

  @override
  String get label_end_date => 'End Date';

  @override
  String get label_budget => 'Budget';

  @override
  String get label_status => 'Status';

  @override
  String get action_add_new_trip => 'Add New Trip';

  @override
  String get heading_edit_trip => 'Edit Trip';

  @override
  String get action_edit => 'Edit';

  @override
  String get action_delete => 'Delete';

  @override
  String get action_retry => 'Retry';

  @override
  String get label_trip_title => 'Trip Title';

  @override
  String get action_update_trip => 'Update Trip';

  @override
  String get hint_enter_trip_title => 'Enter trip title';

  @override
  String get error_invalid_number => 'Please enter a valid number';

  @override
  String get toast_welcome_back => 'Welcome back';

  @override
  String get error_invalid_credentials => 'Invalid email or password';

  @override
  String get toast_trip_created => 'Trip created successfully';

  @override
  String error_trip_generic(String error) {
    return 'Error: $error';
  }

  @override
  String get error_end_date_after_start => 'End date must be after start date';

  @override
  String get error_select_both_dates =>
      'Please select both start and end dates';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_explore => 'Explore';

  @override
  String get nav_trips => 'Trips';

  @override
  String get nav_saved => 'Saved';

  @override
  String get heading_quick_actions => 'Quick Actions';

  @override
  String get label_view_your_trips => 'View your trips';

  @override
  String get heading_recent_places => 'Recent places';

  @override
  String get heading_saved_places => 'Saved places';

  @override
  String get heading_recent_activity => 'Recent Activity';

  @override
  String get heading_profile => 'Profile';

  @override
  String label_coming_soon(String feature) {
    return '$feature - Coming Soon';
  }

  @override
  String get label_status_planned_tag => 'Planned';

  @override
  String get label_status_ongoing_tag => 'Ongoing';

  @override
  String get label_status_completed_tag => 'Completed';

  @override
  String get label_status_cancelled_tag => 'Cancelled';

  @override
  String get action_sign_in_google => 'Continue with Google';

  @override
  String get tab_profile => 'Profile';

  @override
  String get tab_preferences => 'Preferences';

  @override
  String get tab_account => 'Account';

  @override
  String get label_manage_profile => 'Manage your profile and preferences';

  @override
  String get label_theme => 'Theme';

  @override
  String get label_choose_theme => 'Choose your preferred theme';

  @override
  String get label_notifications => 'Notifications';

  @override
  String get label_manage_notifications =>
      'Manage your notification preferences';

  @override
  String get label_privacy => 'Privacy';

  @override
  String get label_manage_privacy => 'Manage your privacy and data settings';

  @override
  String get label_language => 'Language';

  @override
  String get dialog_sign_out_title => 'Are you sure you want to sign out?';

  @override
  String get action_delete_account => 'Delete Account';

  @override
  String get label_delete_account_warning => 'This action cannot be undone';

  @override
  String get error_failed_sign_out => 'Failed to sign out';

  @override
  String get dialog_delete_account_confirm =>
      'Are you sure you want to delete your account? All your data will be permanently removed.';

  @override
  String get error_failed_delete_account => 'Failed to delete account';

  @override
  String get action_delete_trip => 'Delete Trip';

  @override
  String dialog_delete_trip_confirm(String tripTitle) {
    return 'Are you sure you want to delete \"$tripTitle\"?';
  }

  @override
  String get label_no_trips => 'No trips yet';

  @override
  String get error_something_went_wrong => 'Something went wrong';

  @override
  String get action_go_home => 'Go Home';

  @override
  String get heading_page_not_found => 'Page not found';

  @override
  String get label_page_not_found_desc =>
      'The page you\'re looking for doesn\'t exist.';

  @override
  String get label_theme_light => 'Light';

  @override
  String get label_theme_dark => 'Dark';

  @override
  String get label_theme_system => 'System';

  @override
  String get error_network => 'Network Error';

  @override
  String get error_network_desc =>
      'Please check your internet connection and try again.';

  @override
  String get error_server => 'Server Error';

  @override
  String get error_server_desc =>
      'Our servers are experiencing issues. Please try again later.';

  @override
  String get error_unknown => 'An unknown error occurred';

  @override
  String get error_timeout => 'Request timed out';

  @override
  String get toast_success_generic => 'Operation completed successfully';

  @override
  String get heading_personal_info => 'Personal Information';

  @override
  String get label_email_simple => 'Email';

  @override
  String get label_name => 'Name';

  @override
  String get hint_enter_name => 'Enter your name';

  @override
  String get heading_edit_profile => 'Edit Profile';

  @override
  String get action_save => 'Save';

  @override
  String get toast_welcome_to_wanderly => 'Welcome to Wanderly!';

  @override
  String get heading_sign_up_subtitle => 'Join our community of travelers';

  @override
  String get heading_create_trip => 'Create Trip';

  @override
  String get hint_enter_description => 'Enter trip description';

  @override
  String get hint_enter_budget => 'Enter your budget';

  @override
  String get action_create => 'Create';

  @override
  String get action_sign_up => 'Sign Up';

  @override
  String get label_confirm_password_simple => 'Confirm Password';

  @override
  String get hint_confirm_password_simple => 'Confirm your password';

  @override
  String get error_invalid_name => 'Please enter a valid name';

  @override
  String get label_all => 'All';

  @override
  String get heading_welcome => 'Welcome';

  @override
  String get label_profile_updated => 'Profile updated successfully';

  @override
  String get label_no_changes => 'No changes to save';

  @override
  String get error_update_profile => 'Failed to update profile';

  @override
  String get nav_lists => 'My Lists';

  @override
  String get label_currency_converter => 'Converter';

  @override
  String get heading_trip_lists => 'Trip Lists';

  @override
  String get label_no_lists => 'No lists yet';

  @override
  String get label_add_note => 'Add Note';

  @override
  String get label_add_checklist => 'Add Checklist';

  @override
  String get hint_note_title => 'Title';

  @override
  String get hint_note_content => 'Write something...';

  @override
  String get hint_checklist_item => 'New item';

  @override
  String get label_notes => 'Notes';

  @override
  String get label_checklists => 'Checklists';

  @override
  String get action_delete_note => 'Delete Note';

  @override
  String get dialog_delete_note_confirm =>
      'Are you sure you want to delete this note?';

  @override
  String label_hello(String name) {
    return 'Hello, $name';
  }

  @override
  String get heading_account_actions => 'Account Actions';

  @override
  String get heading_developer_tools => 'Developer Tools';

  @override
  String get label_wanderly_console => 'Wanderly Console';

  @override
  String get label_wanderly_console_desc =>
      'Inspect system logs and diagnostics';

  @override
  String get toast_account_deleted => 'Account deleted successfully';

  @override
  String error_failed_delete_account_full(String error) {
    return 'Failed to delete account: $error';
  }

  @override
  String get label_manage_data => 'Manage device permissions';

  @override
  String get label_verified => 'Verified';
}
