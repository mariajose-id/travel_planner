import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/shared/widgets/user_avatar.dart';
import 'package:travel_planner/shared/widgets/animated_bottom_nav.dart';
import 'package:travel_planner/shared/widgets/main_layout.dart';
import 'package:travel_planner/features/trips/screens/trips_screen.dart';
import 'package:travel_planner/features/trips/models/trip.dart';
import 'package:travel_planner/features/trips/services/trip_service.dart';
import 'package:travel_planner/features/trips/widgets/trip_card.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TripService _tripService = TripService();
  List<Trip> _recentTrips = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecentTrips();
  }

  Future<void> _loadRecentTrips() async {
    setState(() => _isLoading = true);
    try {
      final trips = await _tripService.getAllTrips();
      setState(() {
        _recentTrips = trips.take(5).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return MainLayout(
      title: AppLocalizations.of(context).appName,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: theme.colorScheme.onSurface),
          onPressed: () {
            
          },
        ),
        IconButton(
          icon: Icon(Icons.settings_outlined, color: theme.colorScheme.onSurface),
          onPressed: () {
            context.go('/settings');
          },
        ),
      ],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withValues(alpha:0.05),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: _buildCurrentPage(),
      ),
      bottomNavigationBar: AnimatedBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavItem(
            icon: Icons.home_outlined,
            label: AppLocalizations.of(context).nav_home,
          ),
          BottomNavItem(
            icon: Icons.settings_outlined,
            label: AppLocalizations.of(context).settings,
          ),
          BottomNavItem(
            icon: Icons.flight_takeoff_outlined,
            label: AppLocalizations.of(context).nav_trips,
          ),
          BottomNavItem(
            icon: Icons.favorite_outline,
            label: AppLocalizations.of(context).nav_saved,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildSettingsPage();
      case 2:
        return _buildTripsPage();
      case 3:
        return _buildSavedPage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).home_welcome,
                              style: context.headlineLarge.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppLocalizations.of(context).journeyStartsHere,
                              style: context.bodyMedium.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha:0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      UserAvatar(
                        size: 60,
                        showStatus: true,
                        onTap: () {
                          context.go('/settings');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              AppLocalizations.of(context).quickActions,
              style: context.headlineSmall.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildModernQuickAction(
                  context,
                  icon: Icons.flight_takeoff,
                  title: AppLocalizations.of(context).home_upcomingTrips,
                  subtitle: AppLocalizations.of(context).viewYourTrips,
                  color: theme.colorScheme.primary,
                  onTap: () {
                    setState(() => _currentIndex = 2);
                  },
                ),
                _buildModernQuickAction(
                  context,
                  icon: Icons.history,
                  title: AppLocalizations.of(context).home_recentlyViewed,
                  subtitle: AppLocalizations.of(context).recentPlaces,
                  color: theme.colorScheme.secondary,
                  onTap: () {
                    
                  },
                ),
                _buildModernQuickAction(
                  context,
                  icon: Icons.settings,
                  title: AppLocalizations.of(context).settings,
                  subtitle: AppLocalizations.of(context).appSettings,
                  color: Colors.orange,
                  onTap: () {
                    setState(() => _currentIndex = 1);
                  },
                ),
                _buildModernQuickAction(
                  context,
                  icon: Icons.favorite,
                  title: AppLocalizations.of(context).favorites,
                  subtitle: AppLocalizations.of(context).savedPlaces,
                  color: Colors.red,
                  onTap: () {
                    setState(() => _currentIndex = 3);
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            Text(
              AppLocalizations.of(context).recentActivity,
              style: context.headlineSmall.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_recentTrips.isEmpty)
              _buildEmptyRecentTrips(theme)
            else
              _buildRecentTripsList(theme),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyRecentTrips(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha:0.1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.flight,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).noRecentTrips,
                      style: context.titleMedium.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context).startPlanning,
                      style: context.bodySmall.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha:0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTripsList(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha:0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Trips',
            style: context.titleMedium.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ..._recentTrips.asMap().entries.map((entry) {
            final index = entry.key;
            final trip = entry.value;
            final isLast = index == _recentTrips.length - 1;
            
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    context.push('/trips/${trip.id}');
                  },
                  child: Container(
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
                                style: context.bodyMedium.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                trip.destination,
                                style: context.bodySmall.copyWith(
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
                            trip.status.toUpperCase(),
                            style: context.bodySmall.copyWith(
                              color: TripCard.getStatusColor(trip.status),
                              fontWeight: FontWeight.w600,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isLast) const SizedBox(height: 8),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSettingsPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go('/settings');
    });
    
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.settings_outlined,
            size: 80,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).settings,
            style: context.headlineMedium.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsPage() {
    return const TripsScreen();
  }

  Widget _buildSavedPage() {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            size: 80,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).savedPlaces,
            style: context.headlineMedium.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            AppLocalizations.of(context).favoriteDestinations,
            style: context.bodyMedium.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha:0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernQuickAction(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha:0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: context.titleSmall.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: context.bodySmall.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha:0.6),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
