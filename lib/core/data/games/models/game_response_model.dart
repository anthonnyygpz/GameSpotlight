import 'package:gamespotlight/core/data/games/models/game_model.dart';
import 'package:gamespotlight/core/domain/games/entities/game_response_entity.dart';

class GameResponseModel extends GameResponseEntity {
  const GameResponseModel({required super.success, required super.data});

  factory GameResponseModel.fromJson(Map<String, dynamic> json) {
    return GameResponseModel(
      success: json['success'] as bool,
      data: DataGameModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class DataGameModel extends DataGame {
  const DataGameModel({
    required super.hero,
    required super.trailers,
    required super.upcoming,
    required super.topRated,
    required super.newReleases,
    required super.exclusives,
  });

  factory DataGameModel.fromJson(Map<String, dynamic> json) {
    return DataGameModel(
      hero:
          (json['hero'] as List<dynamic>?)
              ?.map((e) => GameModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      trailers:
          (json['trailers'] as List<dynamic>?)
              ?.map((e) => GameModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      upcoming:
          (json['upcoming'] as List<dynamic>?)
              ?.map((e) => GameModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      topRated:
          (json['top_rated'] as List<dynamic>?)
              ?.map((e) => GameModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      newReleases:
          (json['new_releases'] as List<dynamic>?)
              ?.map((e) => GameModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      exclusives:
          (json['exclusives'] as List<dynamic>?)
              ?.map((e) => GameModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
