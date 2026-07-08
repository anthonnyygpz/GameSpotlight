import 'package:dio/dio.dart';
import 'package:gamespotlight/core/data/platforms/models/game_platform_model.dart';
import 'package:gamespotlight/core/data/platforms/models/platforms_model.dart';
import 'package:gamespotlight/core/domain/platforms/entities/game_platform_entity.dart';
import 'package:gamespotlight/core/domain/platforms/entities/platforms_entity.dart';
import 'package:gamespotlight/core/domain/platforms/repositories/platforms_repository.dart';
import 'package:gamespotlight/core/errors/exceptions.dart';
import 'package:gamespotlight/core/models/api_response.dart';

class PlatformsRepositoryImpl implements PlatformsRepository {
  PlatformsRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<PlatformEntity>> getPlatforms() async {
    try {
      final respose = await _dio.get('/platforms');

      final apiResponse = ApiResponse<List<PlatformsModel>>.fromJson(
        respose.data as Map<String, dynamic>,
        (data) => (data as List)
            .map((e) => PlatformsModel.fromJson(e as Map<String, dynamic>))
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
  Future<List<GamePlatformEntity>> getGamePlatforms(String platformId) async {
    try {
      final respose = await _dio.get('/platforms/$platformId');
      final apiResponse = ApiResponse<List<GamePlatformModel>>.fromJson(
        respose.data as Map<String, dynamic>,
        (data) => (data as List)
            .map((e) => GamePlatformModel.fromJson(e as Map<String, dynamic>))
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
