import 'package:game_tv/core/domain/genres/entities/genres_entity.dart';

class GenresModel extends GenresEntity {
  const GenresModel() : super();

  factory GenresModel.fromJson(Map<String, dynamic> json) {
    return GenresModel();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
