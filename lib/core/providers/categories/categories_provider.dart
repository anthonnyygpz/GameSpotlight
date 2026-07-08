import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/data/categories/datasource/categories_remote_datasource.dart';
import 'package:gamespotlight/core/data/categories/repository/categories_repository_impl.dart';
import 'package:gamespotlight/core/domain/categories/entity/category_entity.dart';
import 'package:gamespotlight/core/domain/categories/repository/categories_repository.dart';
import 'package:gamespotlight/core/providers/dio_client.dart';

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
