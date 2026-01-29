abstract class AppException implements Exception {
  final String message;
  final String? details;
  const AppException(this.message, [this.details]);
  @override
  String toString() => details != null ? '$message: $details' : message;
}
class AuthException extends AppException {
  const AuthException(super.message, [super.details]);
}
class ValidationException extends AppException {
  const ValidationException(super.message, [super.details]);
}
class StorageException extends AppException {
  const StorageException(super.message, [super.details]);
}
class NetworkException extends AppException {
  const NetworkException(super.message, [super.details]);
}
class NotFoundException extends AppException {
  const NotFoundException(super.message, [super.details]);
}
class ServerException extends AppException {
  const ServerException(super.message, [super.details]);
}
class DataException extends AppException {
  const DataException(super.message, [super.details]);
}
