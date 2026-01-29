import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'trip.g.dart';
@HiveType(typeId: 2)
@JsonSerializable()
class Trip extends Equatable {
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
  const Trip({
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
  Trip copyWith({
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
  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
  
  Map<String, dynamic> toJson() => _$TripToJson(this);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'destination': destination,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'budget': budget,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'].toString(),
      title: map['title'].toString(),
      description: map['description'].toString(),
      destination: map['destination'].toString(),
      startDate: DateTime.parse(map['startDate'].toString()),
      endDate: DateTime.parse(map['endDate'].toString()),
      budget: double.parse(map['budget'].toString()),
      status: map['status'].toString(),
      createdAt: DateTime.parse(map['createdAt'].toString()),
      updatedAt: DateTime.parse(map['updatedAt'].toString()),
    );
  }
  @override
  List<Object> get props => [
    id, title, description, destination, 
    startDate, endDate, budget, status, 
    createdAt, updatedAt
  ];
  @override
  String toString() => 'Trip(id: $id, title: $title, destination: $destination)';
}
