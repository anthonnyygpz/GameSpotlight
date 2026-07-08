class UserEntity {
  const UserEntity({
    required this.id,
    this.name,
    required this.email,
    this.avatarUrl,
    this.country,
    // required this.theme,
    // required this.emailNotifications,
    // required this.pushNotifications,
    // required this.profilePrivacy,
    // this.languageCode,
    // this.languageName,
    required this.role,
  });

  final String id;
  final String? name;
  final String email;
  final String? avatarUrl;
  final String? country;
  // final DateTime registeredAt;
  // final DateTime lastLogin;
  // final String theme;
  // final bool emailNotifications;
  // final bool pushNotifications;
  // final String profilePrivacy;
  // final String? languageCode;
  // final String? languageName;
  final String role;
}
