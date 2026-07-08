import 'package:gamespotlight/core/domain/genres/entities/genres_entity.dart';

class GenresModel extends GenreEntity {
  const GenresModel({
    required super.id,
    required super.name,
    required super.description,
    required super.iconUrl,
  });

  factory GenresModel.fromJson(Map<String, dynamic> json) {
    return GenresModel(
      id: json['genre_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      iconUrl: json['icon_url'] as String? ?? '',
    );
  }
}
