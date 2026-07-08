import 'package:gamespotlight/core/domain/platforms/entities/platforms_entity.dart';

class PlatformsModel extends PlatformEntity {
  const PlatformsModel({
    required super.id,
    required super.name,
    required super.type,
    required super.iconUrl,
  });

  factory PlatformsModel.fromJson(Map<String, dynamic> json) {
    return PlatformsModel(
      id: json['platform_id'],
      name: json['name'],
      type: json['type'],
      iconUrl: json['icon_url'],
    );
  }
}
