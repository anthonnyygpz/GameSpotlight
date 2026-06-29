class AuthResponseEntity {
  const AuthResponseEntity({required this.token, required this.user});

  final String token;
  final AuthUserEntity user;
}

class AuthUserEntity {
  const AuthUserEntity({
    required this.userId,
    required this.name,
    required this.email,
    required this.country,
    this.registeredAt,
    this.role,
  });

  final String userId;
  final String name;
  final String email;
  final String country;
  final DateTime? registeredAt;
  final String? role;
}
