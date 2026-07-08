import 'package:gamespotlight/core/domain/genres/entities/game_genres_entity.dart';
import 'package:gamespotlight/core/domain/genres/entities/genres_entity.dart';

abstract class GenresRepository {
  Future<List<GenreEntity>> getGenres();
  Future<List<GameGenreEntity>> getGameGenres(String genreId);
}
