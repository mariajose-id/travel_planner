import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/extensions/context_extensions.dart';
import 'package:travel_planner/core/router/app_routes.dart';
import 'package:travel_planner/core/result/result_handler.dart';
import 'package:travel_planner/features/auth/presentation/providers/auth_notifier.dart';
import 'package:travel_planner/features/auth/presentation/providers/sign_in_form_provider.dart';
import 'package:travel_planner/shared/widgets/app_button.dart';
import 'package:travel_planner/shared/widgets/forms/app_text_field.dart';
import 'package:travel_planner/features/auth/presentation/widgets/auth_header.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() != true) return;

    final successMessage = context.l10n.toast_welcome_back;

    final result = await ref
        .read(authNotifierProvider.notifier)
        .login(_emailController.text, _passwordController.text);

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
    final formState = ref.watch(signInFormNotifierProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthHeader(
            title: context.l10n.heading_welcome_back,
            subtitle: context.l10n.heading_sign_in_subtitle,
          ),
          const SizedBox(height: 24),
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
            textInputAction: TextInputAction.done,
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
                  .read(signInFormNotifierProvider.notifier)
                  .togglePasswordVisibility(),
            ),
          ),
          const SizedBox(height: 24),
          AppButton(
            text: context.l10n.action_sign_in,
            onPressed: authState.isLoading ? null : _signIn,
            isLoading: authState.isLoading,
          ),
          const SizedBox(height: 16),
          _buildDivider(context),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: context.colorScheme.outline.withValues(alpha: 0.2),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.g_mobiledata, size: 24),
                const SizedBox(width: 8),
                Text(
                  context.l10n.action_sign_in_google,
                  style: context.textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: context.colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            context.l10n.label_or,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: context.colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ],
    );
  }
}
