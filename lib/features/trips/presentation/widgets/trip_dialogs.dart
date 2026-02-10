import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/domain/value_objects/destination.dart';
import 'package:travel_planner/features/trips/domain/value_objects/money.dart';
import 'package:travel_planner/features/trips/domain/value_objects/travel_date.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_form.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:uuid/uuid.dart';
import 'package:travel_planner/shared/widgets/dialogs/app_confirmation_dialog.dart';

class TripDialogs {
  TripDialogs._();

  static Money _parseBudget(dynamic budgetValue) {
    if (budgetValue is Money) return budgetValue;
    if (budgetValue is String) {
      return Money.tryParse(budgetValue) ?? Money.usd(0);
    }
    if (budgetValue is num) {
      return Money.usd(budgetValue.toDouble());
    }
    return Money.usd(0);
  }

  static void showAddTripDialog(
    BuildContext context,
    Function(Trip) onSave,
    String userId,
  ) {
    showDialog(
      context: context,
      builder: (context) => TripForm(
        onSave: (tripData) {
          final trip = Trip(
            id: const Uuid().v4(),
            title: tripData['title'],
            description: tripData['description'],
            destination: Destination.restore(tripData['destination']),
            startDate: TravelDate.restore(tripData['startDate']),
            endDate: TravelDate.restore(tripData['endDate']),
            budget: _parseBudget(tripData['budget']),
            status: tripData['status'] ?? TripStatus.planned,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            userId: userId,
          );
          onSave(trip);
        },
      ),
    );
  }

  static void showEditTripDialog(
    BuildContext context,
    Trip trip,
    Function(Trip) onSave,
  ) {
    showDialog(
      context: context,
      builder: (context) => TripForm(
        trip: trip,
        onSave: (tripData) {
          final updatedTrip = trip.copyWith(
            title: tripData['title'],
            description: tripData['description'],
            destination: Destination.restore(tripData['destination']),
            startDate: TravelDate.restore(tripData['startDate']),
            endDate: TravelDate.restore(tripData['endDate']),
            budget: _parseBudget(tripData['budget']),
            status: tripData['status'] ?? trip.status,
            updatedAt: DateTime.now(),
          );
          onSave(updatedTrip);
        },
      ),
    );
  }

  static Future<void> showDeleteConfirmation(
    BuildContext context,
    Trip trip,
    Function(Trip) onDelete, {
    bool isOnDetailScreen = false,
  }) async {
    final confirmed = await AppConfirmationDialog.show(
      context,
      title: context.l10n.action_delete_trip,
      message: context.l10n.dialog_delete_trip_confirm(trip.title),
      confirmText: context.l10n.action_delete,
      cancelText: context.l10n.action_cancel,
      isDangerous: true,
    );

    if (confirmed == true) {
      if (isOnDetailScreen && context.mounted) {
        context.pop();
      }
      await onDelete(trip);
    }
  }
}
