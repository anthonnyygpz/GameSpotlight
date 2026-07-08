import 'package:gamespotlight/core/domain/auth/entity/auth_entity.dart';
import 'package:gamespotlight/core/domain/auth/repository/auth_repository.dart';

class LoginParams {
  const LoginParams({required this.identifier, required this.password});

  final String identifier;
  final String password;
}

class LoginUseCase {
  const LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<AuthEntity> call(LoginParams params) async {
    return await _authRepository.login(params);
  }
}
