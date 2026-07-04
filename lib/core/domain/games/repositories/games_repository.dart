import 'package:game_tv/core/domain/games/entities/game_detail_entity.dart';
import 'package:game_tv/core/domain/games/entities/game_response_entity.dart';

abstract class GamesRepository {
  Future<GameResponseEntity> getGames();
  Future<GameDetailEntity> getGameById(String id);
}
