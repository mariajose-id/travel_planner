import 'package:flutter/material.dart';
import 'package:travel_planner/features/trips/models/trip.dart';
import 'package:travel_planner/shared/widgets/section_card.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/core/theme/app_spacing.dart';

class TripStatistics extends StatelessWidget {
  final List<Trip> trips;
  const TripStatistics({
    super.key,
    required this.trips,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalBudget = trips.fold(0.0, (sum, trip) => sum + trip.budget);
    final upcomingTrips = trips.where((trip) => 
      trip.status.toLowerCase() == 'planned' || trip.status.toLowerCase() == 'ongoing'
    ).length;
    final completedTrips = trips.where((trip) => 
      trip.status.toLowerCase() == 'completed'
    ).length;
    
    return SectionCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Main stats row
          Row(
            children: [
              Expanded(
                child: _buildModernStatCard(
                  context,
                  'Total Trips',
                  '${trips.length}',
                  Icons.flight_takeoff_outlined,
                  theme.colorScheme.primary,
                  'All your adventures',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildModernStatCard(
                  context,
                  'Total Budget',
                  '\$${_formatBudget(totalBudget)}',
                  Icons.account_balance_wallet_outlined,
                  theme.colorScheme.secondary,
                  'Combined trip costs',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Secondary stats row
          Row(
            children: [
              Expanded(
                child: _buildModernStatCard(
                  context,
                  'Upcoming',
                  '$upcomingTrips',
                  Icons.upcoming_outlined,
                  Colors.orange,
                  'Planned & ongoing',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildModernStatCard(
                  context,
                  'Completed',
                  '$completedTrips',
                  Icons.check_circle_outline,
                  Colors.green,
                  'Finished trips',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildModernStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.04),
            color.withValues(alpha: 0.01),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: context.titleMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 1),
          Text(
            title,
            style: context.bodySmall.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  
  String _formatBudget(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }
}
