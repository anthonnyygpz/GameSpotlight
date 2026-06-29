import 'package:game_tv/core/data/platforms/datasources/platforms_remote_datasource.dart';
import 'package:game_tv/core/domain/platforms/repositories/platforms_repository.dart';

class PlatformsRepositoryImpl implements PlatformsRepository {
  final PlatformsRemoteDataSource remoteDataSource;

  PlatformsRepositoryImpl(this.remoteDataSource);
}
