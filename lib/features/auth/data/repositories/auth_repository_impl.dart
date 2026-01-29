import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';
import 'package:travel_planner/core/exceptions/app_exceptions.dart';
import 'package:travel_planner/core/logging/logger.dart';
import 'package:travel_planner/core/security/password_hasher.dart';
import 'package:travel_planner/features/auth/data/datasources/local/auth_local_datasource.dart';
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;
  AuthRepositoryImpl(this._localDataSource);
  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      AppLogger.getLogger('AuthRepositoryImpl').info('Starting sign up for email: $email');
      
      final existingUser = await _localDataSource.getUserByEmail(email);
      if (existingUser != null) {
        throw const AuthException('User with this email already exists');
      }
      
      final hashedPassword = PasswordHasher.hashPassword(password);
      
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await _localDataSource.saveUser(user, hashedPassword);
      await _localDataSource.saveCurrentSession(user);
      AppLogger.getLogger('AuthRepository').info('Sign up successful for user: ${user.id}');
      return user;
    } on AppException {
      rethrow;
    } catch (e) {
      AppLogger.getLogger('AuthRepository').severe('Sign up failed: $e');
      throw AuthException('Failed to sign up', e.toString());
    }
  }
  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      AppLogger.getLogger('AuthRepository').info('Starting sign in for email: $email');
      
      final userData = await _localDataSource.getUserByEmail(email);
      if (userData == null) {
        throw const NotFoundException('User not found');
      }
      
      final isPasswordValid = PasswordHasher.verifyPassword(
        password,
        userData['hashedPassword'] as String,
      );
      if (!isPasswordValid) {
        throw const AuthException('Invalid email or password');
      }
      
      final user = User.fromMap(userData['user'] as Map<String, dynamic>);
      
      await _localDataSource.saveCurrentSession(user);
      AppLogger.getLogger('AuthRepository').info('Sign in successful for user: ${user.id}');
      return user;
    } on AppException {
      rethrow;
    } catch (e) {
      AppLogger.getLogger('AuthRepository').severe('Sign in failed: $e');
      throw AuthException('Failed to sign in', e.toString());
    }
  }
  @override
  Future<User> getCurrentUser() async {
    try {
      final user = await _localDataSource.getCurrentUser();
      if (user == null) {
        throw const NotFoundException('No user logged in');
      }
      return user;
    } on AppException {
      rethrow;
    } catch (e) {
      AppLogger.getLogger('AuthRepository').severe('Get current user failed: $e');
      throw AuthException('Failed to get current user', e.toString());
    }
  }
  @override
  Future<void> signOut() async {
    try {
      AppLogger.getLogger('AuthRepository').info('Signing out user');
      await _localDataSource.clearCurrentSession();
    } catch (e) {
      AppLogger.getLogger('AuthRepository').severe('Sign out failed: $e');
      throw AuthException('Failed to sign out', e.toString());
    }
  }
  @override
  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    try {
      final currentUser = await getCurrentUser();
      
      final updatedUser = currentUser.copyWith(
        name: name,
        email: email,
        updatedAt: DateTime.now(),
      );
      await _localDataSource.updateUser(updatedUser);
      await _localDataSource.saveCurrentSession(updatedUser);
      AppLogger.getLogger('AuthRepository').info('Profile updated for user: ${updatedUser.id}');
    } on AppException {
      rethrow;
    } catch (e) {
      AppLogger.getLogger('AuthRepository').severe('Update profile failed: $e');
      throw AuthException('Failed to update profile', e.toString());
    }
  }
  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final currentUser = await getCurrentUser();
      
      
      final userData = await _localDataSource.getUserByEmail(currentUser.email);
      if (userData == null) {
        throw const NotFoundException('User not found');
      }
      
      final isCurrentPasswordValid = PasswordHasher.verifyPassword(
        currentPassword,
        userData['hashedPassword'] as String,
      );
      if (!isCurrentPasswordValid) {
        throw const AuthException('Current password is incorrect');
      }
      
      final newHashedPassword = PasswordHasher.hashPassword(newPassword);
      
      await _localDataSource.updateUserPassword(currentUser.email, newHashedPassword);
      AppLogger.getLogger('AuthRepository').info('Password changed for user: ${currentUser.id}');
    } on AppException {
      rethrow;
    } catch (e) {
      AppLogger.getLogger('AuthRepository').severe('Change password failed: $e');
      throw AuthException('Failed to change password', e.toString());
    }
  }
  @override
  bool isLoggedIn() {
    return _localDataSource.hasCurrentSession();
  }
}
