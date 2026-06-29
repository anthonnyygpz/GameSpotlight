class GameEntity {
  final String idJuego;
  final String titulo;
  final String slug;
  final String? sinopsis;
  final String? fechaLanzamiento;
  final String? desarrollador;
  final String? editor;
  final String? imagenPortada;
  final String? bannerUrl;
  final String? estado;
  final String? destacado;
  final String? createdAt;
  final String? updatedAt;

  const GameEntity({
    required this.idJuego,
    required this.titulo,
    required this.slug,
    required this.sinopsis,
    required this.fechaLanzamiento,
    required this.desarrollador,
    required this.editor,
    required this.imagenPortada,
    required this.bannerUrl,
    required this.estado,
    required this.destacado,
    required this.createdAt,
    required this.updatedAt,
  });
}
