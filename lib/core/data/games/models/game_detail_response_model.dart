import 'package:gamespotlight/core/data/games/models/game_detail_model.dart';
import 'package:gamespotlight/core/domain/games/entities/game_detail_response_entity.dart';

class GameDetailResponseModel extends GameDetailResponseEntity {
  const GameDetailResponseModel({required super.success, required super.data});

  factory GameDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return GameDetailResponseModel(
      success: json['success'] as bool,
      data: GameDetailModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
