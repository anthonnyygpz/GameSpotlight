import 'package:gamespotlight/core/domain/games/entities/game_entity.dart';

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
    required this.exclusives,
  });

  final List<GameEntity> hero;
  final List<GameEntity> trailers;
  final List<GameEntity> upcoming;
  final List<GameEntity> topRated;
  final List<GameEntity> newReleases;
  final List<GameEntity> exclusives;
}
