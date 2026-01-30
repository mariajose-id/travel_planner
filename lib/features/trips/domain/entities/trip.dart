import 'package:equatable/equatable.dart';

enum TripStatus { planned, upcoming, completed }

class Trip extends Equatable {
  final String id;
  final String title;
  final String description;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final double budget;
  final TripStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Trip({
    required this.id,
    required this.title,
    required this.description,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.budget,
    this.status = TripStatus.planned,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Trip.fromStatusString({required TripStatus status, required Trip trip}) {
    return Trip(
      id: trip.id,
      title: trip.title,
      description: trip.description,
      destination: trip.destination,
      startDate: trip.startDate,
      endDate: trip.endDate,
      budget: trip.budget,
      status: status,
      createdAt: trip.createdAt,
      updatedAt: trip.updatedAt,
    );
  }

  Trip copyWith({
    String? id,
    String? title,
    String? description,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    double? budget,
    TripStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      budget: budget ?? this.budget,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        destination,
        startDate,
        endDate,
        budget,
        status,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() =>
      'Trip(id: $id, title: $title, destination: $destination, status: $status)';
}
