// lib/core/data/games/models/game_detail_model.dart
import 'package:game_tv/core/data/games/models/trailer_model.dart';
import 'package:game_tv/core/domain/games/entities/game_detail_entity.dart';

class GameDetailModel extends GameDetailEntity {
  const GameDetailModel({
    required super.gameId,
    required super.title,
    required super.slug,
    required super.description,
    required super.releaseDate,
    required super.developer,
    required super.publisher,
    required super.coverImage,
    required super.bannerUrl,
    required super.status,
    required super.featured,
    required super.genres,
    required super.platforms,
    required super.trailers,
  });

  factory GameDetailModel.fromJson(Map<String, dynamic> json) {
    return GameDetailModel(
      gameId: json['gameId'] as String,
      title: json['title'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      releaseDate: json['releaseDate'] != null
          ? DateTime.tryParse(json['releaseDate'] as String)
          : null,
      developer: json['developer'] as String?,
      publisher: json['publisher'] as String?,
      coverImage: json['coverImage'] as String,
      bannerUrl: json['bannerUrl'] as String,
      status: json['status'] as String,
      featured: json['featured'] as bool,
      genres: json['genres'] as String,
      platforms: json['platforms'] as String,
      trailers: (json['trailers'] as List<dynamic>)
          .map((e) => TrailerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
