import 'package:dio/dio.dart';
import 'package:game_tv/core/data/games/models/game_details_entity.dart';
import 'package:game_tv/core/data/games/models/game_response_model.dart';
import 'package:game_tv/core/domain/games/entities/game_detail_entity.dart';
import 'package:game_tv/core/domain/games/entities/game_response_entity.dart';
import 'package:game_tv/core/domain/games/repositories/games_repository.dart';

class GamesRepositoryImpl implements GamesRepository {
  final Dio _dio;

  GamesRepositoryImpl(this._dio);

  @override
  Future<GameResponseEntity> getGames() async {
    final response = await _dio.get('games/home');
    return GameResponseModel.fromJson(response.data);
  }

  @override
  Future<GameDetailEntity> getGameById(String id) async {
    final response = await _dio.get('games/$id');
    return GameDetailModel.fromJson(response.data);
  }
}
