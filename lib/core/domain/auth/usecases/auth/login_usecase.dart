import 'package:game_tv/core/domain/auth/entity/auth_response_entity.dart';
import 'package:game_tv/core/domain/auth/repository/auth_repository.dart';

class LoginParams {
  const LoginParams({required this.identifier, required this.password});

  final String identifier;
  final String password;
}

class LoginUseCase {
  const LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<AuthResponseEntity> call(LoginParams params) async {
    return await _authRepository.login(params);
  }
}
