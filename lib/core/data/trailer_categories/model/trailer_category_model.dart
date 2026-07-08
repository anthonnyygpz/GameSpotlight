import 'package:gamespotlight/core/domain/trailer_categories/entity/trailer_categories_entity.dart';

class TrailerCategoryModel extends TrailerCategoryEntity {
  const TrailerCategoryModel({
    required super.trailerId,
    required super.categoryId,
  });

  factory TrailerCategoryModel.fromJson(Map<String, dynamic> json) {
    return TrailerCategoryModel(
      trailerId: json['trailer_id'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'trailer_id': trailerId, 'category_id': categoryId};
  }
}
