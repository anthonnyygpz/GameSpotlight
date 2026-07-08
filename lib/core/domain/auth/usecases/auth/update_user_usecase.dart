import 'package:gamespotlight/core/domain/auth/repository/auth_repository.dart';

class UpdateUserParams {
  const UpdateUserParams({
    required this.username,
    required this.avatarUrl,
    required this.country,
  });

  final String username;
  final String avatarUrl;
  final String country;
}

class UpdateUserUseCase {
  const UpdateUserUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<String> call(UpdateUserParams params) async {
    return await _authRepository.update(params);
  }
}
