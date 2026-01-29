import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_planner/core/exceptions/app_exceptions.dart';
import 'package:travel_planner/core/logging/logger.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
abstract class AuthLocalDataSource {
  Future<void> saveUser(User user, String hashedPassword);
  Future<Map<String, dynamic>?> getUserByEmail(String email);
  Future<User?> getCurrentUser();
  Future<void> saveCurrentSession(User user);
  Future<void> clearCurrentSession();
  Future<void> updateUser(User user);
  Future<void> updateUserPassword(String email, String hashedPassword);
  bool hasCurrentSession();
}
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box _authBox;
  final Box _usersBox;
  AuthLocalDataSourceImpl(this._authBox, this._usersBox);
  @override
  Future<void> saveUser(User user, String hashedPassword) async {
    try {
      await _usersBox.put(user.email, {
        'user': user.toMap(),
        'hashedPassword': hashedPassword,
        'createdAt': DateTime.now().toIso8601String(),
      });
      
      AppLogger.getLogger('AuthLocalDataSource').info('User saved: ${user.id}');
    } catch (e) {
      AppLogger.getLogger('AuthLocalDataSource').severe('Failed to save user: $e');
      throw StorageException('Failed to save user', e.toString());
    }
  }
  @override
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    try {
      final userData = _usersBox.get(email);
      return userData as Map<String, dynamic>?;
    } catch (e) {
      AppLogger.getLogger('AuthLocalDataSource').severe('Failed to get user by email: $e');
      throw StorageException('Failed to get user', e.toString());
    }
  }
  @override
  Future<User?> getCurrentUser() async {
    try {
      final userData = _authBox.get('user');
      if (userData == null) return null;
      
      return User.fromMap(userData as Map<String, dynamic>);
    } catch (e) {
      AppLogger.getLogger('AuthLocalDataSource').severe('Failed to get current user: $e');
      return null;
    }
  }
  @override
  Future<void> saveCurrentSession(User user) async {
    try {
      await _authBox.put('user', user.toMap());
      await _authBox.put('isLoggedIn', true);
      await _authBox.put('lastLogin', DateTime.now().toIso8601String());
      
      AppLogger.getLogger('AuthLocalDataSource').info('Session saved for user: ${user.id}');
    } catch (e) {
      AppLogger.getLogger('AuthLocalDataSource').severe('Failed to save session: $e');
      throw StorageException('Failed to save session', e.toString());
    }
  }
  @override
  Future<void> clearCurrentSession() async {
    try {
      await _authBox.clear();
      AppLogger.getLogger('AuthLocalDataSource').info('Session cleared');
    } catch (e) {
      AppLogger.getLogger('AuthLocalDataSource').severe('Failed to clear session: $e');
      throw StorageException('Failed to clear session', e.toString());
    }
  }
  @override
  Future<void> updateUser(User user) async {
    try {
      final userData = await _usersBox.get(user.email);
      if (userData != null) {
        userData['user'] = user.toMap();
        await _usersBox.put(user.email, userData);
        
        
        final currentUser = await getCurrentUser();
        if (currentUser?.id == user.id) {
          await saveCurrentSession(user);
        }
        
        AppLogger.getLogger('AuthLocalDataSource').info('User updated: ${user.id}');
      }
    } catch (e) {
      AppLogger.getLogger('AuthLocalDataSource').severe('Failed to update user: $e');
      throw StorageException('Failed to update user', e.toString());
    }
  }
  @override
  Future<void> updateUserPassword(String email, String hashedPassword) async {
    try {
      final userData = await _usersBox.get(email);
      if (userData != null) {
        userData['hashedPassword'] = hashedPassword;
        await _usersBox.put(email, userData);
        
        AppLogger.getLogger('AuthLocalDataSource').info('Password updated for email: $email');
      }
    } catch (e) {
      AppLogger.getLogger('AuthLocalDataSource').severe('Failed to update password: $e');
      throw StorageException('Failed to update password', e.toString());
    }
  }
  @override
  bool hasCurrentSession() {
    try {
      final isLoggedIn = _authBox.get('isLoggedIn', defaultValue: false) as bool;
      return isLoggedIn;
    } catch (e) {
      AppLogger.getLogger('AuthLocalDataSource').warning('Failed to check session: $e');
      return false;
    }
  }
}
