import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/data/auth/repository/auth_repository_impl.dart';
import 'package:gamespotlight/core/domain/auth/entity/user_entity.dart';
import 'package:gamespotlight/core/domain/auth/repository/auth_repository.dart';
import 'package:gamespotlight/core/domain/auth/usecases/auth/login_usecase.dart';
import 'package:gamespotlight/core/domain/auth/usecases/auth/register_usecase.dart';
import 'package:gamespotlight/core/domain/auth/usecases/auth/update_user_usecase.dart';
import 'package:gamespotlight/core/providers/auth/token_storage.dart';
import 'package:gamespotlight/core/providers/dio_client.dart';

// ─── Repository ───────────────────────────────────────────────────────────────

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepositoryImpl(dio);
});

// Me
final meProvider = FutureProvider<UserEntity>((ref) async {
  final repository = ref.watch(authRepositoryProvider);
  final response = await repository.me();
  return response;
});

// ─── Register ─────────────────────────────────────────────────────────────────

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUseCase(repository);
});

final registerProvider = AsyncNotifierProvider<RegisterNotifier, void>(
  RegisterNotifier.new,
);

// ─── Login ─────────────────────────────────────────────────────────────────
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

final loginProvider = AsyncNotifierProvider<LoginNotifier, void>(
  LoginNotifier.new,
);

// ─── Update ─────────────────────────────────────────────────────────────────
final updateUserUseCaseProvider = Provider<UpdateUserUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return UpdateUserUseCase(repository);
});

final updateProvider = AsyncNotifierProvider<UpdateUserNotifier, void>(
  UpdateUserNotifier.new,
);

final updateUserProvider = AsyncNotifierProvider<UpdateUserNotifier, void>(
  UpdateUserNotifier.new,
);

// ─── Logout ─────────────────────────────────────────────────────────────────
final logoutProvider = Provider((ref) {
  return () async {
    await ref.read(tokenStorageProvider).delete();
    ref.read(tokenProvider.notifier).state = null;
  };
});

class RegisterNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> call(RegisterParams params) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(registerUseCaseProvider)(params);

      await ref.read(tokenStorageProvider).save(response.accessToken);
      ref.read(tokenProvider.notifier).state = response.accessToken;
    });
  }
}

class LoginNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> call(LoginParams params) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(loginUseCaseProvider)(params);

      await ref.read(tokenStorageProvider).save(response.accessToken);
      ref.read(tokenProvider.notifier).state = response.accessToken;
    });
  }
}

class UpdateUserNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> call(UpdateUserParams params) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(updateUserUseCaseProvider)(params);
      ref.invalidate(meProvider);
    });
  }
}
