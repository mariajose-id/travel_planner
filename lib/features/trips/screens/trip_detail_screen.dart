import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/core/utils/app_date_utils.dart';
import 'package:travel_planner/features/trips/models/trip.dart';
import 'package:travel_planner/features/trips/providers/trip_provider.dart';
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
    // Get the callback passed from navigation (only if not already set)
    _onRefreshCallback ??= GoRouterState.of(context).extra as VoidCallback?;
  }

  void _showEditTripDialog(BuildContext context, Trip trip) {
    TripDialogs.showEditTripDialog(context, trip, (updatedTrip) async {
      // Update the trip in the provider
      await context.read<TripProvider>().updateTrip(
        id: updatedTrip.id,
        title: updatedTrip.title,
        description: updatedTrip.description,
        destination: updatedTrip.destination,
        startDate: updatedTrip.startDate,
        endDate: updatedTrip.endDate,
        budget: updatedTrip.budget,
        status: updatedTrip.status,
      );
      // Call the refresh callback if provided
      _onRefreshCallback?.call();
    });
  }

  void _showDeleteConfirmation(BuildContext context, Trip trip) {
    TripDialogs.showDeleteConfirmation(context, trip, (tripId) async {
      // Delete the trip and navigate back
      await context.read<TripProvider>().deleteTrip(tripId);
      context.pop(); // Go back to trips list
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tripId = GoRouterState.of(context).pathParameters['id'];
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) {
        final trip = tripId != null ? tripProvider.getTripById(tripId) : null;
        if (trip == null) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.grey[300],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey[400]!,
                            Colors.grey[300]!,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 80,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline_outlined,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context).tripNotFound,
                            style: context.titleLarge.copyWith(
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
          );
        }
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                floating: false,
                pinned: true,
                backgroundColor: Colors.grey[300],
                leading: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
                    onPressed: () => context.pop(),
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Colors.black87),
                      onPressed: () {
                        _showEditTripDialog(context, trip);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        _showDeleteConfirmation(context, trip);
                      },
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    trip.title,
                    style: context.titleLarge.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      shadows: [
                        Shadow(
                          color: Colors.white.withValues(alpha: 0.8),
                          offset: const Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey[400]!,
                          Colors.grey[300]!,
                          Colors.grey[200]!,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.travel_explore_outlined,
                                size: 60,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              TripCard.getStatusColor(trip.status).withValues(alpha: 0.12),
                              TripCard.getStatusColor(trip.status).withValues(alpha: 0.06),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: TripCard.getStatusColor(trip.status).withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          trip.status.toUpperCase(),
                          style: context.labelSmall.copyWith(
                            color: TripCard.getStatusColor(trip.status),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Description
                      if (trip.description.isNotEmpty) ...[
                        Text(
                          'Description',
                          style: context.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.colorScheme.outline.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Text(
                            trip.description,
                            style: context.bodyLarge.copyWith(
                              height: 1.5,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      // Trip details in chips
                      Text(
                        'Trip Details',
                        style: context.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _buildDetailChip(
                            context,
                            Icons.location_on_outlined,
                            trip.destination,
                            theme.colorScheme.primary,
                          ),
                          _buildDetailChip(
                            context,
                            Icons.attach_money_outlined,
                            '\$${trip.budget.toStringAsFixed(0)}',
                            Colors.green,
                          ),
                          _buildDetailChip(
                            context,
                            Icons.calendar_today_outlined,
                            AppDateUtils.formatDateRange(trip.startDate, trip.endDate),
                            theme.colorScheme.secondary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildDetailChip(
    BuildContext context,
    IconData icon,
    String text,
    Color color,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.1),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: context.bodyMedium.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}