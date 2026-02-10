class ImageConstants {
  ImageConstants._();

  // Avatar dimensions
  static const double avatarMaxWidth = 800.0;
  static const double avatarMaxHeight = 800.0;
  static const double avatarThumbnailWidth = 100.0;
  static const double avatarThumbnailHeight = 100.0;

  // Avatar quality
  static const int avatarQuality = 85;

  // Avatar fallback
  static const String avatarFallbackPath = 'assets/images/avatar_fallback.png';
}

class ValidationConstants {
  ValidationConstants._();

  static const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{6,}$';
}

class FileUploadConstants {
  FileUploadConstants._();

  // File size limits (in bytes)
  static const int maxAvatarFileSize = 5 * 1024 * 1024; // 5MB
  static const int minAvatarFileSize = 100; // 100 bytes

  // Supported image formats
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png'];
  static const List<String> supportedMimeTypes = ['image/jpeg', 'image/png'];

  // File signatures for validation
  static const List<int> jpegSignature = [0xFF, 0xD8, 0xFF];
  static const List<int> pngSignature = [0x89, 0x50, 0x4E, 0x47];
}
