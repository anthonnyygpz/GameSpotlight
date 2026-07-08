import 'package:gamespotlight/core/data/games/models/trailer_model.dart';
import 'package:gamespotlight/core/domain/games/entities/game_detail_entity.dart';

class GameDetailModel extends GameDetailEntity {
  const GameDetailModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.synopsis,
    required super.releaseDate,
    required super.developer,
    required super.editor,
    required super.coverImageUrl,
    required super.bannerUrl,
    required super.status,
    required super.featured,
    required super.genres,
    required super.platforms,
    required super.trailers,
  });

  factory GameDetailModel.fromJson(Map<String, dynamic> json) {
    return GameDetailModel(
      id: json['id_juego'] as String? ?? '',
      title: json['titulo'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      synopsis: json['sinopsis'] as String? ?? '',
      releaseDate: json['fecha_lanzamiento'] != null
          ? DateTime.tryParse(json['fecha_lanzamiento'] as String)
          : null,
      developer: json['desarrollador'] as String? ?? '',
      editor: json['editor'] as String? ?? '',
      coverImageUrl: json['imagen_portada'] as String? ?? '',
      bannerUrl: json['banner_url'] as String? ?? '',
      status: json['estado'] as String? ?? '',
      featured: json['destacado'] as String? ?? '',
      genres: json['generos'] as String? ?? '',
      platforms: json['plataformas'] as String? ?? '',
      trailers: (json['trailers'] as List<dynamic>? ?? [])
          .map((e) => TrailerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
