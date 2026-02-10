import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_planner/core/di/service_locator.dart';
import 'package:travel_planner/core/result/result.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/usecases/authentication_usecase.dart';

final authUseCaseProvider = Provider<AuthenticationUseCase>((ref) {
  return serviceLocator<AuthenticationUseCase>();
});

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, User?>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<User?> {
  late AuthenticationUseCase _useCase;

  @override
  FutureOr<User?> build() async {
    // Keep this provider alive to persist auth state across hot reloads
    ref.keepAlive();

    _useCase = ref.watch(authUseCaseProvider);
    final result = await _useCase.getCurrentUser();

    if (result.isFailure) {
      // If we failed to get current user, we just return null (logged out)
      return null;
    }

    return result.value;
  }

  Future<Result<User>> login(String email, String password) async {
    state = const AsyncLoading();
    final result = await _useCase.login(email: email, password: password);

    if (result.isSuccess) {
      state = AsyncData(result.value);
    } else {
      state = AsyncError(result.error!, StackTrace.current);
    }
    return result;
  }

  Future<Result<User>> register(
    String name,
    String email,
    String password,
  ) async {
    state = const AsyncLoading();
    final result = await _useCase.register(
      name: name,
      email: email,
      password: password,
    );

    if (result.isSuccess) {
      state = AsyncData(result.value);
    } else {
      state = AsyncError(result.error!, StackTrace.current);
    }
    return result;
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    final result = await _useCase.logout();
    if (result.isSuccess) {
      state = const AsyncData(null);
    } else {
      state = AsyncError(result.error!, StackTrace.current);
    }
  }

  Future<void> deleteAccount() async {
    state = const AsyncLoading();
    final result = await _useCase.deleteAccount();
    if (result.isSuccess) {
      state = const AsyncData(null);
    } else {
      state = AsyncError(result.error!, StackTrace.current);
    }
  }

  Future<void> updateProfile({required String name}) async {
    final currentUser = state.value;
    if (currentUser == null) return;

    state = const AsyncLoading();
    final result = await _useCase.updateProfile(
      name: name,
      email: currentUser.email,
    );

    if (result.isSuccess) {
      state = AsyncData(result.value);
    } else {
      state = AsyncError(result.error!, StackTrace.current);
    }
  }

  Future<void> updateAvatar(String? avatarUrl) async {
    final currentUser = state.value;
    if (currentUser == null) return;

    state = const AsyncLoading();
    final result = await _useCase.updateAvatar(avatarUrl: avatarUrl);

    if (result.isSuccess) {
      state = AsyncData(result.value);
    } else {
      state = AsyncError(result.error!, StackTrace.current);
    }
  }
}
