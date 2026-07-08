import 'package:gamespotlight/core/domain/genres/entities/game_genres_entity.dart';

class GameGenresModel extends GameGenreEntity {
  const GameGenresModel({
    required super.genre,
    required super.gameId,
    required super.title,
    required super.description,
    required super.coverImage,
    required super.status,
  });

  factory GameGenresModel.fromJson(Map<String, dynamic> json) {
    return GameGenresModel(
      genre: json['genre'] as String? ?? 'Desconocido',
      gameId: json['game_id'] as String? ?? '',
      title: json['title'] as String? ?? 'Sin título',
      description: json['description'] as String? ?? 'Sin descripción',
      coverImage: json['cover_image'] as String? ?? '',
      status: json['status'] as String? ?? 'Sin estado',
    );
  }
}
