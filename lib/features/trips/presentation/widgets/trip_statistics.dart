import 'package:flutter/material.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/shared/widgets/stat_card.dart';

class TripStatistics extends StatelessWidget {
  final List<Trip> trips;
  const TripStatistics({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    final totalBudget = trips.fold(
      0.0,
      (sum, trip) => sum + trip.budget.amount,
    );
    final upcomingTrips = trips
        .where((trip) => trip.status == TripStatus.upcoming)
        .length;
    final completedTrips = trips
        .where((trip) => trip.status == TripStatus.completed)
        .length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5,
        children: [
          StatCard(
            title: context.l10n.label_total_trips,
            value: trips.length.toString(),
            icon: Icons.public,
            color: context.colorScheme.primary,
          ),
          StatCard(
            title: context.l10n.label_total_budget,
            value: '\$${_formatBudget(totalBudget)}',
            icon: Icons.account_balance_wallet_outlined,
            color: context.colorScheme.secondary,
          ),
          StatCard(
            title: context.l10n.label_status_ongoing,
            value: '$upcomingTrips',
            icon: Icons.upcoming_outlined,
            color: Colors.orange,
          ),
          StatCard(
            title: context.l10n.label_status_completed,
            value: '$completedTrips',
            icon: Icons.check_circle_outline,
            color: Colors.green,
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
