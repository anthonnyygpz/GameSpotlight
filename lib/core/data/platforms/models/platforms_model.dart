import 'package:game_tv/core/domain/platforms/entities/platforms_entity.dart';

class PlatformsModel extends PlatformsEntity {
  const PlatformsModel() : super();

  factory PlatformsModel.fromJson(Map<String, dynamic> json) {
    return PlatformsModel();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
