import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/core/di/service_locator.dart';
import 'package:travel_planner/features/trips/controllers/trip_controller.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/widgets/trip_card.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => TripController(tripRepository: getTripRepository())..loadTrips(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            loc.home_welcome,
            style: theme.textTheme.titleLarge,
          ),
        ),
        body: Consumer<TripController>(
          builder: (context, controller, _) {
            final trips = controller.allTrips;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.go('/trips'),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  theme.colorScheme.primary.withValues(alpha: 0.8),
                                  theme.colorScheme.primary,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  loc.addTrip,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    loc.recentActivity,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (trips.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(
                              Icons.explore_outlined,
                              size: 48,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              loc.noRecentTrips,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () => context.go('/trips'),
                              child: Text(loc.startPlanning),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...trips.take(5).map((trip) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: TripCard.getStatusColor(trip.status).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                TripCard.getStatusIcon(trip.status),
                                color: TripCard.getStatusColor(trip.status),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trip.title,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    trip.destination,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: TripCard.getStatusColor(trip.status).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _statusLabel(trip.status, loc),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: TripCard.getStatusColor(trip.status),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _statusLabel(TripStatus status, AppLocalizations loc) {
    return switch (status) {
      TripStatus.planned => loc.planned,
      TripStatus.upcoming => loc.ongoing,
      TripStatus.completed => loc.completed,
    }.toUpperCase();
  }
}
