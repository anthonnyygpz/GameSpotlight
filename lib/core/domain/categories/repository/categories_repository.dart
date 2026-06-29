import 'package:game_tv/core/domain/categories/entity/category_entity.dart';

abstract class CategoriesRepository {
  Future<List<CategoryEntity>> getAll();

  // Future<CategoryEntity> getById(String id);

  // Future<CategoryEntity> create(CategoryEntity entity);
  //
  // Future<CategoryEntity> update(CategoryEntity entity);
  //
  // Future<void> delete(String id);
}
