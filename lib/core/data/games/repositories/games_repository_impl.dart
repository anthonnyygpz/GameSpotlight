import 'package:game_tv/core/data/games/datasources/games_remote_datasource.dart';
import 'package:game_tv/core/data/games/models/game_model.dart';
import 'package:game_tv/core/domain/games/entities/game_entity.dart';
import 'package:game_tv/core/domain/games/repositories/games_repository.dart';

class GamesRepositoryImpl implements GamesRepository {
  final GamesRemoteDataSource remoteDataSource;

  GamesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<GameEntity>> getGames() async {
    try {
      final rawData = await remoteDataSource.fetchGames();
      return rawData.map((json) => GameModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Falla en la interceptación de datos: $e');
    }
  }

  @override
  Future<GameEntity> getGameById(String id) async {
    try {
      final rawData = await remoteDataSource.fetchGameById(id);
      return GameModel.fromJson(rawData);
    } catch (e) {
      throw Exception('No se pudo localizar el archivo del juego: $e');
    }
  }
}
