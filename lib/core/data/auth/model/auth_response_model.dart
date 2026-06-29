import 'package:game_tv/core/domain/auth/entity/auth_response_entity.dart';

class AuthResponseModel extends AuthResponseEntity {
  const AuthResponseModel({required super.token, required super.user});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'] as String,
      user: AuthUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class AuthUserModel extends AuthUserEntity {
  const AuthUserModel({
    required super.userId,
    required super.name,
    required super.email,
    required super.country,
    super.registeredAt,
    super.role,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      country: json['country'] as String,
      registeredAt: json['registeredAt'] != null
          ? DateTime.parse(json['registeredAt'] as String)
          : null,
      role: json['role'] as String?,
    );
  }
}
