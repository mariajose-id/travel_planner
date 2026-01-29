import 'package:travel_planner/core/exceptions/app_exceptions.dart';
import 'package:travel_planner/core/security/input_sanitizer.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';
class SignInUseCase {
  final AuthRepository _repository;
  SignInUseCase(this._repository);
  Future<User> execute({
    required String email,
    required String password,
  }) async {
    try {
      
      final sanitizedEmail = InputSanitizer.sanitizeEmail(email);
      final sanitizedPassword = InputSanitizer.sanitizePassword(password);
      return await _repository.signIn(
        email: sanitizedEmail,
        password: sanitizedPassword,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AuthException('Failed to sign in', e.toString());
    }
  }
}
