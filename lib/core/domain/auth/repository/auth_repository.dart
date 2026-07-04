import 'package:game_tv/core/domain/auth/entity/auth_response_entity.dart';
import 'package:game_tv/core/domain/auth/usecases/auth/login_usecase.dart';
import 'package:game_tv/core/domain/auth/usecases/auth/register_usecase.dart';

abstract class AuthRepository {
  Future<AuthResponseEntity> login(LoginParams params);
  Future<AuthResponseEntity> register(RegisterParams params);
  //
  // Future<AuthEntity> update(AuthEntity entity);
  //
  // Future<void> delete(String id);
}
