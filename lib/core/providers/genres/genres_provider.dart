import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/data/genres/repositories/genres_repository_impl.dart';
import 'package:gamespotlight/core/domain/genres/entities/game_genres_entity.dart';
import 'package:gamespotlight/core/domain/genres/entities/genres_entity.dart';
import 'package:gamespotlight/core/domain/genres/repositories/genres_repository.dart';
import 'package:gamespotlight/core/providers/dio_client.dart';

final genresRepositoryProvider = Provider<GenresRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return GenresRepositoryImpl(dio);
});

final genresProvider = FutureProvider<List<GenreEntity>?>((ref) async {
  final repository = ref.watch(genresRepositoryProvider);
  final response = await repository.getGenres();
  return response;
});

final gameGenresProvider =
    FutureProvider.family<List<GameGenreEntity>?, String>((ref, genreId) async {
      final repository = ref.watch(genresRepositoryProvider);
      final response = await repository.getGameGenres(genreId);
      return response;
    });
