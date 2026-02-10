import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripFormState {
  final bool isLoading;
  final String? error;
  final String? successMessage;

  const TripFormState({
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  TripFormState copyWith({
    bool? isLoading,
    String? error,
    String? successMessage,
    bool clearError = false,
    bool clearSuccessMessage = false,
  }) {
    return TripFormState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      successMessage: clearSuccessMessage ? null : (successMessage ?? this.successMessage),
    );
  }
}

class TripFormNotifier extends StateNotifier<TripFormState> {
  TripFormNotifier() : super(const TripFormState());

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void setSuccessMessage(String message) {
    state = state.copyWith(successMessage: message);
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  void clearSuccessMessage() {
    state = state.copyWith(clearSuccessMessage: true);
  }
}

final tripFormNotifierProvider = StateNotifierProvider<TripFormNotifier, TripFormState>(
  (ref) => TripFormNotifier(),
);
