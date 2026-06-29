class TrailerEntity {
  final String idTrailer;
  final String idJuego;
  final String titulo;
  final String urlVideo;
  final String urlPoster;
  final String duracion;
  final String orden;
  final String createdAt;

  const TrailerEntity({
    required this.idTrailer,
    required this.idJuego,
    required this.titulo,
    required this.urlVideo,
    required this.urlPoster,
    required this.duracion,
    required this.orden,
    required this.createdAt,
  });
}
