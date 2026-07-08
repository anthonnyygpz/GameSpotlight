import 'package:dio/dio.dart';
import 'package:gamespotlight/core/data/games/models/game_detail_response_model.dart';
import 'package:gamespotlight/core/data/games/models/game_response_model.dart';
import 'package:gamespotlight/core/domain/games/entities/game_detail_response_entity.dart';
import 'package:gamespotlight/core/domain/games/entities/game_response_entity.dart';
import 'package:gamespotlight/core/domain/games/repositories/games_repository.dart';

class GamesRepositoryImpl implements GamesRepository {
  final Dio _dio;

  GamesRepositoryImpl(this._dio);

  @override
  Future<GameResponseEntity> getGames() async {
    final response = await _dio.get('games/home');
    return GameResponseModel.fromJson(response.data);
  }

  @override
  Future<GameDetailResponseEntity> getGameById(String id) async {
    final response = await _dio.get('games/$id');
    return GameDetailResponseModel.fromJson(response.data);
  }
}
