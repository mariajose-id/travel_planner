import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:travel_planner/features/trips/models/trip.dart';
import 'package:travel_planner/core/exceptions/app_exceptions.dart';
import 'package:travel_planner/core/logging/logger.dart';
class TripService {
  static final TripService _instance = TripService._();
  factory TripService() => _instance;
  TripService._();
  final Box<Trip> _tripsBox = Hive.box<Trip>('trips');
  static const String _tripsKey = 'cached_trips';
  
  Future<void> _saveToSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final trips = getAllTrips();
      final tripsJson = trips.map((trip) => trip.toJson()).toList();
      await prefs.setString(_tripsKey, jsonEncode(tripsJson));
      AppLogger.getLogger('TripService').info('Saved ${trips.length} trips to SharedPreferences');
    } catch (e) {
      AppLogger.getLogger('TripService').warning('Failed to save to SharedPreferences: $e');
    }
  }
  
  Future<void> _loadFromSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tripsJsonString = prefs.getString(_tripsKey);
      
      if (tripsJsonString != null && _tripsBox.isEmpty) {
        final tripsJson = jsonDecode(tripsJsonString) as List;
        final trips = tripsJson.map((json) => Trip.fromJson(json)).toList();
        
        for (final trip in trips) {
          await _tripsBox.put(trip.id, trip);
        }
        AppLogger.getLogger('TripService').info('Loaded ${trips.length} trips from SharedPreferences');
      }
    } catch (e) {
      AppLogger.getLogger('TripService').warning('Failed to load from SharedPreferences: $e');
    }
  }
  
  Future<Map<String, dynamic>> createTripForApi({
    required String title,
    required String description,
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    String status = 'planned',
  }) async {
    final trip = Trip(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      budget: budget,
      status: status,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    return trip.toJson();
  }
  
  Future<Trip> createTripFromApiData(Map<String, dynamic> apiData) async {
    try {
      final trip = Trip.fromJson(apiData);
      await _tripsBox.put(trip.id, trip);
      await _saveToSharedPreferences();
      AppLogger.getLogger('TripService').info('Created trip from API data: ${trip.id}');
      return trip;
    } catch (e) {
      AppLogger.getLogger('TripService').severe('Failed to create trip from API data: $e');
      throw DataException('Failed to create trip from API data: $e');
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
    try {
      AppLogger.getLogger('TripService').info('Creating trip: $title');
      final trip = Trip(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        destination: destination,
        startDate: startDate,
        endDate: endDate,
        budget: budget,
        status: status,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _tripsBox.put(trip.id, trip);
      await _saveToSharedPreferences();
      AppLogger.getLogger('TripService').info('Trip created successfully: ${trip.id}');
    } catch (e) {
      AppLogger.getLogger('TripService').severe('Failed to create trip: $e');
      throw DataException('Failed to create trip: $e');
    }
  }
  
  List<Trip> getAllTrips() {
    try {
      final trips = _tripsBox.values.map((trip) => trip).toList();
      AppLogger.getLogger('TripService').info('Retrieved ${trips.length} trips');
      return trips;
    } catch (e) {
      AppLogger.getLogger('TripService').severe('Failed to get trips: $e');
      return [];
    }
  }
  
  Trip? getTripById(String id) {
    try {
      final trip = _tripsBox.get(id);
      if (trip != null) {
        AppLogger.getLogger('TripService').info('Retrieved trip: $id');
      }
      return trip;
    } catch (e) {
      AppLogger.getLogger('TripService').severe('Failed to get trip by id: $id');
      return null;
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
    try {
      final existingTrip = _tripsBox.get(id);
      if (existingTrip == null) {
        throw NotFoundException('Trip not found: $id');
      }
      final updatedTrip = existingTrip.copyWith(
        title: title,
        description: description,
        destination: destination,
        startDate: startDate,
        endDate: endDate,
        budget: budget,
        status: status,
        updatedAt: DateTime.now(),
      );
      await _tripsBox.put(id, updatedTrip);
      await _saveToSharedPreferences();
      AppLogger.getLogger('TripService').info('Trip updated successfully: $id');
    } catch (e) {
      AppLogger.getLogger('TripService').severe('Failed to update trip: $e');
      throw DataException('Failed to update trip: $e');
    }
  }
  
  Future<void> deleteTrip(String id) async {
    try {
      await _tripsBox.delete(id);
      await _saveToSharedPreferences();
      AppLogger.getLogger('TripService').info('Trip deleted successfully: $id');
    } catch (e) {
      AppLogger.getLogger('TripService').severe('Failed to delete trip: $e');
      throw DataException('Failed to delete trip: $e');
    }
  }
  
  List<Trip> searchTrips({String? query, String? status, String? destination}) {
    try {
      final trips = getAllTrips();
      
      return trips.where((trip) {
        final matchesQuery = query == null || trip.title.toLowerCase().contains(query.toLowerCase());
        final matchesStatus = status == null || trip.status == status;
        final matchesDestination = destination == null || trip.destination.toLowerCase().contains(destination.toLowerCase());
        
        return matchesQuery && matchesStatus && matchesDestination;
      }).toList();
    } catch (e) {
      AppLogger.getLogger('TripService').severe('Failed to search trips: $e');
      return [];
    }
  }
  
  List<Trip> getTripsByStatus(String status) {
    try {
      final trips = getAllTrips();
      final filteredTrips = trips.where((trip) => trip.status == status).toList();
      AppLogger.getLogger('TripService').info('Retrieved ${filteredTrips.length} trips with status: $status');
      return filteredTrips;
    } catch (e) {
      AppLogger.getLogger('TripService').severe('Failed to get trips by status: $e');
      return [];
    }
  }
  
  List<Trip> getTripsByDateRange(DateTime startDate, DateTime endDate) {
    try {
      final trips = getAllTrips();
      final filteredTrips = trips.where((trip) {
        return trip.startDate.isAfter(startDate) && trip.startDate.isBefore(endDate);
      }).toList();
      AppLogger.getLogger('TripService').info('Retrieved ${filteredTrips.length} trips in date range');
      return filteredTrips;
    } catch (e) {
      AppLogger.getLogger('TripService').severe('Failed to get trips by date range: $e');
      return [];
    }
  }
  
  Future<void> initialize() async {
    await _loadFromSharedPreferences();
  }
}
