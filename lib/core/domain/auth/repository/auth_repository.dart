import 'package:game_tv/core/domain/auth/entity/auth_response_entity.dart';
import 'package:game_tv/core/domain/auth/entity/login_entity.dart';
import 'package:game_tv/core/domain/auth/entity/register_entity.dart';

abstract class AuthRepository {
  Future<AuthResponseEntity> login(LoginEntity entity);
  Future<AuthResponseEntity> register(RegisterEntity entity);
  //
  // Future<AuthEntity> update(AuthEntity entity);
  //
  // Future<void> delete(String id);
}
