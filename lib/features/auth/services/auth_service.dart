import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_planner/core/exceptions/app_exceptions.dart';
import 'package:travel_planner/core/logging/logger.dart';
import 'package:travel_planner/core/security/input_sanitizer.dart';
import 'package:travel_planner/features/auth/models/user.dart';
class AuthService {
  static final AuthService _instance = AuthService._();
  factory AuthService() => _instance;
  AuthService._();
  final Box _authBox = Hive.box('auth');
  final Box _usersBox = Hive.box('users');
  Future<void> signUp(String email, String password, String name) async {
    try {
      AppLogger.getLogger('AuthService').info('Starting sign up for email: $email');
      
      final sanitizedEmail = InputSanitizer.sanitizeEmail(email);
      final sanitizedName = InputSanitizer.sanitizeName(name);
      final sanitizedPassword = InputSanitizer.sanitizePassword(password);
      
      if (sanitizedName.isEmpty) {
        throw const ValidationException('Name cannot be empty');
      }
      if (sanitizedEmail.isEmpty) {
        throw const ValidationException('Email cannot be empty');
      }
      if (sanitizedPassword.isEmpty) {
        throw const ValidationException('Password cannot be empty');
      }
      
      final existingUsers = _usersBox.values.map((value) => Map<String, dynamic>.from(value as Map));
      if (existingUsers.any((user) => user['email'] == sanitizedEmail)) {
        throw const AuthException('User with this email already exists');
      }
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: sanitizedName,
        email: sanitizedEmail,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await _usersBox.put(user.email, {
        ...user.toMap(),
        'password': sanitizedPassword, 
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      await _authBox.put('user', user.toMap());
      await _authBox.put('isLoggedIn', true);
      AppLogger.getLogger('AuthService').info('Sign up successful for user: ${user.id}');
    } on AppException {
      rethrow;
    } catch (e) {
      AppLogger.getLogger('AuthService').severe('Sign up failed: $e');
      throw AuthException('Failed to sign up', e.toString());
    }
  }
  Future<void> signIn(String email, String password) async {
    try {
      AppLogger.getLogger('AuthService').info('Starting sign in for email: $email');
      
      final sanitizedEmail = InputSanitizer.sanitizeEmail(email);
      final sanitizedPassword = InputSanitizer.sanitizePassword(password);
      
      final users = _usersBox.values.map((value) => Map<String, dynamic>.from(value as Map)).toList();
      AppLogger.getLogger('AuthService').info('Found ${users.length} users in box');
      final userData = users.firstWhere(
        (user) => user['email'] == sanitizedEmail,
        orElse: () {
          AppLogger.getLogger('AuthService').warning('User not found for email: $sanitizedEmail');
          return throw const NotFoundException('User not found');
        },
      );
      
      final storedPassword = userData['password'] as String;
      AppLogger.getLogger('AuthService').info('Comparing passwords: stored length=${storedPassword.length}, input length=${sanitizedPassword.length}');
      final isPasswordValid = sanitizedPassword == storedPassword;
      if (!isPasswordValid) {
        AppLogger.getLogger('AuthService').warning('Password mismatch for email: $sanitizedEmail');
        throw const AuthException('Invalid email or password');
      }
      final user = User.fromMap(userData);
      
      await _authBox.put('user', user.toMap());
      await _authBox.put('isLoggedIn', true);
      await _authBox.put('lastLogin', DateTime.now().toIso8601String());
      AppLogger.getLogger('AuthService').info('Sign in successful for user: ${user.id}');
    } on AppException {
      rethrow;
    } catch (e) {
      AppLogger.getLogger('AuthService').severe('Sign in failed: $e');
      throw AuthException('Failed to sign in', e.toString());
    }
  }
  Future<void> signOut() async {
    try {
      AppLogger.getLogger('AuthService').info('Signing out user');
      await _authBox.clear();
    } catch (e) {
      AppLogger.getLogger('AuthService').severe('Sign out failed: $e');
      throw StorageException('Failed to sign out', e.toString());
    }
  }
  bool isLoggedIn() {
    try {
      return _authBox.get('isLoggedIn', defaultValue: false) as bool;
    } catch (e) {
      AppLogger.getLogger('AuthService').severe('Error checking login status: $e');
      return false;
    }
  }
  User? getCurrentUser() {
    try {
      final userData = _authBox.get('user');
      if (userData != null) {
        final userMap = Map<String, dynamic>.from(userData as Map);
        return User.fromMap(userMap);
      }
      return null;
    } catch (e) {
      AppLogger.getLogger('AuthService').severe('Error parsing user data: $e');
      return null;
    }
  }
  Future<void> updateProfile(String name, String email) async {
    try {
      final currentUser = getCurrentUser();
      if (currentUser == null) {
        throw const AuthException('No user logged in');
      }
      
      final sanitizedName = InputSanitizer.sanitizeName(name);
      final sanitizedEmail = InputSanitizer.sanitizeEmail(email);
      if (sanitizedName.isEmpty) {
        throw const ValidationException('Name cannot be empty');
      }
      
      await Future.delayed(const Duration(seconds: 1));
      
      final updatedUser = currentUser.copyWith(
        name: sanitizedName,
        email: sanitizedEmail,
        updatedAt: DateTime.now(),
      );
      final existingUserData = Map<String, dynamic>.from(_usersBox.get(currentUser.email) as Map);
      
      await _usersBox.put(currentUser.email, {
        ...updatedUser.toMap(),
        'password': existingUserData['password'],
        'createdAt': existingUserData['createdAt'],
      });
      await _authBox.put('user', updatedUser.toMap());
      AppLogger.getLogger('AuthService').info('Profile updated for user: ${updatedUser.id}');
    } on AppException {
      rethrow;
    } catch (e) {
      AppLogger.getLogger('AuthService').severe('Update profile failed: $e');
      throw AuthException('Failed to update profile', e.toString());
    }
  }
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      final currentUser = getCurrentUser();
      if (currentUser == null) {
        throw const AuthException('No user logged in');
      }
      
      if (currentPassword.isEmpty || newPassword.isEmpty) {
        throw const ValidationException('Current and new passwords are required');
      }
      if (newPassword.length < 6) {
        throw const ValidationException('New password must be at least 6 characters');
      }
      
      await Future.delayed(const Duration(seconds: 1));
      
      final userData = Map<String, dynamic>.from(_usersBox.get(currentUser.email) as Map);
      final currentStoredPassword = userData['password'] as String;
      
      final isCurrentPasswordValid = currentPassword == currentStoredPassword;
      if (!isCurrentPasswordValid) {
        throw const AuthException('Current password is incorrect');
      }
      
      userData['password'] = newPassword;
      await _usersBox.put(currentUser.email, userData);
      AppLogger.getLogger('AuthService').info('Password changed for user: ${currentUser.id}');
    } on AppException {
      rethrow;
    } catch (e) {
      AppLogger.getLogger('AuthService').severe('Change password failed: $e');
      throw AuthException('Failed to change password', e.toString());
    }
  }
  Future<void> deleteAccount() async {
    try {
      final currentUser = getCurrentUser();
      if (currentUser == null) {
        throw const AuthException('No user logged in');
      }
      AppLogger.getLogger('AuthService').info('Deleting account for user: ${currentUser.id}');
      
      await _usersBox.delete(currentUser.email);
      
      await _authBox.clear();
      AppLogger.getLogger('AuthService').info('Account deleted successfully for user: ${currentUser.id}');
    } on AppException {
      rethrow;
    } catch (e) {
      AppLogger.getLogger('AuthService').severe('Delete account failed: $e');
      throw AuthException('Failed to delete account', e.toString());
    }
  }
}
