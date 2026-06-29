import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/data/trailer_categories/datasource/trailer_categories_remote_datasource.dart';
import 'package:game_tv/core/data/trailer_categories/repository/trailer_categories_repository_impl.dart';
import 'package:game_tv/core/domain/trailer_categories/entity/trailer_categories_entity.dart';
import 'package:game_tv/core/domain/trailer_categories/repository/trailer_categories_repository.dart';
import 'package:game_tv/core/providers/dio_client.dart';

final trailerCategoriesRepositoryProvider =
    Provider<TrailerCategoriesRepository>((ref) {
      final dio = ref.watch(dioProvider);
      final dataSource = TrailerCategoriesRemoteDataSource(dio);
      return TrailerCategoriesRepositoryImpl(dataSource);
    });

final trailerCategoriesProvider = FutureProvider<List<TrailerCategoryEntity>>((
  ref,
) async {
  final repository = ref.watch(trailerCategoriesRepositoryProvider);
  return repository.getAll();
});

// final trailerCategoriesByIdProvider =
//     FutureProvider.family<TrailerCategoryEntity, String>((ref, id) async {
//       final repository = ref.watch(trailerCategoriesRepositoryProvider);
//       return repository.getTrailerCategoryById(id);
//     });
