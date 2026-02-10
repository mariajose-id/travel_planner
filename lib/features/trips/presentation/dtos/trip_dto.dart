import 'package:flutter/material.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/core/services/multi_currency_service.dart';
import 'package:travel_planner/features/trips/domain/value_objects/money.dart';

class TripDto {
  final Trip trip;

  const TripDto(this.trip);

  String get displayDestination => trip.destination.value;
  String get displayStartDate =>
      MultiCurrencyService.formatDate(trip.startDate.value);
  String get displayBudget =>
      MultiCurrencyService.formatAmount(Money.usd(trip.budget.amount));
  String get title => trip.title;

  Color get statusColor => switch (trip.status) {
    TripStatus.planned => const Color(0xFF3D2B1F), // Deep Coffee
    TripStatus.upcoming => const Color(0xFFB45309), // Warm Amber/Burnt Orange
    TripStatus.completed => const Color(0xFF166534), // Forest Green
  };

  IconData get statusIcon => switch (trip.status) {
    TripStatus.planned => Icons.calendar_today,
    TripStatus.upcoming => Icons.flight_takeoff,
    TripStatus.completed => Icons.check_circle,
  };

  TripStatus get status => trip.status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TripDto && trip.id == other.trip.id;

  @override
  int get hashCode => trip.id.hashCode;

  @override
  String toString() =>
      'Trip(id: ${trip.id}, title: ${trip.title}, destination: ${trip.destination.value}, status: ${trip.status})';
}
