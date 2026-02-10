import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/core/services/avatar_upload_service.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_notifier.dart';
import 'package:travel_planner/features/settings/presentation/providers/profile_edit_provider.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';

class EditableAvatarSection extends ConsumerStatefulWidget {
  const EditableAvatarSection({super.key});

  @override
  ConsumerState<EditableAvatarSection> createState() =>
      _EditableAvatarSectionState();
}

class _EditableAvatarSectionState extends ConsumerState<EditableAvatarSection> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authNotifierProvider).value;
    ref.watch(profileEditNotifierProvider);
    final profileEditNotifier = ref.read(profileEditNotifierProvider.notifier);
    final avatarUploadService = ref.watch(avatarUploadServiceProvider);

    return GestureDetector(
      onTap: () =>
          _showAvatarOptions(context, avatarUploadService, profileEditNotifier),
      child: Stack(
        children: [
          _AvatarContainer(user: user),
          const _CameraIconBadge(),
        ],
      ),
    );
  }

  void _showAvatarOptions(
    BuildContext context,
    AvatarUploadService avatarUploadService,
    ProfileEditNotifier profileEditNotifier,
  ) {
    final hasAvatar = ref.read(authNotifierProvider).value?.avatarUrl != null;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AvatarOptionsSheet(
        hasAvatar: hasAvatar,
        onGalleryTap: () {
          Navigator.pop(ctx);
          _handlePickFromGallery(avatarUploadService, profileEditNotifier);
        },
        onCameraTap: () {
          Navigator.pop(ctx);
          _handlePickFromCamera(avatarUploadService, profileEditNotifier);
        },
        onRemoveTap: () {
          Navigator.pop(ctx);
          _handleRemoveAvatar(profileEditNotifier);
        },
      ),
    );
  }

  Future<void> _handlePickFromGallery(
    AvatarUploadService service,
    ProfileEditNotifier notifier,
  ) async {
    try {
      final file = await service.pickImageFromGallery();
      if (file != null) {
        await _uploadAvatar(file, service, notifier);
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    }
  }

  Future<void> _handlePickFromCamera(
    AvatarUploadService service,
    ProfileEditNotifier notifier,
  ) async {
    try {
      final file = await service.pickImageFromCamera();
      if (file != null) {
        await _uploadAvatar(file, service, notifier);
      }
    } catch (e) {
      _showError('Failed to capture image: $e');
    }
  }

  Future<void> _uploadAvatar(
    File file,
    AvatarUploadService service,
    ProfileEditNotifier notifier,
  ) async {
    try {
      final user = ref.read(authNotifierProvider).value;
      if (user == null) return;

      final avatarUrl = await service.uploadAvatar(
        imageFile: file,
        userId: user.id,
      );

      await ref.read(authNotifierProvider.notifier).updateAvatar(avatarUrl);
      notifier.setSuccessMessage('Avatar updated successfully!');
      _showSuccess('Avatar updated successfully!');
    } catch (e) {
      _showError('Failed to upload avatar: $e');
    }
  }

  void _handleRemoveAvatar(ProfileEditNotifier notifier) {
    ref.read(authNotifierProvider.notifier).updateAvatar(null);
    notifier.setSuccessMessage('Avatar removed!');
    _showSuccess('Avatar removed!');
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.colorScheme.error,
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.colorScheme.primary,
      ),
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  final User? user;

  const _AvatarContainer({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colorScheme.primary,
            context.colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: _AvatarImage(avatarUrl: user?.avatarUrl),
      ),
    );
  }
}

class _CameraIconBadge extends StatelessWidget {
  const _CameraIconBadge();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.colorScheme.secondary,
              context.colorScheme.secondary.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: context.colorScheme.surface, width: 3),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.secondary.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
      ),
    );
  }
}

class _AvatarImage extends StatelessWidget {
  final String? avatarUrl;

  const _AvatarImage({required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null) {
      return Image.network(
        avatarUrl!,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(context),
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 120,
            height: 120,
            color: Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            ),
          );
        },
      );
    }
    return _buildFallback(context);
  }

  Widget _buildFallback(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: Image.asset(
        'assets/images/avatar_fallback.png',
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 120,
          height: 120,
          color: context.colorScheme.primary.withValues(alpha: 0.2),
          child: Icon(
            Icons.person,
            size: 48,
            color: context.colorScheme.onPrimary.withValues(alpha: 0.9),
          ),
        ),
      ),
    );
  }
}

class _AvatarOptionsSheet extends StatelessWidget {
  final bool hasAvatar;
  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;
  final VoidCallback onRemoveTap;

  const _AvatarOptionsSheet({
    required this.hasAvatar,
    required this.onGalleryTap,
    required this.onCameraTap,
    required this.onRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.outline.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Update Avatar',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AvatarOption(
                icon: Icons.photo_library,
                label: 'Gallery',
                color: context.colorScheme.primary,
                onTap: onGalleryTap,
              ),
              _AvatarOption(
                icon: Icons.camera_alt,
                label: 'Camera',
                color: context.colorScheme.secondary,
                onTap: onCameraTap,
              ),
              if (hasAvatar)
                _AvatarOption(
                  icon: Icons.delete,
                  label: 'Remove',
                  color: context.colorScheme.error,
                  onTap: onRemoveTap,
                ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _AvatarOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AvatarOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.withValues(alpha: 0.8)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
