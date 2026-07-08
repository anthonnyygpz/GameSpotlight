import 'package:gamespotlight/core/domain/favorites/repositories/favorites_repository.dart';

class RemoveFavoriteUseCase {
  const RemoveFavoriteUseCase(this._favoritesRepository);
  final FavoritesRepository _favoritesRepository;

  Future<void> call(String gameId) async {
    return await _favoritesRepository.removeFavorite(gameId);
  }
}
