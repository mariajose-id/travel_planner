import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/core/result/result_handler.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_notifier.dart';
import 'package:travel_planner/features/auth/presentation/providers/sign_up_form_provider.dart';
import 'package:travel_planner/shared/widgets/app_button.dart';
import 'package:travel_planner/shared/widgets/forms/app_text_field.dart';
import 'package:travel_planner/features/auth/presentation/widgets/auth_header.dart';
import 'package:go_router/go_router.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() != true) return;

    final passwordMismatch = context.l10n.error_passwords_dont_match;
    final successMessage = context.l10n.toast_welcome_to_wanderly;

    if (_passwordController.text != _confirmPasswordController.text) {
      ResultHandler.showErrorToast(context, passwordMismatch);
      return;
    }

    final result = await ref
        .read(authNotifierProvider.notifier)
        .register(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
        );

    if (result.isSuccess) {
      if (!mounted) return;
      ResultHandler.showSuccessToast(context, successMessage);
      context.goNamed(AppRoutes.home);
    } else {
      if (!mounted) return;
      ResultHandler.handleResult(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final authState = ref.watch(authNotifierProvider);
    final formState = ref.watch(signUpFormNotifierProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthHeader(
            title: context.l10n.heading_create_account,
            subtitle: context.l10n.heading_sign_up_subtitle,
          ),
          const SizedBox(height: 24),
          AppTextField(
            controller: _nameController,
            label: context.l10n.label_name,
            hint: context.l10n.hint_enter_name,
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return context.l10n.error_required_field;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _emailController,
            label: context.l10n.label_email,
            hint: context.l10n.hint_enter_email,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return context.l10n.error_required_field;
              }
              if (!val.contains('@')) {
                return context.l10n.error_invalid_email;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _passwordController,
            label: context.l10n.label_password,
            hint: context.l10n.hint_enter_password,
            prefixIcon: Icons.lock_outline,
            obscureText: !formState.isPasswordVisible,
            textInputAction: TextInputAction.next,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return context.l10n.error_required_field;
              }
              if (val.length < 6) {
                return context.l10n.error_short_password;
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                formState.isPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: context.colorScheme.primary,
              ),
              onPressed: () => ref
                  .read(signUpFormNotifierProvider.notifier)
                  .togglePasswordVisibility(),
            ),
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _confirmPasswordController,
            label: context.l10n.label_confirm_password_simple,
            hint: context.l10n.hint_confirm_password_simple,
            prefixIcon: Icons.lock_outline,
            obscureText: !formState.isConfirmPasswordVisible,
            textInputAction: TextInputAction.done,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return context.l10n.error_required_field;
              }
              if (val != _passwordController.text) {
                return context.l10n.error_passwords_dont_match;
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                formState.isConfirmPasswordVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: context.colorScheme.primary,
              ),
              onPressed: () => ref
                  .read(signUpFormNotifierProvider.notifier)
                  .toggleConfirmPasswordVisibility(),
            ),
          ),
          const SizedBox(height: 24),
          AppButton(
            text: context.l10n.action_sign_up,
            onPressed: authState.isLoading ? null : _signUp,
            isLoading: authState.isLoading,
          ),
        ],
      ),
    );
  }
}
