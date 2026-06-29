import 'package:game_tv/core/domain/game_genres/entities/game_genres_entity.dart';

class GameGenresModel extends GameGenresEntity {
  const GameGenresModel() : super();

  factory GameGenresModel.fromJson(Map<String, dynamic> json) {
    return GameGenresModel();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
