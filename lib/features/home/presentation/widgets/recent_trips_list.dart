import 'package:flutter/material.dart';
import 'package:travel_planner/features/trips/presentation/dtos/trip_dto.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_card.dart';
import 'package:travel_planner/features/trips/presentation/providers/trip_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:travel_planner/features/trips/presentation/widgets/trip_dialogs.dart';

class RecentTripsList extends ConsumerWidget {
  final List<TripDto> trips;
  final Function(TripDto) onTripTap;

  const RecentTripsList({
    super.key,
    required this.trips,
    required this.onTripTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentTrips = trips.take(5).toList();
    final tripNotifier = ref.read(tripsProvider.notifier);

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentTrips.length,
      itemBuilder: (context, index) {
        final dto = recentTrips[index];
        return TripCard(
          trip: dto,
          showActions: false,
          onTap: () => onTripTap(dto),
          onEdit: () {
            TripDialogs.showEditTripDialog(
              context,
              dto.trip,
              tripNotifier.updateTrip,
            );
          },
          onDelete: () {
            TripDialogs.showDeleteConfirmation(
              context,
              dto.trip,
              tripNotifier.deleteTrip,
            );
          },
        );
      },
    );
  }
}
