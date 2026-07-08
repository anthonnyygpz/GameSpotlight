import 'package:dio/dio.dart';
import 'package:gamespotlight/core/data/favorites/models/favorite_response_model.dart';
import 'package:gamespotlight/core/domain/favorites/entities/favorite_response_entity.dart';
import 'package:gamespotlight/core/domain/favorites/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<void> addFavorite(String gameId) async {
    await _dio.post('/favorites', data: {'gameId': gameId});
  }

  @override
  Future<void> removeFavorite(String gameId) async {
    await _dio.delete('/favorites/$gameId');
  }

  @override
  Future<FavoriteResponseEntity> getFavorites() async {
    final raw = await _dio.get('/favorites');
    return FavoriteResponseModel.fromJson(raw.data);
  }

  @override
  Future<bool> isFavorite(String gameId) async {
    final raw = await _dio.get('/favorites');

    final response = FavoriteResponseModel.fromJson(raw.data);
    if (response.data == null) return false;

    return response.data!.any((game) => game.gameId == gameId);
  }
}
