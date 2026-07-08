import 'package:gamespotlight/core/domain/favorites/repositories/favorites_repository.dart';

class ToggleFavoriteUseCase {
  const ToggleFavoriteUseCase(this._favoritesRepository);
  final FavoritesRepository _favoritesRepository;

  Future<void> call(String gameId) async {
    final isFavorite = await _favoritesRepository.isFavorite(gameId);
    if (isFavorite) {
      await _favoritesRepository.removeFavorite(gameId);
    } else {
      await _favoritesRepository.addFavorite(gameId);
    }
  }
}
