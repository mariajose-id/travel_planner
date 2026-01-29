import 'package:travel_planner/core/exceptions/app_exceptions.dart';
import 'package:travel_planner/core/security/input_sanitizer.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';
class SignUpUseCase {
  final AuthRepository _repository;
  SignUpUseCase(this._repository);
  Future<User> execute({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      
      final sanitizedEmail = InputSanitizer.sanitizeEmail(email);
      final sanitizedName = InputSanitizer.sanitizeName(name);
      final sanitizedPassword = InputSanitizer.sanitizePassword(password);
      
      if (sanitizedName.isEmpty) {
        throw const ValidationException('Name cannot be empty');
      }
      return await _repository.signUp(
        email: sanitizedEmail,
        password: sanitizedPassword,
        name: sanitizedName,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw AuthException('Failed to sign up', e.toString());
    }
  }
}
