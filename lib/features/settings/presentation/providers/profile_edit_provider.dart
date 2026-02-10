import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_edit_provider.g.dart';

class ProfileEditState {
  final bool isEditing;
  final bool isSaving;
  final String? nameError;
  final String? emailError;
  final String? successMessage;

  const ProfileEditState({
    this.isEditing = false,
    this.isSaving = false,
    this.nameError,
    this.emailError,
    this.successMessage,
  });

  ProfileEditState copyWith({
    bool? isEditing,
    bool? isSaving,
    String? nameError,
    String? emailError,
    String? successMessage,
    bool clearNameError = false,
    bool clearEmailError = false,
    bool clearSuccessMessage = false,
  }) {
    return ProfileEditState(
      isEditing: isEditing ?? this.isEditing,
      isSaving: isSaving ?? this.isSaving,
      nameError: clearNameError ? null : (nameError ?? this.nameError),
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
      successMessage: clearSuccessMessage
          ? null
          : (successMessage ?? this.successMessage),
    );
  }
}

@riverpod
class ProfileEditNotifier extends _$ProfileEditNotifier {
  @override
  ProfileEditState build() {
    return const ProfileEditState();
  }

  void startEditing() {
    state = state.copyWith(isEditing: true);
  }

  void cancelEditing() {
    state = state.copyWith(
      isEditing: false,
      clearNameError: true,
      clearEmailError: true,
      clearSuccessMessage: true,
    );
  }

  void setSaving(bool saving) {
    state = state.copyWith(isSaving: saving);
  }

  void setNameError(String? error) {
    state = state.copyWith(nameError: error);
  }

  void setEmailError(String? error) {
    state = state.copyWith(emailError: error);
  }

  void setSuccessMessage(String message) {
    state = state.copyWith(successMessage: message);
  }

  void clearErrors() {
    state = state.copyWith(clearNameError: true, clearEmailError: true);
  }

  void clearSuccessMessage() {
    state = state.copyWith(clearSuccessMessage: true);
  }
}
