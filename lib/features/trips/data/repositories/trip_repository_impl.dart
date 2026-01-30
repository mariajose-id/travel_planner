import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_planner/core/exceptions/app_exceptions.dart';
import 'package:travel_planner/core/logging/logger.dart';
import 'package:travel_planner/features/trips/data/models/trip_model.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final Box<TripModel> _tripsBox;

  TripRepositoryImpl({required Box<TripModel> tripsBox}) : _tripsBox = tripsBox;

  @override
  Future<Trip> createTrip(Trip trip) async {
    try {
      AppLogger.getLogger('TripRepository').info('Creating trip: ${trip.title}');
      
      final tripModel = TripModel.fromDomain(trip);
      
      await _tripsBox.put(trip.id, tripModel);
      
      AppLogger.getLogger('TripRepository').info('Trip created successfully: ${trip.id}');
      return trip;
    } catch (e) {
      AppLogger.getLogger('TripRepository').severe('Failed to create trip: $e');
      throw DataException('Failed to create trip: $e');
    }
  }

  @override
  Future<List<Trip>> getAllTrips() async {
    try {
      final tripModels = _tripsBox.values.toList();
      final trips = tripModels.map((model) => model.toDomain()).toList();
      AppLogger.getLogger('TripRepository').info('Retrieved ${trips.length} trips');
      return trips;
    } catch (e) {
      AppLogger.getLogger('TripRepository').severe('Failed to get trips: $e');
      throw DataException('Failed to get trips: $e');
    }
  }

  @override
  Future<Trip?> getTripById(String id) async {
    try {
      final tripModel = _tripsBox.get(id);
      if (tripModel != null) {
        AppLogger.getLogger('TripRepository').info('Retrieved trip: $id');
        return tripModel.toDomain();
      }
      return null;
    } catch (e) {
      AppLogger.getLogger('TripRepository').severe('Failed to get trip by id: $id');
      throw DataException('Failed to get trip: $e');
    }
  }

  @override
  Future<void> updateTrip(Trip trip) async {
    try {
      final existingModel = _tripsBox.get(trip.id);
      if (existingModel == null) {
        throw NotFoundException('Trip not found: ${trip.id}');
      }

      final updatedModel = TripModel.fromDomain(trip);
      await _tripsBox.put(trip.id, updatedModel);
      
      AppLogger.getLogger('TripRepository').info('Trip updated successfully: ${trip.id}');
    } catch (e) {
      AppLogger.getLogger('TripRepository').severe('Failed to update trip: $e');
      throw DataException('Failed to update trip: $e');
    }
  }

  @override
  Future<void> deleteTrip(String id) async {
    try {
      await _tripsBox.delete(id);
      AppLogger.getLogger('TripRepository').info('Trip deleted successfully: $id');
    } catch (e) {
      AppLogger.getLogger('TripRepository').severe('Failed to delete trip: $e');
      throw DataException('Failed to delete trip: $e');
    }
  }

  @override
  Future<List<Trip>> searchTrips({
    String? query,
    TripStatus? status,
    String? destination,
  }) async {
    try {
      final trips = await getAllTrips();
      
      return trips.where((trip) {
        final matchesQuery = query == null || 
            trip.title.toLowerCase().contains(query.toLowerCase()) ||
            trip.description.toLowerCase().contains(query.toLowerCase());
        final matchesStatus = status == null || trip.status == status;
        final matchesDestination = destination == null || 
            trip.destination.toLowerCase().contains(destination.toLowerCase());
        
        return matchesQuery && matchesStatus && matchesDestination;
      }).toList();
    } catch (e) {
      AppLogger.getLogger('TripRepository').severe('Failed to search trips: $e');
      throw DataException('Failed to search trips: $e');
    }
  }

  @override
  Future<List<Trip>> getTripsByStatus(TripStatus status) async {
    try {
      final trips = await getAllTrips();
      final filteredTrips = trips.where((trip) => trip.status == status).toList();
      AppLogger.getLogger('TripRepository').info('Retrieved ${filteredTrips.length} trips with status: $status');
      return filteredTrips;
    } catch (e) {
      AppLogger.getLogger('TripRepository').severe('Failed to get trips by status: $e');
      throw DataException('Failed to get trips by status: $e');
    }
  }

  @override
  Future<List<Trip>> getTripsByDateRange(DateTime startDate, DateTime endDate) async {
    try {
      final trips = await getAllTrips();
      final filteredTrips = trips.where((trip) {
        return trip.startDate.isAfter(startDate) && trip.startDate.isBefore(endDate);
      }).toList();
      AppLogger.getLogger('TripRepository').info('Retrieved ${filteredTrips.length} trips in date range');
      return filteredTrips;
    } catch (e) {
      AppLogger.getLogger('TripRepository').severe('Failed to get trips by date range: $e');
      throw DataException('Failed to get trips by date range: $e');
    }
  }

  Future<void> initialize() async {
    AppLogger.getLogger('TripRepository').info('TripRepository initialized');
  }
}
