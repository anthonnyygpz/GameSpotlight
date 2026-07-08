import 'package:gamespotlight/core/domain/auth/entity/auth_entity.dart';
import 'package:gamespotlight/core/domain/auth/repository/auth_repository.dart';

class RegisterParams {
  const RegisterParams({
    required this.email,
    required this.password,
    required this.name,
    required this.country,
  });

  final String email;
  final String password;
  final String name;
  final String country;
}

class RegisterUseCase {
  const RegisterUseCase(this._authRepository);
  final AuthRepository _authRepository;

  Future<AuthEntity> call(RegisterParams params) async {
    return await _authRepository.register(params);
  }
}
