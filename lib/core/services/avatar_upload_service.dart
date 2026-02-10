import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'avatar_upload_service.g.dart';

/// Service responsible for avatar image operations.
/// Clean architecture: Infrastructure layer service.
class AvatarUploadService {
  final ImagePicker _imagePicker = ImagePicker();

  static const double _maxImageDimension = 1000.0;
  static const int _imageQuality = 85;
  static const int _maxFileSizeBytes = 5 * 1024 * 1024; // 5MB

  Future<File?> pickImageFromGallery() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: _maxImageDimension,
        maxHeight: _maxImageDimension,
        imageQuality: _imageQuality,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      throw AvatarUploadException('Failed to pick image: $e');
    }
  }

  Future<File?> pickImageFromCamera() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: _maxImageDimension,
        maxHeight: _maxImageDimension,
        imageQuality: _imageQuality,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      throw AvatarUploadException('Failed to capture image: $e');
    }
  }

  Future<String> uploadAvatar({
    required File imageFile,
    required String userId,
  }) async {
    // Validate file
    final validationResult = await _validateImageFile(imageFile);
    if (!validationResult.isValid) {
      throw AvatarUploadException(validationResult.error!);
    }

    // Generate unique filename
    final fileName = '${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Note: In production, replace with actual storage service
    // (Firebase Storage, AWS S3, Supabase Storage, etc.)
    // For now, return local file path as the "URL"
    final localPath = imageFile.path;

    // Simulate network delay for realistic UX testing
    await Future.delayed(const Duration(milliseconds: 500));

    return localPath.isNotEmpty ? localPath : 'avatars/$fileName';
  }

  Future<void> deleteAvatar({required String avatarUrl}) async {
    if (avatarUrl.isEmpty) return;

    // Note: In production, implement actual deletion
    // For local files in app directory, you would:
    // 1. Check if path is within app's document directory
    // 2. Delete the file if it exists
    // For cloud storage, call the appropriate API
  }

  Future<_ValidationResult> _validateImageFile(File file) async {
    try {
      final bytes = await file.readAsBytes();

      // Check file size
      if (bytes.length > _maxFileSizeBytes) {
        return _ValidationResult.invalid('Image file is too large (max 5MB)');
      }

      if (bytes.length < 100) {
        return _ValidationResult.invalid('Image file is too small');
      }

      // Validate file signature (magic bytes)
      if (bytes.length >= 3) {
        final isJpeg = bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF;
        final isPng = bytes[0] == 0x89 && bytes[1] == 0x50 && bytes[2] == 0x4E;

        if (!isJpeg && !isPng) {
          return _ValidationResult.invalid(
            'Invalid image format. Only JPEG and PNG are supported.',
          );
        }
      }

      return _ValidationResult.valid();
    } catch (e) {
      return _ValidationResult.invalid('Failed to validate image: $e');
    }
  }
}

class _ValidationResult {
  final bool isValid;
  final String? error;

  const _ValidationResult._(this.isValid, this.error);

  factory _ValidationResult.valid() => const _ValidationResult._(true, null);
  factory _ValidationResult.invalid(String error) =>
      _ValidationResult._(false, error);
}

class AvatarUploadException implements Exception {
  final String message;
  const AvatarUploadException(this.message);

  @override
  String toString() => 'AvatarUploadException: $message';
}

@riverpod
AvatarUploadService avatarUploadService(Ref ref) {
  return AvatarUploadService();
}
