import 'package:gamespotlight/core/data/auth/model/user_auth_model.dart';
import 'package:gamespotlight/core/domain/auth/entity/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.accessToken,
    required super.tokenType,
    required super.expiresIn,
    required super.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
      user: UserAuthModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
