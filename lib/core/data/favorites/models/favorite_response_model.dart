import 'package:gamespotlight/core/data/favorites/models/favorite_model.dart';
import 'package:gamespotlight/core/domain/favorites/entities/favorite_response_entity.dart';

class FavoriteResponseModel extends FavoriteResponseEntity {
  const FavoriteResponseModel({required super.success, required super.data});

  factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) {
    return FavoriteResponseModel(
      success: json['success'] as bool,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => FavoriteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
