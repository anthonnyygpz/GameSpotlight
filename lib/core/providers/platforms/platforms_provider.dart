import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamespotlight/core/data/platforms/repositories/platforms_repository_impl.dart';
import 'package:gamespotlight/core/domain/platforms/entities/game_platform_entity.dart';
import 'package:gamespotlight/core/domain/platforms/entities/platforms_entity.dart';
import 'package:gamespotlight/core/domain/platforms/repositories/platforms_repository.dart';
import 'package:gamespotlight/core/providers/dio_client.dart';

final platformsRepositoryProvider = Provider<PlatformsRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PlatformsRepositoryImpl(dio);
});

final platformsProvider = FutureProvider<List<PlatformEntity>?>((ref) async {
  final repository = ref.watch(platformsRepositoryProvider);
  final response = await repository.getPlatforms();
  return response;
});

final gamePlatformsProvider =
    FutureProvider.family<List<GamePlatformEntity>?, String>((
      ref,
      platformId,
    ) async {
      final repository = ref.watch(platformsRepositoryProvider);
      final response = await repository.getGamePlatforms(platformId);
      return response;
    });
