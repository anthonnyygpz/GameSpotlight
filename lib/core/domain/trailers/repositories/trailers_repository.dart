import 'package:game_tv/core/domain/trailers/entities/trailer_entity.dart';

abstract class TrailersRepository {
  Future<List<TrailerEntity>> getTrailers();
  Future<TrailerEntity> getTrailerById(String id);
}
