class MeEntity {
  final String userId;
  final String name;
  final String email;
  final String? avatarUrl;
  final String country;
  final String registeredAt;
  final String? lastLogin;
  final String? theme;
  final int? emailNotifications;
  final int? pushNotifications;
  final String? profilePrivacy;
  final String? languageCode;
  final String? languageName;
  final String? role;

  const MeEntity({
    required this.userId,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.country,
    required this.registeredAt,
    this.lastLogin,
    this.theme,
    this.emailNotifications,
    this.pushNotifications,
    this.profilePrivacy,
    this.languageCode,
    this.languageName,
    this.role,
  });
}
