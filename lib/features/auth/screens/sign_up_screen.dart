import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/error/error_handler.dart';
import 'package:travel_planner/core/router/app_route_names.dart';
import 'package:travel_planner/features/auth/services/auth_service.dart';
import 'package:travel_planner/shared/widgets/app_button.dart';
import 'package:travel_planner/shared/widgets/text_field.dart';
import 'package:travel_planner/shared/widgets/auth_layout.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    setState(() => _isLoading = true);
    try {
      await AuthService().signUp(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
      );
      if (mounted) {
        ErrorHandler.showSuccessToast(context, AppLocalizations.of(context).toast_accountCreated);
        context.goNamed(AppRouteNames.home);
      }
    } catch (e) {
      if (mounted) {
        ErrorHandler.showErrorToast(context, AppLocalizations.of(context).toast_signUpFailed);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AuthLayout(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            
            
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context).createAccount,
                      style: context.headlineMedium.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context).fillInDetails,
                      style: context.bodyLarge.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha:0.7),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    AppTextField(
                      controller: _nameController,
                      label: AppLocalizations.of(context).fullName,
                      hint: AppLocalizations.of(context).enterFullName,
                      prefixIcon: Icons.person_outline,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).errors_requiredField;
                        }
                        if (value.length < 2) {
                          return AppLocalizations.of(context).errors_requiredField;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    AppTextField(
                      controller: _emailController,
                      label: AppLocalizations.of(context).auth_email,
                      hint: AppLocalizations.of(context).enterEmail,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).errors_requiredField;
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return AppLocalizations.of(context).errors_invalidEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    AppTextField(
                      controller: _passwordController,
                      label: AppLocalizations.of(context).auth_password,
                      hint: AppLocalizations.of(context).enterPassword,
                      prefixIcon: Icons.lock_outline,
                      obscureText: !_isPasswordVisible,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).errors_requiredField;
                        }
                        if (value.length < 6) {
                          return AppLocalizations.of(context).errors_shortPassword;
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    AppTextField(
                      controller: _confirmPasswordController,
                      label: AppLocalizations.of(context).auth_confirmPassword,
                      hint: AppLocalizations.of(context).enterConfirmPassword,
                      prefixIcon: Icons.lock_outline,
                      obscureText: !_isConfirmPasswordVisible,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).errors_requiredField;
                        }
                        if (value != _passwordController.text) {
                          return AppLocalizations.of(context).errors_passwordsDontMatch;
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    AppButton(
                      text: AppLocalizations.of(context).createAccountButton,
                      onPressed: _signUp,
                      isLoading: _isLoading,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: theme.colorScheme.outline.withValues(alpha:0.2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            AppLocalizations.of(context).or,
                            style: context.labelMedium.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha:0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: theme.colorScheme.outline.withValues(alpha:0.2),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          context.goNamed(AppRouteNames.signIn);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: theme.colorScheme.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          AppLocalizations.of(context).alreadyHaveAccount,
                          style: context.buttonText.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
