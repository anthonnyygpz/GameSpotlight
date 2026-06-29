import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/data/trailers/datasources/trailers_remote_datasource.dart';
import 'package:game_tv/core/data/trailers/repositories/trailers_repository_impl.dart';
import 'package:game_tv/core/domain/trailers/entities/trailer_entity.dart';
import 'package:game_tv/core/domain/trailers/repositories/trailers_repository.dart';
import 'package:game_tv/core/providers/dio_client.dart';

final trailersRepositoryProvider = Provider<TrailersRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final dataSource = TrailersRemoteDataSource(dio);
  return TrailerRepositoryImpl(dataSource);
});

final trailersProvider = FutureProvider<List<dynamic>>((ref) async {
  final repository = ref.watch(trailersRepositoryProvider);
  return repository.getTrailers();
});

final trailerDetailsProvider = FutureProvider.family<TrailerEntity, String>((
  ref,
  id,
) async {
  final repository = ref.watch(trailersRepositoryProvider);
  return repository.getTrailerById(id);
});
