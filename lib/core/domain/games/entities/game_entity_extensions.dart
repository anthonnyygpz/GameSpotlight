import 'package:gamespotlight/core/domain/games/entities/game_entity.dart';
import 'package:smart_date_formatter/smart_date_formatter.dart';

extension GameEntityFormatting on GameEntity {
  String get formattedReleaseDate {
    final d = releaseDate;
    if (d == null) return 'TBD';
    return d.format('dd\n MMM yyyy');
  }
}
