import 'package:gamespotlight/core/domain/games/entities/game_detail_entity.dart';

class GameDetailResponseEntity {
  const GameDetailResponseEntity({required this.success, required this.data});

  final bool success;
  final GameDetailEntity? data;
}
