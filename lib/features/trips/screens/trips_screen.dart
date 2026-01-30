import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/core/di/service_locator.dart';
import 'package:travel_planner/core/router/app_route_names.dart';
import 'package:travel_planner/features/trips/controllers/trip_controller.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/widgets/trip_list.dart';
import 'package:travel_planner/features/trips/widgets/trip_statistics.dart';
import 'package:travel_planner/features/trips/widgets/trip_dialogs.dart';
import 'package:travel_planner/features/trips/widgets/trip_empty_state.dart';
import 'package:travel_planner/features/trips/widgets/trip_error_state.dart';
import 'package:travel_planner/features/trips/widgets/trip_search_dialog.dart';
import 'package:travel_planner/features/trips/widgets/trip_filter_dialog.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final TripController _controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: TripStatus.values.length, vsync: this);
    _controller = TripController(tripRepository: getTripRepository())..loadTrips();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: _TripsView(tabController: _tabController),
    );
  }
}

class _TripsView extends StatelessWidget {
  final TabController tabController;

  const _TripsView({required this.tabController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final controller = context.watch<TripController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.yourTrips,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
          onPressed: () => context.goNamed(AppRouteNames.home),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: theme.colorScheme.onSurface),
            onPressed: () => _showSearchDialog(context, controller),
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: theme.colorScheme.onSurface),
            onPressed: () => _showFilterDialog(context, controller),
          ),
        ],
      ),
      body: Column(
        children: [
          TripStatistics(trips: controller.allTrips),
          _buildTabBar(context, loc, theme),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: TripStatus.values.map((status) => _TripsTab(status: status)).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => TripDialogs.showAddTripDialog(context, controller.addTrip),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, AppLocalizations loc, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.colorScheme.primary,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        tabs: TripStatus.values.map((status) {
          return Tab(text: _statusLabel(status, loc));
        }).toList(),
      ),
    );
  }

  String _statusLabel(TripStatus status, AppLocalizations loc) {
    return switch (status) {
      TripStatus.planned => loc.planned,
      TripStatus.upcoming => loc.ongoing,
      TripStatus.completed => loc.completed,
    };
  }

  void _showSearchDialog(BuildContext context, TripController controller) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => TripSearchDialog(onSearch: controller.setSearchQuery),
    );
  }

  void _showFilterDialog(BuildContext context, TripController controller) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => TripFilterDialog(
        currentFilter: controller.selectedStatus,
        onFilter: controller.setStatusFilter,
      ),
    );
  }
}

class _TripsTab extends StatefulWidget {
  final TripStatus status;

  const _TripsTab({required this.status});

  @override
  State<_TripsTab> createState() => _TripsTabState();
}

class _TripsTabState extends State<_TripsTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = context.watch<TripController>();

    final trips = controller.trips.where((t) => t.status == widget.status).toList();

    if (controller.isLoading && trips.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.error != null && trips.isEmpty) {
      return TripErrorState(error: controller.error!, onRetry: controller.loadTrips);
    }

    if (trips.isEmpty) {
      return TripEmptyState(onAddTrip: () => TripDialogs.showAddTripDialog(context, controller.addTrip));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TripList(
        trips: trips,
        onTripTap: (trip) => context.push(
          '/trips/${trip.id}',
          extra: controller.loadTrips,
        ),
        onEdit: (trip) => TripDialogs.showEditTripDialog(context, trip, controller.updateTrip),
        onDelete: (trip) => TripDialogs.showDeleteConfirmation(context, trip, controller.deleteTrip),
      ),
    );
  }
}
