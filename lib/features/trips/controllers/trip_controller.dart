import 'package:flutter/foundation.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/domain/repositories/trip_repository.dart';

class TripController extends ChangeNotifier {
  final TripRepository _tripRepository;

  List<Trip> _trips = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  TripStatus? _selectedStatus;

  List<Trip> get trips => _getFilteredTrips();
  List<Trip> get allTrips => _trips;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  TripStatus? get selectedStatus => _selectedStatus;

  TripController({required TripRepository tripRepository}) 
      : _tripRepository = tripRepository;

  Future<void> loadTrips() async {
    _setLoading(true);
    _error = null;
    try {
      _trips = await _tripRepository.getAllTrips();
      _setLoading(false);
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
    }
  }

  Future<void> addTrip(Trip trip) async {
    _setLoading(true);
    try {
      await _tripRepository.createTrip(trip);
      await loadTrips();
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
    }
  }

  Future<void> updateTrip(Trip trip) async {
    _setLoading(true);
    try {
      await _tripRepository.updateTrip(trip);
      await loadTrips();
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
    }
  }

  Future<void> deleteTrip(Trip trip) async {
    _setLoading(true);
    try {
      await _tripRepository.deleteTrip(trip.id);
      await loadTrips();
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setStatusFilter(TripStatus? status) {
    _selectedStatus = status;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedStatus = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Trip> _getFilteredTrips() {
    var filtered = [..._trips];
    
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((trip) {
        return trip.title.toLowerCase().contains(query) ||
               trip.destination.toLowerCase().contains(query);
      }).toList();
    }
    
    if (_selectedStatus != null) {
      filtered = filtered.where((trip) => trip.status == _selectedStatus).toList();
    }
    
    return filtered..sort((a, b) => a.startDate.compareTo(b.startDate));
  }
}
