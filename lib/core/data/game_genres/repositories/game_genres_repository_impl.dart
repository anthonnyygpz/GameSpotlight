import 'package:gamespotlight/core/data/game_genres/datasources/game_genres_remote_datasource.dart';
import 'package:gamespotlight/core/domain/game_genres/repositories/game_genres_repository.dart';

class GameGenresRepositoryImpl implements GameGenresRepository {
  final GameGenresRemoteDataSource remoteDataSource;

  GameGenresRepositoryImpl(this.remoteDataSource);
}
