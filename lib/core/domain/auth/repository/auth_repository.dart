import 'package:gamespotlight/core/domain/auth/entity/auth_entity.dart';
import 'package:gamespotlight/core/domain/auth/entity/user_entity.dart';
import 'package:gamespotlight/core/domain/auth/usecases/auth/login_usecase.dart';
import 'package:gamespotlight/core/domain/auth/usecases/auth/register_usecase.dart';
import 'package:gamespotlight/core/domain/auth/usecases/auth/update_user_usecase.dart';

abstract class AuthRepository {
  Future<AuthEntity> login(LoginParams params);
  Future<AuthEntity> register(RegisterParams params);
  Future<String> update(UpdateUserParams params);
  Future<UserEntity> me();
  // Future<void> delete(String id);
}
