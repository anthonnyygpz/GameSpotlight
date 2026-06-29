import 'package:dio/dio.dart';
import 'package:game_tv/core/data/auth/model/auth_response_model.dart';
import 'package:game_tv/core/domain/auth/entity/auth_response_entity.dart';
import 'package:game_tv/core/domain/auth/entity/login_entity.dart';
import 'package:game_tv/core/domain/auth/entity/register_entity.dart';
import 'package:game_tv/core/domain/auth/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<AuthResponseEntity> login(LoginEntity entity) async {
    final response = await _dio.post(
      '/auth/login',
      data: {'identifier': entity.identifier, 'password': entity.password},
    );

    final z = AuthResponseModel.fromJson(response.data);
    return z;
  }

  @override
  Future<AuthResponseEntity> register(RegisterEntity entity) async {
    final response = await _dio.post(
      '/auth/register',
      data: {
        'email': entity.email,
        'password': entity.password,
        'name': entity.name,
        'country': entity.country,
      },
    );

    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  // @override
  // Future<AuthEntity> update(AuthEntity entity) {
  //
  // }

  // @override
  // Future<void> delete(String id) {
  //
  // }
}
