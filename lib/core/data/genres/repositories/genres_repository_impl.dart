import 'package:dio/dio.dart';
import 'package:gamespotlight/core/data/genres/models/game_genres_model.dart';
import 'package:gamespotlight/core/data/genres/models/genres_model.dart';
import 'package:gamespotlight/core/domain/genres/entities/game_genres_entity.dart';
import 'package:gamespotlight/core/domain/genres/entities/genres_entity.dart';
import 'package:gamespotlight/core/domain/genres/repositories/genres_repository.dart';
import 'package:gamespotlight/core/errors/exceptions.dart';
import 'package:gamespotlight/core/models/api_response.dart';

class GenresRepositoryImpl implements GenresRepository {
  GenresRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<GenreEntity>> getGenres() async {
    try {
      final respose = await _dio.get('/genres');

      final apiResponse = ApiResponse<List<GenresModel>>.fromJson(
        respose.data as Map<String, dynamic>,
        (data) => (data as List)
            .map((e) => GenresModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw ServerException(
          apiResponse.message ?? 'Error en la autenticación',
        );
      }
    } on DioException catch (_) {
      rethrow;
    } on FormatException {
      throw ServerException('Respuesta inesperada del servidor');
    }
  }

  @override
  Future<List<GameGenreEntity>> getGameGenres(String genreId) async {
    try {
      final respose = await _dio.get('/genres/$genreId');
      final apiResponse = ApiResponse<List<GameGenresModel>>.fromJson(
        respose.data as Map<String, dynamic>,
        (data) => (data as List)
            .map((e) => GameGenresModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw ServerException(
          apiResponse.message ?? 'Error en la autenticación',
        );
      }
    } on DioException catch (_) {
      rethrow;
    } on FormatException {
      throw ServerException('Respuesta inesperada del servidor');
    }
  }
}
