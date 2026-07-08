import 'package:gamespotlight/core/domain/auth/entity/user_auth_entity.dart';

class AuthEntity {
  const AuthEntity({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final UserAuthEntity user;
}
