import 'package:flutter/material.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/core/theme/app_typography.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/launcher_icon.png',
                height: 40,
                width: 40,
              ),
              const SizedBox(width: 12),
              Text(
                localizations.appName,
                style: context.titleMedium.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            localizations.footerAddress,
            textAlign: TextAlign.center,
            style: context.bodySmall.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            localizations.footerPhoneNumber,
            textAlign: TextAlign.center,
            style: context.bodySmall.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegalLink(
                context,
                localizations.termsOfService,
                'https://travelplanner.com/terms',
              ),
              _buildLegalLink(
                context,
                localizations.privacyPolicy,
                'https://travelplanner.com/privacy',
              ),
              _buildLegalLink(
                context,
                localizations.contactUs,
                'mailto:support@travelplanner.com',
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Column(
            children: [
              Text(
                localizations.footerCompany,
                textAlign: TextAlign.center,
                style: context.bodySmall.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                localizations.footerCommunity,
                textAlign: TextAlign.center,
                style: context.bodySmall.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${localizations.createdBy} ${localizations.footerOwnerCreator}',
                textAlign: TextAlign.center,
                style: context.bodySmall.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '© ${DateTime.now().year} ${localizations.appName}. ${localizations.allRightsReserved}',
            textAlign: TextAlign.center,
            style: context.bodySmall.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalLink(BuildContext context, String text, String url) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: () {
      },
      child: Text(
        text,
        style: context.bodySmall.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
