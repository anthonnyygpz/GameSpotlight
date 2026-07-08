import 'package:gamespotlight/core/domain/games/entities/game_detail_response_entity.dart';
import 'package:gamespotlight/core/domain/games/entities/game_response_entity.dart';

abstract class GamesRepository {
  Future<GameResponseEntity> getGames();
  Future<GameDetailResponseEntity> getGameById(String id);
}
