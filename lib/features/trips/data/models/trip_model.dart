import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class TripModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  final String id;

  @HiveField(1)
  @JsonKey(name: 'title')
  final String title;

  @HiveField(2)
  @JsonKey(name: 'description')
  final String description;

  @HiveField(3)
  @JsonKey(name: 'destination')
  final String destination;

  @HiveField(4)
  @JsonKey(name: 'startDate')
  final DateTime startDate;

  @HiveField(5)
  @JsonKey(name: 'endDate')
  final DateTime endDate;

  @HiveField(6)
  @JsonKey(name: 'budget')
  final double budget;

  @HiveField(7)
  @JsonKey(name: 'status')
  final String status;

  @HiveField(8)
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @HiveField(9)
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  TripModel({
    required this.id,
    required this.title,
    required this.description,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.budget,
    this.status = 'planned',
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripModel.fromDomain(Trip trip) {
    return TripModel(
      id: trip.id,
      title: trip.title,
      description: trip.description,
      destination: trip.destination,
      startDate: trip.startDate,
      endDate: trip.endDate,
      budget: trip.budget,
      status: trip.status.name,
      createdAt: trip.createdAt,
      updatedAt: trip.updatedAt,
    );
  }

  Trip toDomain() {
    return Trip(
      id: id,
      title: title,
      description: description,
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      budget: budget,
      status: TripStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => TripStatus.planned,
      ),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJson() => _$TripModelToJson(this);

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);

  TripModel copyWith({
    String? id,
    String? title,
    String? description,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    double? budget,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TripModel(
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
}
