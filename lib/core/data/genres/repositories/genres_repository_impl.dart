import 'package:game_tv/core/data/genres/datasources/genres_remote_datasource.dart';
import 'package:game_tv/core/domain/genres/repositories/genres_repository.dart';

class GenresRepositoryImpl implements GenresRepository {
  final GenresRemoteDataSource remoteDataSource;

  GenresRepositoryImpl(this.remoteDataSource);
}
