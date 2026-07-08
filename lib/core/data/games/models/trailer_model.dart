import 'package:gamespotlight/core/domain/games/entities/trailer_entity.dart';

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
      trailerId: json['id_trailer'] as String? ?? '',
      title: json['titulo'] as String? ?? '',
      type: json['tipo'] as String? ?? '',
      videoUrl: json['url_video'] as String? ?? '',
      posterUrl: json['url_poster'] as String? ?? '',
      sortOrder: json['orden'] as String? ?? '',
      categories: json['category_ids'] as List<dynamic>? ?? [],
    );
  }
}
