import 'package:game_tv/core/data/trailers/datasources/trailers_remote_datasource.dart';
import 'package:game_tv/core/data/trailers/models/trailer_model.dart';
import 'package:game_tv/core/domain/trailers/entities/trailer_entity.dart';
import 'package:game_tv/core/domain/trailers/repositories/trailers_repository.dart';

class TrailerRepositoryImpl implements TrailersRepository {
  final TrailersRemoteDataSource remoteDataSource;

  TrailerRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TrailerEntity>> getTrailers() async {
    try {
      final rawData = await remoteDataSource.fetchTrailers();
      return rawData.map((json) => TrailerModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Falla en la interceptación de datos: $e');
    }
  }

  @override
  Future<TrailerEntity> getTrailerById(String id) async {
    try {
      final rawData = await remoteDataSource.fetchTrailerById(id);
      return TrailerModel.fromJson(rawData);
    } catch (e) {
      throw Exception('No se pudo localizar el archivo del juego: $e');
    }
  }
}
