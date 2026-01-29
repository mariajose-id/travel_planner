import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:travel_planner/core/router/app_route_names.dart';
import 'package:travel_planner/features/trips/models/trip.dart';
import 'package:travel_planner/features/trips/services/trip_service.dart';
import 'package:travel_planner/features/trips/widgets/trip_list.dart';
import 'package:travel_planner/features/trips/widgets/trip_statistics.dart';
import 'package:travel_planner/features/trips/widgets/trip_dialogs.dart';
import 'package:travel_planner/features/trips/widgets/trip_empty_state.dart';
import 'package:travel_planner/features/trips/widgets/trip_form.dart';
import 'package:travel_planner/features/trips/widgets/trip_card.dart';
import 'package:travel_planner/shared/widgets/section_card.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:travel_planner/core/theme/app_spacing.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/core/localization/app_localizations_extension.dart';
class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});
  @override
  State<TripsScreen> createState() => _TripsScreenState();
}
class _TripsScreenState extends State<TripsScreen> with SingleTickerProviderStateMixin {
  final TripService _tripService = TripService();
  List<Trip> _trips = [];
  bool _isLoading = false;
  String? _error;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeService();
    _loadTrips();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _initializeService() async {
    await _tripService.initialize();
  }
  Future<void> _loadTrips() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      final trips = await _tripService.getAllTrips();
      setState(() { _trips = trips; _isLoading = false; });
    } catch (e) {
      setState(() { _error = e.toString(); _isLoading = false; });
    }
  }
  Future<void> _addTrip(Trip trip) async {
    setState(() { _isLoading = true; });
    try {
      // Create trip data for API (JSON serialization)
      final tripData = await _tripService.createTripForApi(
        title: trip.title,
        description: trip.description,
        destination: trip.destination,
        startDate: trip.startDate,
        endDate: trip.endDate,
        budget: trip.budget,
        status: trip.status,
      );
      
      // Simulate API call (in real app, send tripData to server)
      print('API Data: ${jsonEncode(tripData)}');
      
      // Create trip locally from API response
      await _tripService.createTripFromApiData(tripData);
      await _loadTrips();
    } catch (e) {
      setState(() { _error = e.toString(); _isLoading = false; });
    }
  }
  Future<void> _updateTrip(Trip trip) async {
    setState(() { _isLoading = true; });
    try {
      await _tripService.updateTrip(
        id: trip.id,
        title: trip.title,
        description: trip.description,
        destination: trip.destination,
        startDate: trip.startDate,
        endDate: trip.endDate,
        budget: trip.budget,
        status: trip.status,
      );
      await _loadTrips(); 
    } catch (e) {
      setState(() { _error = e.toString(); _isLoading = false; });
    }
  }
  Future<void> _deleteTrip(String tripId) async {
    setState(() { _isLoading = true; });
    try {
      await _tripService.deleteTrip(tripId);
      setState(() { 
        _trips.removeWhere((trip) => trip.id == tripId);
        _isLoading = false; 
      });
    } catch (e) {
      setState(() { _error = e.toString(); _isLoading = false; });
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).yourTrips,
          style: context.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
          onPressed: () => context.goNamed(AppRouteNames.home),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: theme.colorScheme.onSurface),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: theme.colorScheme.onSurface),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Overall statistics at the top
          Padding(
            padding: const EdgeInsets.all(16),
            child: TripStatistics(trips: _trips),
          ),
          // Tab bar as filter below stats
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.primary,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              labelStyle: context.labelMedium.copyWith(fontWeight: FontWeight.w600),
              unselectedLabelStyle: context.labelMedium.copyWith(fontWeight: FontWeight.w500),
              tabs: const [
                Tab(text: 'PLANNED'),
                Tab(text: 'UPCOMING'),
                Tab(text: 'COMPLETED'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTripsList(_getPlannedTrips(), theme),
                _buildTripsList(_getUpcomingTrips(), theme),
                _buildTripsList(_getCompletedTrips(), theme),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => TripDialogs.showAddTripDialog(context, _addTrip),
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Trip> _getPlannedTrips() {
    return _trips.where((trip) => trip.status.toLowerCase() == 'planned').toList();
  }

  List<Trip> _getUpcomingTrips() {
    return _trips.where((trip) =>
        trip.status.toLowerCase() == 'ongoing' ||
        (trip.status.toLowerCase() == 'planned' && trip.startDate.isAfter(DateTime.now())))
        .toList();
  }

  List<Trip> _getCompletedTrips() {
    return _trips.where((trip) => trip.status.toLowerCase() == 'completed').toList();
  }

  Widget _buildTripsList(List<Trip> trips, ThemeData theme) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading trips: $_error',
              style: context.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadTrips,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (trips.isEmpty) {
      return TripEmptyState(onAddTrip: () => TripDialogs.showAddTripDialog(context, _addTrip));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TripList(
        trips: trips,
        onTripTap: (trip) => _showTripDetails(context, trip),
        onEdit: (trip) => _showEditTripDialog(context, trip),
        onDelete: (trip) => _showDeleteConfirmation(context, trip),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ThemeData theme) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).errorLoadingTrips,
              style: context.titleMedium.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: context.bodySmall.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _loadTrips(),
              child: Text(AppLocalizations.of(context).retry),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () async => await _loadTrips(),
      child: _trips.isEmpty
          ? TripEmptyState(onAddTrip: () => TripDialogs.showAddTripDialog(context, _addTrip))
          : Column(
              children: [
                TripStatistics(trips: _trips),
                const SizedBox(height: 16),
                Expanded(
                  child: TripList(
                    trips: _trips,
                    onTripTap: (trip) => _showTripDetails(context, trip),
                    onEdit: (trip) => TripDialogs.showEditTripDialog(context, trip, _updateTrip),
                    onDelete: (trip) => TripDialogs.showDeleteConfirmation(context, trip, _deleteTrip),
                  ),
                ),
              ],
            ),
    );
  }
  Widget _buildTripsHeader(BuildContext context, ThemeData theme) {
    return Padding(
      padding: AppSpacing.paddingMD,
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppLocalizations.of(context).yourTrips,
              style: context.titleLarge.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, color: theme.colorScheme.onSurface),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: theme.colorScheme.onSurface),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
    );
  }
  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flight_takeoff_outlined,
            size: 80,
            color: theme.colorScheme.primary,
          ),
          AppSpacing.verticalGapMD,
          Text(
            AppLocalizations.of(context).noTripsYet,
            style: context.headlineMedium.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          AppSpacing.verticalGapSM,
          Text(
            AppLocalizations.of(context).startPlanningNextAdventure,
            style: context.bodyMedium.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha:0.7),
            ),
          ),
          AppSpacing.verticalGapLG,
          ElevatedButton.icon(
            onPressed: () => TripDialogs.showAddTripDialog(context, _addTrip),
            icon: const Icon(Icons.add),
            label: Text(AppLocalizations.of(context).addTrip),
          ),
        ],
      ),
    );
  }
  Widget _buildStatistics(BuildContext context, ThemeData theme) {
    final totalBudget = _trips.fold(0.0, (sum, trip) => sum + trip.budget);
    
    return SectionCard(
      padding: AppSpacing.paddingMD,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  'Total Trips',
                  '${_trips.length}',
                  Icons.flight_takeoff,
                  theme.colorScheme.primary,
                ),
              ),
              AppSpacing.horizontalGapSM,
              Expanded(
                child: _buildStatItem(
                  context,
                  'Total Budget',
                  '\$${totalBudget.toStringAsFixed(2)}',
                  Icons.attach_money,
                  theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: context.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: context.bodySmall.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha:0.6),
          ),
        ),
      ],
    );
  }
  void _showTripDetails(BuildContext context, Trip trip) {
    context.push('/trips/${trip.id}', extra: _loadTrips);
  }
  void _showEditTripDialog(BuildContext context, Trip trip) {
    TripDialogs.showEditTripDialog(context, trip, _updateTrip);
  }
  void _showDeleteConfirmation(BuildContext context, Trip trip) {
    TripDialogs.showDeleteConfirmation(context, trip, _deleteTrip);
  }
  void _showSearchDialog(BuildContext context) {
    context.push('/search');
  }
  void _showFilterDialog(BuildContext context) {
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filter coming soon!')),
    );
  }
}
