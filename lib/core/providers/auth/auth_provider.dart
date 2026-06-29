import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:game_tv/core/data/auth/repository/auth_repository_impl.dart';
import 'package:game_tv/core/domain/auth/entity/auth_response_entity.dart';
import 'package:game_tv/core/domain/auth/entity/login_entity.dart';
import 'package:game_tv/core/domain/auth/entity/register_entity.dart';
import 'package:game_tv/core/domain/auth/repository/auth_repository.dart';
import 'package:game_tv/core/providers/auth/token_storage.dart';
import 'package:game_tv/core/providers/dio_client.dart';

// ─── Repository ───────────────────────────────────────────────────────────────

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepositoryImpl(dio);
});

// ─── Auth state ───────────────────────────────────────────────────────────────

final authResponseProvider = StateProvider<AuthResponseEntity?>((ref) => null);

// ─── Register ─────────────────────────────────────────────────────────────────

final registerProvider = AsyncNotifierProvider<RegisterNotifier, void>(
  RegisterNotifier.new,
);

final loginProvider = AsyncNotifierProvider<LoginNotifier, void>(
  LoginNotifier.new,
);

final logoutProvider = Provider((ref) {
  return () async {
    await ref.read(tokenStorageProvider).delete();
    ref.read(tokenProvider.notifier).state = null;
    ref.read(authResponseProvider.notifier).state = null;
  };
});

class RegisterNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> call(RegisterEntity entity) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(authRepositoryProvider).register(entity);

      await ref.read(tokenStorageProvider).save(response.token);

      ref.read(tokenProvider.notifier).state = response.token;
      ref.read(authResponseProvider.notifier).state = response;
    });
  }
}

class LoginNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> call(LoginEntity entity) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(authRepositoryProvider).login(entity);

      await ref.read(tokenStorageProvider).save(response.token);

      ref.read(tokenProvider.notifier).state = response.token;
      ref.read(authResponseProvider.notifier).state = response;
    });
  }
}
