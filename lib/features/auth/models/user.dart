import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'user.g.dart';
@HiveType(typeId: 1)
class User extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  final DateTime updatedAt;
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });
  User copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toString(),
      name: map['name'].toString(),
      email: map['email'].toString(),
      createdAt: DateTime.parse(map['createdAt'].toString()),
      updatedAt: DateTime.parse(map['updatedAt'].toString()),
    );
  }
  @override
  List<Object> get props => [id, name, email, createdAt, updatedAt];
  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}
