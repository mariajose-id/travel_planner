import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_id.dart';


abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('id'),
  ];

  String get appName;

  String get appTitle;

  String get auth_signIn;

  String get auth_signUp;

  String get auth_email;

  String get auth_password;

  String get auth_confirmPassword;

  String get auth_forgotPassword;

  String get auth_noAccount;

  String get auth_haveAccount;

  String get auth_signInErrorTitle;

  String get auth_signUpErrorTitle;

  String get home_welcome;

  String get home_upcomingTrips;

  String get home_recentlyViewed;

  String get errors_invalidEmail;

  String get errors_shortPassword;

  String get errors_passwordsDontMatch;

  String get errors_requiredField;

  String get errors_genericError;

  String get signInSubtitle;

  String get welcomeBack;

  String get createAccount;

  String get or;

  String get alreadyHaveAccount;

  String get fullName;

  String get enterFullName;

  String get enterEmail;

  String get enterPassword;

  String get confirmPassword;

  String get enterConfirmPassword;

  String get createAccountButton;

  String get signInButton;

  String get joinUsToStartPlanning;

  String get fillInDetails;

  String get journeyStartsHere;

  String get travelPlannerWelcome;

  String get signOut;

  String get failedToSignOut;

  String get settings;

  String get appSettings;

  String get termsOfService;

  String get privacyPolicy;

  String get contactUs;

  String get footerAddress;

  String get footerPhoneNumber;

  String get footerCompany;

  String get footerCommunity;

  String get footerOwnerCreator;

  String get save;

  String get allRightsReserved;

  String get createdBy;

  String get profile;

  String get manageYourProfile;

  String get preferences;

  String get theme;

  String get chooseTheme;

  String get language;

  String get chooseLanguage;

  String get account;

  String get signOutConfirmation;

  String get cancel;

  String get explore;

  String get favorites;

  String get yourTrips;

  String get errorLoadingTrips;

  String get noTripsYet;

  String get startPlanningNextAdventure;

  String get addTrip;

  String get totalTrips;

  String get totalBudget;

  String get planned;

  String get ongoing;

  String get completed;

  String get tripDetails;

  String get searchTrips;

  String get enterTripTitle;

  String get close;

  String get filterTrips;

  String get filterByStatus;

  String get clearFilters;

  String get tripNotFound;

  String get destination;

  String get budget;

  String get status;

  String get startDate;

  String get endDate;

  String get tags;

  String get tripStatusPlanned;

  String get tripStatusOngoing;

  String get tripStatusCompleted;

  String get tripStatusCancelled;

  String get addNewTrip;

  String get editTrip;

  String get delete;

  String get loading;

  String get authenticating;

  String get connecting;

  String get somethingWentWrong;

  String get pageNotFound;

  String get thePageYoureLookingForDoesntExist;

  String get networkError;

  String get pleaseCheckYourInternetConnection;

  String get serverError;

  String get ourServersAreExperiencingIssues;

  String get retry;

  String get goHome;

  String get deleteTrip;

  String deleteTripConfirmation(Object tripTitle);

  String get tripTitle;

  String get updateTrip;

  String get description;

  String get enterTripDescription;

  String get enterDestination;

  String get selectStartDate;

  String get selectEndDate;

  String get enterBudget;

  String get pleaseEnterTripTitle;

  String get pleaseEnterDescription;

  String get pleaseEnterDestination;

  String get pleaseSelectStartDate;

  String get pleaseSelectEndDate;

  String get pleaseEnterBudget;

  String get pleaseEnterValidNumber;

  String get toast_welcomeBack;

  String get toast_invalidCredentials;

  String get toast_accountCreated;

  String get toast_signUpFailed;

  String get toast_selectBothDates;

  String get toast_endDateAfterStart;

  String get toast_tripCreated;

  String toast_tripError(Object error);

  String get toast_unexpectedError;

  String get nav_home;

  String get nav_explore;

  String get nav_trips;

  String get nav_saved;

  String get quickActions;

  String get viewYourTrips;

  String get recentPlaces;

  String get discover;

  String get savedPlaces;

  String get recentActivity;

  String get noRecentTrips;

  String get startPlanning;

  String get noTrips;

  String get discoverNewPlaces;

  String get favoriteDestinations;

  String get themeLight;

  String get themeDark;

  String get themeSystem;

  String get tab_profile;

  String get tab_preferences;

  String get tab_account;

  String get notifications;

  String get privacy;

  String get notificationsSettings;

  String get manageNotifications;

  String get emailNotifications;

  String get pushNotifications;

  String get privacySettings;

  String get managePrivacy;

  String get dataUsage;

  String get deleteAccount;

  String get deleteAccountWarning;

  String get deleteAccountConfirmation;

  String get failedToDeleteAccount;

  String get signInWithGoogle;
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
