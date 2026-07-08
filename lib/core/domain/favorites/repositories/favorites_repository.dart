import 'package:gamespotlight/core/domain/favorites/entities/favorite_response_entity.dart';

abstract class FavoritesRepository {
  Future<void> addFavorite(String gameId);
  Future<void> removeFavorite(String gameId);
  Future<FavoriteResponseEntity> getFavorites();
  Future<bool> isFavorite(String gameId);
}
