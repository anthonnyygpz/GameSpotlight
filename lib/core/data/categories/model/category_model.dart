import 'package:gamespotlight/core/domain/categories/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({required super.categoryId, required super.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['category_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'category_id': categoryId, 'name': name};
  }
}
