import 'package:equatable/equatable.dart';
import 'package:travel_planner/core/constants/app_constants.dart';
import 'package:travel_planner/core/constants/image_constants.dart';
import 'package:travel_planner/core/validation/validation_types.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
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
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
  @override
  List<Object> get props => [id, name, email, createdAt, updatedAt];
  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';

  ValidationOutcome validate() {
    final errors = <ValidationError>[];

    // Validate name
    if (name.isEmpty) {
      errors.add(const ValidationError(
        field: 'name',
        type: ValidationType.required,
      ));
    } else if (name.length < AppConstants.minPasswordLength) {
      errors.add(ValidationError(
        field: 'name',
        type: ValidationType.minLength,
        expected: AppConstants.minPasswordLength.toString(),
        actual: name.length,
      ));
    } else if (name.length > AppConstants.maxNameLength) {
      errors.add(ValidationError(
        field: 'name',
        type: ValidationType.maxLength,
        expected: AppConstants.maxNameLength.toString(),
        actual: name.length,
      ));
    }

    // Validate email
    if (email.isEmpty) {
      errors.add(const ValidationError(
        field: 'email',
        type: ValidationType.required,
      ));
    } else if (email.length > AppConstants.maxEmailLength) {
      errors.add(ValidationError(
        field: 'email',
        type: ValidationType.maxLength,
        expected: AppConstants.maxEmailLength.toString(),
        actual: email.length,
      ));
    } else if (!RegExp(ValidationConstants.emailPattern).hasMatch(email)) {
      errors.add(const ValidationError(
        field: 'email',
        type: ValidationType.emailPattern,
      ));
    }

    return errors.isEmpty 
        ? ValidationOutcome.success()
        : ValidationOutcome.failure(errors);
  }
}
