import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/presentation/providers/trip_notifier.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_notifier.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_list.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_dialogs.dart';
import 'package:travel_planner/shared/widgets/states/app_loading_state.dart';
import 'package:travel_planner/shared/widgets/states/app_error_state.dart';
import 'package:travel_planner/shared/widgets/states/app_empty_state.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';

class TripsTab extends ConsumerStatefulWidget {
  final TripStatus status;

  const TripsTab({super.key, required this.status});

  @override
  ConsumerState<TripsTab> createState() => _TripsTabState();
}

class _TripsTabState extends ConsumerState<TripsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final tripsState = ref.watch(tripsProvider);
    final user = ref.watch(authNotifierProvider).value;
    final tripNotifier = ref.read(tripsProvider.notifier);

    return tripsState.when(
      loading: () => const AppLoadingState(),
      error: (err, stack) =>
          AppErrorState(message: err.toString(), onRetry: tripNotifier.refetch),
      data: (allTrips) {
        final trips = allTrips.where((t) => t.status == widget.status).toList();

        if (trips.isEmpty) {
          return AppEmptyState(
            title: context.l10n.label_no_trips,
            message: context.l10n.label_start_planning,
            retryLabel: context.l10n.action_add_trip,
            onRetry: () => TripDialogs.showAddTripDialog(
              context,
              tripNotifier.addTrip,
              user?.id ?? '',
            ),
          );
        }

        return TripList(
          trips: trips,
          onTripTap: (trip) => context.pushNamed(
            AppRoutes.tripDetail,
            pathParameters: {'id': trip.id},
          ),
          onEdit: (trip) {
            TripDialogs.showEditTripDialog(context, trip, (updatedTrip) async {
              await tripNotifier.updateTrip(updatedTrip);
            });
          },
          onDelete: (trip) {
            TripDialogs.showDeleteConfirmation(context, trip, (t) async {
              await tripNotifier.deleteTrip(t);
            });
          },
        );
      },
    );
  }
}
