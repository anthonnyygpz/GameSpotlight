import 'package:game_tv/core/domain/games/entities/game_entity.dart';

class GameModel extends GameEntity {
  const GameModel({
    required super.idJuego,
    required super.titulo,
    required super.slug,
    required super.sinopsis,
    required super.fechaLanzamiento,
    required super.desarrollador,
    required super.editor,
    required super.imagenPortada,
    required super.bannerUrl,
    required super.estado,
    required super.destacado,
    required super.createdAt,
    required super.updatedAt,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      idJuego: json['id_juego'] as String? ?? '',
      titulo: json['titulo'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      sinopsis: json['sinopsis'] as String? ?? '',
      fechaLanzamiento: json['fecha_lanzamiento'] as String? ?? '',
      desarrollador: json['desarrollador'] as String? ?? '',
      editor: json['editor'] as String? ?? '',
      imagenPortada: json['imagen_portada'] as String? ?? '',
      bannerUrl: json['banner_url'] as String? ?? '',
      estado: json['estado'] as String? ?? '',
      destacado: json['destacado'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_juego': idJuego,
      'titulo': titulo,
      'slug': slug,
      'sinopsis': sinopsis,
      'fecha_lanzamiento': fechaLanzamiento,
      'desarrollador': desarrollador,
      'editor': editor,
      'imagen_portada': imagenPortada,
      'banner_url': bannerUrl,
      'estado': estado,
      'destacado': destacado,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
