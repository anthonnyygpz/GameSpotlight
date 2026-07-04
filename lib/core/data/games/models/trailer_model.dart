import 'package:game_tv/core/domain/games/entities/trailer_entity.dart';

class TrailerModel extends TrailerEntity {
  const TrailerModel({
    required super.trailerId,
    required super.title,
    required super.type,
    required super.videoUrl,
    required super.posterUrl,
    required super.sortOrder,
    required super.categories,
  });

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      trailerId: json['trailerId'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      videoUrl: json['videoUrl'] as String,
      posterUrl: json['posterUrl'] as String?,
      sortOrder: json['sortOrder'] as int,
      categories: json['categories'] as String,
    );
  }
}
