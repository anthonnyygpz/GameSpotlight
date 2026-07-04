import 'package:game_tv/core/domain/games/entities/game_entity.dart';

class GameModel extends GameEntity {
  const GameModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.gradientStart,
    required super.gradiendEnd,
    required super.badge,
    required super.date,
    required super.category,
    required super.coverImageUrl,
    required super.bannerUrl,
    required super.genres,
    required super.platforms,
    required super.totalTrailers,
    required super.featured,
    required super.status,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Sin título',
      subtitle: json['subtitle'] as String? ?? '',
      gradientStart: json['gradientStart'] as String? ?? '',
      gradiendEnd: json['gradientEnd'] as String? ?? '',
      badge: json['badge'] as String?,
      date: json['date'] != null
          ? DateTime.tryParse(json['date'] as String)
          : null,
      category: json['category'] as String? ?? '',
      coverImageUrl: json['coverImageUrl'] as String? ?? '',
      bannerUrl: json['bannerUrl'] as String? ?? '',
      genres: json['genres'] as String? ?? '',
      platforms: json['platforms'] as String? ?? '',
      totalTrailers: json['totalTrailers']?.toString() ?? '0',
      featured: json['featured']?.toString() ?? 'false',
      status: json['status'] as String? ?? '',
    );
  }
}
