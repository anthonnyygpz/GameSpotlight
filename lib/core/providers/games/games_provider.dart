import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/data/games/datasources/games_remote_datasource.dart';
import 'package:game_tv/core/data/games/repositories/games_repository_impl.dart';
import 'package:game_tv/core/domain/games/entities/game_entity.dart';
import 'package:game_tv/core/domain/games/repositories/games_repository.dart';
import 'package:game_tv/core/providers/dio_client.dart';

// 2. Inyección de Dependencias
final gamesRepositoryProvider = Provider<GamesRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final dataSource = GamesRemoteDataSource(dio);
  return GamesRepositoryImpl(dataSource);
});

// 3. Proveedores Asíncronos Globales (Los que la UI consumirá)
// Proveedor para próximos lanzamientos
final gamesProvider = FutureProvider<List<GameEntity>>((ref) async {
  final repository = ref.watch(gamesRepositoryProvider);
  return repository.getGames();
});

// Proveedor con parámetro (Family) para los detalles de un juego específico
final gameDetailsProvider = FutureProvider.family<GameEntity, String>((
  ref,
  id,
) async {
  final repository = ref.watch(gamesRepositoryProvider);
  return repository.getGameById(id);
});
