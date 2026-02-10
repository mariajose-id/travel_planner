import 'package:flutter/material.dart';
import 'package:travel_planner/core/result/result.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

extension ErrorMapper on DomainError {
  /// Maps a DomainError code to a localized string from [AppLocalizations].
  String toLocalizedMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    switch (code) {
      // Auth Errors
      case 'INVALID_CREDENTIALS':
        return l10n.error_invalid_credentials;
      case 'EMAIL_EXISTS':
        return l10n.error_email_exists;
      case 'USER_NOT_FOUND':
        return l10n.error_user_not_found;
      case 'INVALID_EMAIL':
        return l10n.error_invalid_email;
      case 'SHORT_PASSWORD':
        return l10n.error_short_password;
      case 'PASSWORDS_DONT_MATCH':
        return l10n.error_passwords_dont_match;
      case 'REGISTER_FAILED':
        return l10n.error_generic;
      case 'LOGIN_FAILED':
        return l10n.error_invalid_credentials;
      case 'REQUIRED_FIELD':
        return l10n.error_required_field;
      case 'NO_USER_LOGGED_IN':
        return l10n.action_sign_in; // Prompt to sign in

      // Network & Server
      case 'NETWORK_ERROR':
        return l10n.error_network;
      case 'SERVER_ERROR':
        return l10n.error_server;
      case 'TIMEOUT':
        return l10n.error_timeout;

      // Generic
      case 'UNKNOWN':
      default:
        // If the message is already localized or if there's no mapping,
        // we fallback to the raw message or a generic error.
        if (message.isNotEmpty && message != code) {
          return message;
        }
        return l10n.error_something_went_wrong;
    }
  }
}
