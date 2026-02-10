import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_form_provider.g.dart';

class SignInFormState {
  final bool isLoading;
  final bool isPasswordVisible;
  final String? error;

  const SignInFormState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.error,
  });

  SignInFormState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    String? error,
    bool clearError = false,
  }) {
    return SignInFormState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

@riverpod
class SignInFormNotifier extends _$SignInFormNotifier {
  @override
  SignInFormState build() {
    return const SignInFormState();
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}
