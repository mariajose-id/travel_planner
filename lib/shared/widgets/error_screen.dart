import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/theme/app_spacing.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
class ErrorScreen extends StatelessWidget {
  final String? title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final IconData? icon;
  const ErrorScreen({
    super.key,
    this.title,
    this.message,
    this.buttonText,
    this.onButtonPressed,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.errorContainer,
      body: Center(
        child: Padding(
          padding: AppSpacing.paddingLG,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon ?? Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
              AppSpacing.verticalGapMD,
              Text(
                title ?? localizations.somethingWentWrong,
                textAlign: TextAlign.center,
                style: context.headlineMedium.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.verticalGapSM,
              Text(
                message ?? localizations.errors_genericError,
                textAlign: TextAlign.center,
                style: context.bodyMedium.copyWith(
                  color: theme.colorScheme.onErrorContainer.withValues(alpha: 0.7),
                ),
              ),
              AppSpacing.verticalGapLG,
              if (onButtonPressed != null) ...[
                ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(buttonText ?? localizations.goHome),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: () => context.go('/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(localizations.goHome),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return ErrorScreen(
      title: localizations.pageNotFound,
      message: localizations.thePageYoureLookingForDoesntExist,
      buttonText: localizations.goHome,
      icon: Icons.error_outline,
    );
  }
}
class NetworkErrorScreen extends StatelessWidget {
  const NetworkErrorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return ErrorScreen(
      title: localizations.networkError,
      message: localizations.pleaseCheckYourInternetConnection,
      buttonText: localizations.retry,
      icon: Icons.wifi_off,
    );
  }
}
class ServerErrorScreen extends StatelessWidget {
  const ServerErrorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return ErrorScreen(
      title: localizations.serverError,
      message: localizations.ourServersAreExperiencingIssues,
      buttonText: localizations.retry,
      icon: Icons.cloud_off,
    );
  }
}
