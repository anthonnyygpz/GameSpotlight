import 'package:game_tv/core/domain/games/entities/game_entity.dart';

class GameResponseEntity {
  const GameResponseEntity({required this.success, required this.data});

  final bool success;
  final DataGame? data;
}

class DataGame {
  const DataGame({
    required this.hero,
    required this.trailers,
    required this.upcoming,
    required this.topRated,
    required this.newReleases,
  });

  final List<GameEntity> hero;
  final List<GameEntity> trailers;
  final List<GameEntity> upcoming;
  final List<GameEntity> topRated;
  final List<GameEntity> newReleases;
}
