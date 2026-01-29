import 'package:flutter/material.dart';
import 'package:travel_planner/features/trips/models/trip.dart';
import 'package:travel_planner/features/trips/widgets/trip_card.dart';
import 'package:travel_planner/core/theme/app_spacing.dart';
class TripList extends StatelessWidget {
  final List<Trip> trips;
  final Function(Trip) onTripTap;
  final Function(Trip) onEdit;
  final Function(Trip) onDelete;
  const TripList({
    super.key,
    required this.trips,
    required this.onTripTap,
    required this.onEdit,
    required this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: AppSpacing.paddingMD,
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TripCard(
            trip: trip,
            onTap: () => onTripTap(trip),
            onEdit: () => onEdit(trip),
            onDelete: () => onDelete(trip),
          ),
        );
      },
    );
  }
}
