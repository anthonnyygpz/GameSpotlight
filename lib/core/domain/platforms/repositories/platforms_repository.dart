import 'package:gamespotlight/core/domain/platforms/entities/game_platform_entity.dart';
import 'package:gamespotlight/core/domain/platforms/entities/platforms_entity.dart';

abstract class PlatformsRepository {
  Future<List<PlatformEntity>> getPlatforms();
  Future<List<GamePlatformEntity>> getGamePlatforms(String platformId);
}
