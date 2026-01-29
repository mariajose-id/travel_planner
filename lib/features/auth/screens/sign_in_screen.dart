import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_planner/core/error/error_handler.dart';
import 'package:travel_planner/core/router/app_route_names.dart';
import 'package:travel_planner/features/auth/services/auth_service.dart';
import 'package:travel_planner/shared/widgets/app_button.dart';
import 'package:travel_planner/shared/widgets/text_field.dart';
import 'package:travel_planner/shared/widgets/auth_layout.dart';
import 'package:travel_planner/shared/widgets/theme_switch.dart';
import 'package:travel_planner/shared/widgets/language_switch.dart';
import 'package:travel_planner/generated/l10n/app_localizations.dart';
import 'package:travel_planner/core/theme/app_typography.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}
class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    setState(() => _isLoading = true);
    try {
      await AuthService().signIn(_emailController.text, _passwordController.text);
      if (mounted) {
        ErrorHandler.showSuccessToast(context, AppLocalizations.of(context).toast_welcomeBack);
        context.goNamed(AppRouteNames.home);
      }
    } catch (e) {
      if (mounted) {
        ErrorHandler.showErrorToast(context, AppLocalizations.of(context).toast_invalidCredentials);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Stack(
      children: [
        // Gradient background at absolute bottom (shorter)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  theme.colorScheme.primary.withValues(alpha: 0.8),
                  theme.colorScheme.primary.withValues(alpha: 0.4),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Main content
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          body: SafeArea(
            child: Column(
              children: [
                // Language and theme switches
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const ThemeSwitch(),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const LanguageSwitch(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
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
                            AppLocalizations.of(context).welcomeBack,
                            style: context.headlineMedium.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppLocalizations.of(context).signInSubtitle,
                            style: context.bodyLarge.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha:0.7),
                            ),
                          ),
                          const SizedBox(height: 32),
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
                            textInputAction: TextInputAction.done,
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
                          const SizedBox(height: 32),
                          AppButton(
                            text: AppLocalizations.of(context).signInButton,
                            onPressed: _signIn,
                            isLoading: _isLoading,
                          ),
                          const SizedBox(height: 24),
                          // Google Sign In Button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                // Google sign-in logic would go here
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: theme.colorScheme.surface,
                              ),
                              child: Text(
                                AppLocalizations.of(context).signInWithGoogle,
                                style: context.buttonText.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    context.goNamed(AppRouteNames.signUp);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: theme.colorScheme.primary),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context).createAccount,
                                    style: context.buttonText.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
                ),
                // Splash image at bottom of SafeArea
                Container(
                  height: 120,
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/splash.png',
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
