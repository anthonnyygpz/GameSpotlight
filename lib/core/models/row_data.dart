import 'package:gamespotlight/core/domain/games/entities/game_entity.dart';

class RowData {
  final String title;
  final List<GameEntity> items;
  final String? targetRoute;
  final bool showDate;
  final bool showBadgeTop;

  RowData({
    required this.title,
    required this.items,
    this.targetRoute,
    this.showDate = false,
    this.showBadgeTop = false,
  });

  bool get hasTrailingAction => targetRoute != null;
  int get totalCount => hasTrailingAction ? items.length + 1 : items.length;
}
