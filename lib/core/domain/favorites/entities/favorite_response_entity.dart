import 'package:gamespotlight/core/domain/favorites/entities/favorite_entity.dart';

class FavoriteResponseEntity {
  const FavoriteResponseEntity({required this.success, required this.data});

  final bool success;
  final List<FavoriteEntity>? data;
}
