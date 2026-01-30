import 'package:flutter/material.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/widgets/trip_form.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class TripDialogs {
  static void showAddTripDialog(BuildContext context, Function(Trip) onSave) {
    showDialog(
      context: context,
      builder: (context) => TripForm(
        onSave: (tripData) async {
          final trip = Trip(
            id: const Uuid().v4(),
            title: tripData['title'],
            description: tripData['description'],
            destination: tripData['destination'],
            startDate: tripData['startDate'],
            endDate: tripData['endDate'],
            budget: tripData['budget'],
            status: tripData['status'] ?? TripStatus.planned,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          await onSave(trip);
        },
      ),
    );
  }

  static void showEditTripDialog(BuildContext context, Trip trip, Function(Trip) onSave) {
    showDialog(
      context: context,
      builder: (context) => TripForm(
        trip: trip,
        onSave: (tripData) async {
          final updatedTrip = trip.copyWith(
            title: tripData['title'],
            description: tripData['description'],
            destination: tripData['destination'],
            startDate: tripData['startDate'],
            endDate: tripData['endDate'],
            budget: tripData['budget'],
            status: tripData['status'] ?? trip.status,
          );
          await onSave(updatedTrip);
        },
      ),
    );
  }

  static void showDeleteConfirmation(BuildContext context, Trip trip, Function(Trip) onDelete) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteTrip),
        content: Text(AppLocalizations.of(context).deleteTripConfirmation(trip.title)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await onDelete(trip);
            },
            child: Text(AppLocalizations.of(context).delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
