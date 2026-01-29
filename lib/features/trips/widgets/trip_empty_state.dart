import 'package:flutter/material.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/core/theme/app_spacing.dart';
class TripEmptyState extends StatelessWidget {
  final VoidCallback? onAddTrip;
  const TripEmptyState({super.key, this.onAddTrip});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flight_takeoff_outlined,
            size: 80,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          AppSpacing.verticalGapXL,
          Text(
            AppLocalizations.of(context).noTrips,
            style: context.titleLarge.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          AppSpacing.verticalGapSM,
          Text(
            AppLocalizations.of(context).startPlanning,
            style: context.bodyMedium.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalGapLG,
          ElevatedButton.icon(
            onPressed: onAddTrip,
            icon: const Icon(Icons.add),
            label: Text(AppLocalizations.of(context).addTrip),
          ),
        ],
      ),
    );
  }
}
