import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/features/trips/presentation/providers/trip_notifier.dart';
import 'package:travel_planner/features/trips/presentation/widgets/trip_card.dart';
import 'package:travel_planner/features/trips/presentation/dtos/trip_dto.dart';
import 'package:travel_planner/shared/widgets/app_background_gradient.dart';

class TripListsScreen extends ConsumerWidget {
  const TripListsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsAsync = ref.watch(tripsProvider);

    return Stack(
      children: [
        const Positioned.fill(
          child: AppBackgroundGradient(
            direction: GradientDirection.topToBottom,
          ),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => context.goNamed(AppRoutes.home),
            ),
            title: Text(
              context.l10n.heading_trip_lists,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            bottom: false,
            child: tripsAsync.when(
              data: (trips) {
                if (trips.isEmpty) {
                  return Center(child: Text(context.l10n.label_no_trips));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: trips.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final trip = trips[index];
                    return TripCard(
                      trip: TripDto(trip),
                      onTap: () {
                        context.push(AppRoutes.buildTripListsPath(trip.id));
                      },
                      onEdit: () {},
                      onDelete: () {},
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ),
      ],
    );
  }
}
