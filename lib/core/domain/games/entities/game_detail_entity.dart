import 'package:gamespotlight/core/domain/games/entities/trailer_entity.dart';

class GameDetailEntity {
  const GameDetailEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.synopsis,
    required this.releaseDate,
    required this.developer,
    required this.editor,
    required this.coverImageUrl,
    required this.bannerUrl,
    required this.status,
    required this.featured,
    required this.genres,
    required this.platforms,
    required this.trailers,
  });

  final String id;
  final String title;
  final String slug;
  final String? synopsis;
  final DateTime? releaseDate;
  final String? developer;
  final String? editor;
  final String coverImageUrl;
  final String bannerUrl;
  final String status;
  final String featured;
  final String genres;
  final String platforms;
  final List<TrailerEntity> trailers;
}
