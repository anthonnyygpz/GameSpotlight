import 'package:gamespotlight/core/domain/auth/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.avatarUrl,
    required super.country,
    // required super.registeredAt,
    // required super.lastLogin,
    // required super.theme,
    // required super.emailNotifications,
    // required super.pushNotifications,
    // required super.profilePrivacy,
    // super.languageCode,
    // super.languageName,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['user_id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    avatarUrl: json['avatar_url'] as String? ?? '',
    country: json['country'] as String,
    // registeredAt: DateTime.parse(json['registered_at'] as String),
    // lastLogin: DateTime.parse(json['last_login'] as String),
    // theme: json['theme'] as String,
    // emailNotifications: json['email_notifications'] as bool,
    // pushNotifications: json['push_notifications'] as bool,
    // profilePrivacy: json['profile_privacy'] as String,
    // languageCode: json['language_code'] as String?,
    // languageName: json['language_name'] as String?,
    role: json['role'] as String,
  );
}
