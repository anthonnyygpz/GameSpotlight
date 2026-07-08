import 'package:gamespotlight/core/data/platforms/datasources/platforms_remote_datasource.dart';
import 'package:gamespotlight/core/domain/platforms/repositories/platforms_repository.dart';

class PlatformsRepositoryImpl implements PlatformsRepository {
  final PlatformsRemoteDataSource remoteDataSource;

  PlatformsRepositoryImpl(this.remoteDataSource);
}
