import 'package:game_tv/core/domain/trailer_categories/entity/trailer_categories_entity.dart';

abstract class TrailerCategoriesRepository {
  Future<List<TrailerCategoryEntity>> getAll();

  // Future<TrailerCategoriesEntity> getById(String id);
  //
  // Future<TrailerCategoriesEntity> create(TrailerCategoriesEntity entity);
  //
  // Future<TrailerCategoriesEntity> update(TrailerCategoriesEntity entity);
  //
  // Future<void> delete(String id);
}
