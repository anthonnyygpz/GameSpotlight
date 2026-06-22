import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_tv/core/constants/trailer_game.dart';
import 'package:game_tv/features/home/models/game_item.dart';

final rawGamesProvider = Provider<List<GameItem>>((ref) {
  return globalTrailerGames;
});

final groupedgamesProvider = Provider<Map<String, List<GameItem>>>((ref) {
  final games = ref.watch(rawGamesProvider);
  final Map<String, List<GameItem>> grouped = {};

  for (final game in games) {
    grouped.putIfAbsent(game.category, () => []).add(game);
  }
  return grouped;
});

