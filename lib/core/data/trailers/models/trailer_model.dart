import 'package:game_tv/core/domain/trailers/entities/trailer_entity.dart';

class TrailerModel extends TrailerEntity {
  const TrailerModel({
    required super.idTrailer,
    required super.idJuego,
    required super.titulo,
    required super.urlVideo,
    required super.urlPoster,
    required super.duracion,
    required super.orden,
    required super.createdAt,
  });

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      idTrailer: json['id_trailer'] as String? ?? '',
      idJuego: json['id_juego'] as String? ?? '',
      titulo: json['titulo'] as String? ?? '',
      urlVideo: json['url_video'] as String? ?? '',
      urlPoster: json['url_poster'] as String? ?? '',
      duracion: json['duracion'] as String? ?? '',
      orden: json['orden'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_trailer': idTrailer,
      'id_juego': idJuego,
      'titulo': titulo,
      'url_video': urlVideo,
      'url_poster': urlPoster,
      'duracion': duracion,
      'orden': orden,
      'created_at': createdAt,
    };
  }
}
