import 'package:gamespotlight/core/domain/auth/entity/user_auth_entity.dart';

class UserAuthModel extends UserAuthEntity {
  const UserAuthModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserAuthModel.fromJson(Map<String, dynamic> json) {
    return UserAuthModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}
