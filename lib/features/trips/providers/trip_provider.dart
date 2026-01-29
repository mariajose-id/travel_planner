import 'package:flutter/foundation.dart';
import 'package:travel_planner/features/trips/models/trip.dart';
import 'package:travel_planner/features/trips/services/trip_service.dart';
class TripProvider extends ChangeNotifier {
  final TripService _tripService = TripService();
  
  List<Trip> _trips = [];
  List<Trip> _filteredTrips = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String? _selectedStatus;
  String? _selectedDestination;
  
  List<Trip> get trips => _filteredTrips;
  List<Trip> get allTrips => _trips;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String? get selectedStatus => _selectedStatus;
  String? get selectedDestination => _selectedDestination;
  
  Future<void> loadTrips() async {
    _setLoading(true);
    try {
      _trips = _tripService.getAllTrips();
      _applyFilters();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }
  
  Future<void> createTrip({
    required String title,
    required String description,
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    String status = 'planned',
  }) async {
    _setLoading(true);
    try {
      await _tripService.createTrip(
        title: title,
        description: description,
        destination: destination,
        startDate: startDate,
        endDate: endDate,
        budget: budget,
        status: status,
      );
      await loadTrips();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }
  
  Future<void> updateTrip({
    required String id,
    String? title,
    String? description,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    double? budget,
    String? status,
  }) async {
    _setLoading(true);
    try {
      await _tripService.updateTrip(
        id: id,
        title: title,
        description: description,
        destination: destination,
        startDate: startDate,
        endDate: endDate,
        budget: budget,
        status: status,
      );
      await loadTrips();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }
  
  Future<void> deleteTrip(String id) async {
    _setLoading(true);
    try {
      await _tripService.deleteTrip(id);
      await loadTrips();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }
  
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }
  void setStatusFilter(String? status) {
    _selectedStatus = status;
    _applyFilters();
  }
  void setDestinationFilter(String? destination) {
    _selectedDestination = destination;
    _applyFilters();
  }
  void clearFilters() {
    _searchQuery = '';
    _selectedStatus = null;
    _selectedDestination = null;
    _applyFilters();
  }
  void _applyFilters() {
    _filteredTrips = _tripService.searchTrips(
      query: _searchQuery.isEmpty ? null : _searchQuery,
      status: _selectedStatus,
      destination: _selectedDestination,
    );
    notifyListeners();
  }
  
  List<Trip> getTripsByStatus(String status) {
    return _tripService.getTripsByStatus(status);
  }
  
  Trip? getTripById(String id) {
    return _tripService.getTripById(id);
  }
  
  Map<String, int> getTripStatistics() {
    final stats = <String, int>{};
    for (final trip in _trips) {
      stats[trip.status] = (stats[trip.status] ?? 0) + 1;
    }
    return stats;
  }
  double getTotalBudget() {
    return _trips.fold(0.0, (sum, trip) => sum + trip.budget);
  }
  List<Trip> getUpcomingTrips() {
    final now = DateTime.now();
    return _trips.where((trip) => trip.startDate.isAfter(now)).toList()
      ..sort((a, b) => a.startDate.compareTo(b.startDate));
  }
  List<Trip> getOngoingTrips() {
    final now = DateTime.now();
    return _trips.where((trip) => 
      trip.startDate.isBefore(now) && trip.endDate.isAfter(now)
    ).toList();
  }
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
