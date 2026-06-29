import 'package:dio/dio.dart';
import 'package:game_tv/core/constants/trailers_test.dart';

class TrailersRemoteDataSource {
  final Dio client;

  TrailersRemoteDataSource(this.client);

  Future<List<dynamic>> fetchTrailers() async {
    // final response = await client.get('/trailers');
    return mockTrailers
        .map(
          (trailer) => {
            'id_trailer': trailer.idTrailer,
            'id_juego': trailer.idJuego,
            'titulo': trailer.titulo,
            'url_video': trailer.urlVideo,
            'url_poster': trailer.urlPoster,
            'duracion': trailer.duracion,
            'orden': trailer.orden,
            'created_at': trailer.createdAt,
          },
        )
        .toList();
  }

  Future<dynamic> fetchTrailerById(String id) async {
    final trailer = mockTrailers.firstWhere((e) => e.idJuego == id);

    return {
      'id_trailer': trailer.idTrailer,
      'id_juego': trailer.idJuego,
      'titulo': trailer.titulo,
      'url_video': trailer.urlVideo,
      'url_poster': trailer.urlPoster,
      'duracion': trailer.duracion,
      'orden': trailer.orden,
      'created_at': trailer.createdAt,
    };
  }
}
