import 'package:travel_planner/features/auth/domain/entities/user.dart';
abstract class AuthRepository {
  Future<User> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<User> signIn({
    required String email,
    required String password,
  });
  Future<User> getCurrentUser();
  Future<void> signOut();
  Future<void> updateProfile({
    required String name,
    required String email,
  });
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  bool isLoggedIn();
}
