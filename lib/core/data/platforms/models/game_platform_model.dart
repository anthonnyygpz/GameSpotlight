import 'package:gamespotlight/core/domain/platforms/entities/game_platform_entity.dart';

class GamePlatformModel extends GamePlatformEntity {
  const GamePlatformModel({
    required super.gameId,
    required super.platform,
    required super.title,
    required super.description,
    required super.coverImage,
    super.status,
  });

  factory GamePlatformModel.fromJson(Map<String, dynamic> json) {
    return GamePlatformModel(
      gameId: json['game_id'],
      platform: json['platform'],
      title: json['title'],
      description: json['description'],
      coverImage: json['cover_image'],
      status: json['status'],
    );
  }
}
