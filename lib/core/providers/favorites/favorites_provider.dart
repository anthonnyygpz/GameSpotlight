import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/data/favorites/repostories/favorites_repository_impl.dart';
import 'package:gamespotlight/core/domain/favorites/entities/favorite_entity.dart';
import 'package:gamespotlight/core/domain/favorites/repositories/favorites_repository.dart';
import 'package:gamespotlight/core/domain/favorites/usecases/toggle_favorite_usecase.dart';
import 'package:gamespotlight/core/providers/dio_client.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return FavoritesRepositoryImpl(dio);
});

final toggleFavoriteUseCaseProvider = Provider<ToggleFavoriteUseCase>((ref) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return ToggleFavoriteUseCase(repository);
});

final favoritesProvider = FutureProvider<List<FavoriteEntity>?>((ref) async {
  final repository = ref.watch(favoritesRepositoryProvider);
  final response = await repository.getFavorites();
  return response.data;
});

final toggleFavoriteProvider =
    AsyncNotifierProvider<ToggleFavoriteNotifier, void>(
      ToggleFavoriteNotifier.new,
    );

final isFavoriteProvider = FutureProvider.family<bool, String>((
  ref,
  gameId,
) async {
  final repository = ref.watch(favoritesRepositoryProvider);
  return await repository.isFavorite(gameId);
});

class ToggleFavoriteNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> call(String gameId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(toggleFavoriteUseCaseProvider)(gameId);
      ref.invalidate(favoritesProvider);
      ref.invalidate(isFavoriteProvider(gameId));
    });
  }
}
