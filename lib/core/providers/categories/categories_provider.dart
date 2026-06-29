import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/data/categories/datasource/categories_remote_datasource.dart';
import 'package:game_tv/core/data/categories/repository/categories_repository_impl.dart';
import 'package:game_tv/core/domain/categories/entity/category_entity.dart';
import 'package:game_tv/core/domain/categories/repository/categories_repository.dart';
import 'package:game_tv/core/providers/dio_client.dart';

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final dataSource = CategoriesRemoteDataSource(dio);
  return CategoriesRepositoryImpl(dataSource);
});

final categoriesProvider = FutureProvider<List<CategoryEntity>>((ref) async {
  final repository = ref.watch(categoriesRepositoryProvider);
  return repository.getAll();
});

// final trailerCategoriesByIdProvider =
//     FutureProvider.family<TrailerCategoryEntity, String>((ref, id) async {
//       final repository = ref.watch(trailerCategoriesRepositoryProvider);
//       return repository.getTrailerCategoryById(id);
//     });
