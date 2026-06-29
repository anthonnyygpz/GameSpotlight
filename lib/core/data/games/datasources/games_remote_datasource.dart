import 'package:dio/dio.dart';
import 'package:game_tv/core/constants/games_test.dart';

class GamesRemoteDataSource {
  final Dio client;

  GamesRemoteDataSource(this.client);

  Future<List<dynamic>> fetchGames() async {
    // final response = await client.get('/games');
    return mockGames
        .map(
          (game) => {
            'id_juego': game.idJuego,
            'titulo': game.titulo,
            'slug': game.slug,
            'sinopsis': game.sinopsis,
            'fecha_lanzamiento': game.fechaLanzamiento,
            'desarrollador': game.desarrollador,
            'editor': game.editor,
            'imagen_portada': game.imagenPortada,
            'banner_url': game.bannerUrl,
            'estado': game.estado,
            'destacado': game.destacado,
            'created_at': game.createdAt,
            'updated_at': game.updatedAt,
          },
        )
        .toList();
  }

  Future<dynamic> fetchGameById(String id) async {
    final game = mockGames.firstWhere((e) => e.idJuego == id);
    return {
      'id_juego': game.idJuego,
      'titulo': game.titulo,
      'slug': game.slug,
      'sinopsis': game.sinopsis,
      'fecha_lanzamiento': game.fechaLanzamiento,
      'desarrollador': game.desarrollador,
      'editor': game.editor,
      'imagen_portada': game.imagenPortada,
      'banner_url': game.bannerUrl,
      'estado': game.estado,
      'destacado': game.destacado,
      'created_at': game.createdAt,
      'updated_at': game.updatedAt,
    };
  }
}
