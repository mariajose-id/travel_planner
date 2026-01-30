import 'package:travel_planner/features/trips/domain/entities/trip.dart';

abstract class TripRepository {
  Future<Trip> createTrip(Trip trip);

  Future<List<Trip>> getAllTrips();

  Future<Trip?> getTripById(String id);

  Future<void> updateTrip(Trip trip);

  Future<void> deleteTrip(String id);

  Future<List<Trip>> searchTrips({
    String? query,
    TripStatus? status,
    String? destination,
  });

  Future<List<Trip>> getTripsByStatus(TripStatus status);

  Future<List<Trip>> getTripsByDateRange(DateTime startDate, DateTime endDate);
}
