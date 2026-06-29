import 'package:game_tv/core/data/trailer_categories/datasource/trailer_categories_remote_datasource.dart';
import 'package:game_tv/core/data/trailer_categories/model/trailer_category_model.dart';
import 'package:game_tv/core/domain/trailer_categories/entity/trailer_categories_entity.dart';
import 'package:game_tv/core/domain/trailer_categories/repository/trailer_categories_repository.dart';

class TrailerCategoriesRepositoryImpl implements TrailerCategoriesRepository {
  final TrailerCategoriesRemoteDataSource remoteDataSource;

  TrailerCategoriesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TrailerCategoryEntity>> getAll() async {
    final rawData = await remoteDataSource.getAll();
    return rawData.map((json) => TrailerCategoryModel.fromJson(json)).toList();
  }

  // @override
  // Future<TrailerCategoriesEntity> getById(String id) {
  //
  // }

  // @override
  // Future<TrailerCategoriesEntity> create(TrailerCategoriesEntity entity) {
  //
  // }

  // @override
  // Future<TrailerCategoriesEntity> update(TrailerCategoriesEntity entity) {
  //
  // }

  // @override
  // Future<void> delete(String id) {
  //
  // }
}
