import 'package:flutter/material.dart';
import 'package:travel_planner/core/theme/app_spacing.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
class LoadingScreen extends StatelessWidget {
  final String? message;
  final Color? backgroundColor;
  final Color? iconColor;
  const LoadingScreen({
    super.key,
    this.message,
    this.backgroundColor,
    this.iconColor,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      body: Center(
        child: Container(
          padding: AppSpacing.paddingMD,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: AppSpacing.paddingMD,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    iconColor ?? theme.colorScheme.primary,
                  ),
                ),
                AppSpacing.verticalGapMD,
                Text(
                  message ?? localizations.loading,
                  style: context.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class AuthLoadingScreen extends StatelessWidget {
  const AuthLoadingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return LoadingScreen(
      message: localizations.authenticating,
    );
  }
}
class TripLoadingScreen extends StatelessWidget {
  const TripLoadingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return LoadingScreen(
      message: localizations.loading,
    );
  }
}
class NetworkLoadingScreen extends StatelessWidget {
  const NetworkLoadingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return LoadingScreen(
      message: localizations.connecting,
    );
  }
}
