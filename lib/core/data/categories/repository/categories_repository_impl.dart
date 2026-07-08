import 'package:gamespotlight/core/data/categories/datasource/categories_remote_datasource.dart';
import 'package:gamespotlight/core/data/categories/model/category_model.dart';
import 'package:gamespotlight/core/domain/categories/entity/category_entity.dart';
import 'package:gamespotlight/core/domain/categories/repository/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CategoryEntity>> getAll() async {
    final rawData = await remoteDataSource.getAll();
    return rawData.map((json) => CategoryModel.fromJson(json)).toList();
  }

  // @override
  // Future<CategoriesEntity> getById(String id) {
  //
  // }

  // @override
  // Future<CategoriesEntity> create(CategoriesEntity entity) {
  //
  // }

  // @override
  // Future<CategoriesEntity> update(CategoriesEntity entity) {
  //
  // }

  // @override
  // Future<void> delete(String id) {
  //
  // }
}
