import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/data/games/repositories/games_repository_impl.dart';
import 'package:gamespotlight/core/domain/games/entities/game_detail_entity.dart';
import 'package:gamespotlight/core/domain/games/entities/game_response_entity.dart';
import 'package:gamespotlight/core/domain/games/repositories/games_repository.dart';
import 'package:gamespotlight/core/providers/dio_client.dart';

final gamesRepositoryProvider = Provider<GamesRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return GamesRepositoryImpl(dio);
});

final gamesProvider = FutureProvider<DataGame?>((ref) async {
  final repository = ref.watch(gamesRepositoryProvider);
  final response = await repository.getGames();
  return response.data;
});

final gameDetailsProvider = FutureProvider.family<GameDetailEntity?, String>((
  ref,
  id,
) async {
  final repository = ref.watch(gamesRepositoryProvider);
  final response = await repository.getGameById(id);
  return response.data;
});
