import 'package:game_tv/core/domain/games/entities/trailer_entity.dart';

class GameDetailEntity {
  const GameDetailEntity({
    required this.gameId,
    required this.title,
    required this.slug,
    required this.description,
    required this.releaseDate,
    required this.developer,
    required this.publisher,
    required this.coverImage,
    required this.bannerUrl,
    required this.status,
    required this.featured,
    required this.genres,
    required this.platforms,
    required this.trailers,
  });

  final String gameId;
  final String title;
  final String slug;
  final String? description;
  final DateTime? releaseDate;
  final String? developer;
  final String? publisher;
  final String coverImage;
  final String bannerUrl;
  final String status;
  final bool featured;
  final String genres;
  final String platforms;
  final List<TrailerEntity> trailers;
}
