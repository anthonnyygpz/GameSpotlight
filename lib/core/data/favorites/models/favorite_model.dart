import 'package:gamespotlight/core/domain/favorites/entities/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity {
  const FavoriteModel({
    required super.gameId,
    required super.title,
    required super.slug,
    required super.coverImage,
    required super.status,
    required super.addedAt,
    required super.generes,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      gameId: json['gameId'] as String,
      title: json['title'] as String,
      slug: json['slug'] as String,
      coverImage: json['coverImage'] as String,
      status: json['status'] as String,
      addedAt: json['addedAt'] as String,
      generes: json['genres'] as String,
    );
  }
}
