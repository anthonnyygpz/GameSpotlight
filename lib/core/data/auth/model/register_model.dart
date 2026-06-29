import 'package:game_tv/core/domain/auth/entity/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel({
    required super.email,
    required super.password,
    required super.name,
    required super.country,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      name: json['name'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }

  factory RegisterModel.fromEntity(RegisterEntity entity) {
    return RegisterModel(
      email: entity.email,
      password: entity.password,
      name: entity.name,
      country: entity.country,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'country': country,
    };
  }
}
