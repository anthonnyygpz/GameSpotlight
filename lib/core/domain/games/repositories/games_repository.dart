import 'package:game_tv/core/domain/games/entities/game_entity.dart';

abstract class GamesRepository {
  Future<List<GameEntity>> getGames();
  Future<GameEntity> getGameById(String id);
}
