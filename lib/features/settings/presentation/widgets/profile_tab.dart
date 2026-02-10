import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/core/result/result_handler.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/shared/widgets/section_card.dart';
import 'package:travel_planner/shared/widgets/forms/app_text_field.dart';
import 'package:travel_planner/shared/widgets/app_button.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_notifier.dart';
import 'package:travel_planner/features/settings/presentation/providers/profile_edit_provider.dart';
import 'package:travel_planner/features/settings/presentation/widgets/editable_avatar_section.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/shared/widgets/dialogs/app_confirmation_dialog.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final user = ref.read(authNotifierProvider).value;
    _nameController = TextEditingController(text: user?.name ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authNotifierProvider).value;
    final profileEditState = ref.watch(profileEditNotifierProvider);
    final profileEditNotifier = ref.read(profileEditNotifierProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        spacing: 16,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.colorScheme.primary.withValues(alpha: 0.05),
                  context.colorScheme.primary.withValues(alpha: 0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: context.colorScheme.primary.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    const EditableAvatarSection(),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user?.name ?? context.l10n.heading_profile,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.headlineSmall?.copyWith(
                              color: context.colorScheme.onSurface,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified_user_outlined,
                                size: 14,
                                color: context.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  context.l10n.label_verified.toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: context.colorScheme.primary,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.5,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (!profileEditState.isEditing)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _startEdit(profileEditNotifier),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.edit_outlined,
                            size: 20,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SectionCard(
            title: context.l10n.heading_personal_info,
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 20,
                children: [
                  AppTextField(
                    controller: _nameController,
                    label: context.l10n.label_name,
                    hint: context.l10n.hint_enter_name,
                    prefixIcon: Icons.person_outline,
                    enabled: profileEditState.isEditing,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return context.l10n.error_required_field;
                      }
                      if (val.length < 2) {
                        return 'Name must be at least 2 characters';
                      }
                      if (val.length > 50) {
                        return 'Name must be less than 50 characters';
                      }
                      return null;
                    },
                  ),
                  if (profileEditState.isEditing) ...[
                    const SizedBox(height: 12),
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: AppButton(
                            text: context.l10n.action_save,
                            onPressed: profileEditState.isSaving
                                ? null
                                : () => _saveProfile(profileEditNotifier),
                            isLoading: profileEditState.isSaving,
                            variant: AppButtonVariant.primary,
                          ),
                        ),
                        Expanded(
                          child: AppButton(
                            text: context.l10n.action_cancel,
                            onPressed: profileEditState.isSaving
                                ? null
                                : () => _cancelEdit(profileEditNotifier, user),
                            variant: AppButtonVariant.secondary,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    const SizedBox(height: 0),
                  ],
                  if (profileEditState.successMessage != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: context.colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              profileEditState.successMessage!,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            onPressed: () =>
                                profileEditNotifier.clearSuccessMessage(),
                            color: context.colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          SectionCard(
            title: context.l10n.heading_account_actions,
            child: Column(
              spacing: 16,
              children: [
                _AccountActionButton(
                  icon: Icons.logout_outlined,
                  label: context.l10n.action_sign_out,
                  description: context.l10n.dialog_sign_out_title,
                  color: context.colorScheme.primary,
                  onTap: () => _showSignOutDialog(context),
                ),
                _AccountActionButton(
                  icon: Icons.delete_outline,
                  label: context.l10n.action_delete_account,
                  description: context.l10n.label_delete_account_warning,
                  color: context.colorScheme.error,
                  onTap: () => _showDeleteAccountDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _startEdit(ProfileEditNotifier profileEditNotifier) {
    final user = ref.read(authNotifierProvider).value;
    _nameController.text = user?.name ?? '';
    profileEditNotifier.startEditing();
  }

  void _cancelEdit(ProfileEditNotifier profileEditNotifier, User? user) {
    _nameController.text = user?.name ?? '';
    profileEditNotifier.cancelEditing();
  }

  Future<void> _saveProfile(ProfileEditNotifier profileEditNotifier) async {
    if (!_formKey.currentState!.validate()) return;

    // Cache localized strings before async gap
    final successMessage = context.l10n.label_profile_updated;
    final noChangesMessage = context.l10n.label_no_changes;
    final errorMessage = context.l10n.error_update_profile;

    profileEditNotifier.setSaving(true);
    profileEditNotifier.clearErrors();

    try {
      final user = ref.read(authNotifierProvider).value;
      final newName = _nameController.text.trim();

      if (user != null && user.name != newName) {
        await ref
            .read(authNotifierProvider.notifier)
            .updateProfile(name: newName);
        profileEditNotifier.setSuccessMessage(successMessage);
        profileEditNotifier.cancelEditing();
      } else {
        profileEditNotifier.setSuccessMessage(noChangesMessage);
        profileEditNotifier.cancelEditing();
      }
    } catch (e) {
      profileEditNotifier.setNameError(errorMessage);
    } finally {
      profileEditNotifier.setSaving(false);
    }
  }

  Future<void> _showSignOutDialog(BuildContext context) async {
    final confirmed = await AppConfirmationDialog.show(
      context,
      title: context.l10n.action_sign_out,
      message: context.l10n.dialog_sign_out_title,
      confirmText: context.l10n.action_sign_out,
      cancelText: context.l10n.action_cancel,
    );

    if (confirmed && context.mounted) {
      try {
        await ref.read(authNotifierProvider.notifier).logout();
        if (context.mounted) {
          context.go(AppRoutes.authPath);
        }
      } catch (e) {
        if (context.mounted) {
          ResultHandler.showErrorToast(
            context,
            context.l10n.error_failed_sign_out,
          );
        }
      }
    }
  }

  Future<void> _showDeleteAccountDialog(BuildContext context) async {
    final confirmed = await AppConfirmationDialog.show(
      context,
      title: context.l10n.action_delete_account,
      message:
          '${context.l10n.dialog_delete_account_confirm}\n\n${context.l10n.label_delete_account_warning}',
      confirmText: context.l10n.action_delete_account,
      cancelText: context.l10n.action_cancel,
      isDangerous: true,
    );

    if (confirmed && context.mounted) {
      _deleteAccount();
    }
  }

  Future<void> _deleteAccount() async {
    try {
      await ref.read(authNotifierProvider.notifier).deleteAccount();
      if (mounted) {
        ResultHandler.showSuccessToast(
          context,
          context.l10n.toast_account_deleted,
        );
      }
    } catch (e) {
      if (mounted) {
        ResultHandler.showErrorToast(
          context,
          context.l10n.error_failed_delete_account_full(e.toString()),
        );
      }
    }
  }
}

class _AccountActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _AccountActionButton({
    required this.icon,
    required this.label,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1.5),
          borderRadius: BorderRadius.circular(12),
          color: color.withValues(alpha: 0.05),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color, color.withValues(alpha: 0.8)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: color,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.7,
                      ),
                      letterSpacing: -0.1,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color.withValues(alpha: 0.6),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
