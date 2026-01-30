import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/features/trips/controllers/trip_controller.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/widgets/trip_dialogs.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/features/trips/widgets/trip_card.dart';

class TripDetailScreen extends StatefulWidget {
  const TripDetailScreen({super.key});

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  VoidCallback? _onRefreshCallback;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onRefreshCallback ??= GoRouterState.of(context).extra as VoidCallback?;
  }

  void _showEditTripDialog(BuildContext context, Trip trip) {
    TripDialogs.showEditTripDialog(context, trip, (updatedTrip) async {
      await context.read<TripController>().updateTrip(updatedTrip);
      _onRefreshCallback?.call();
    });
  }

  void _showDeleteConfirmation(BuildContext context, Trip trip) {
    TripDialogs.showDeleteConfirmation(context, trip, (tripToDelete) async {
      await context.read<TripController>().deleteTrip(tripToDelete);
      _onRefreshCallback?.call();
      if (mounted) context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final state = GoRouterState.of(context);
    final tripId = state.pathParameters['id']!;
    final controller = context.watch<TripController>();
    final trip = controller.allTrips.firstWhere((t) => t.id == tripId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.tripDetails, style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditTripDialog(context, trip),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteConfirmation(context, trip),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: TripCard(
          trip: trip,
          onTap: () {},
          onEdit: () => _showEditTripDialog(context, trip),
          onDelete: () => _showDeleteConfirmation(context, trip),
        ),
      ),
    );
  }
}
