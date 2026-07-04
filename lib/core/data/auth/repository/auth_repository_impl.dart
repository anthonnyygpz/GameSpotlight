import 'package:dio/dio.dart';
import 'package:game_tv/core/data/auth/model/auth_response_model.dart';
import 'package:game_tv/core/data/auth/model/login_request_model.dart';
import 'package:game_tv/core/data/auth/model/register_request_model.dart';
import 'package:game_tv/core/domain/auth/entity/auth_response_entity.dart';
import 'package:game_tv/core/domain/auth/repository/auth_repository.dart';
import 'package:game_tv/core/domain/auth/usecases/auth/login_usecase.dart';
import 'package:game_tv/core/domain/auth/usecases/auth/register_usecase.dart';
import 'package:game_tv/core/errors/exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<AuthResponseEntity> login(LoginParams params) async {
    try {
      final request = LoginRequestModel(
        identifier: params.identifier,
        password: params.password,
      );

      final response = await _dio.post('/auth/login', data: request.toJson());

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on FormatException {
      throw ServerException('Respuesta inesperada del servidor');
    }
  }

  @override
  Future<AuthResponseEntity> register(RegisterParams params) async {
    try {
      final request = RegisterRequestModel(
        email: params.email,
        password: params.password,
        name: params.name,
        country: params.country,
      );

      final response = await _dio.post(
        '/auth/register',
        data: request.toJson(),
      );

      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on FormatException {
      throw ServerException('Respuesta inesperada del servidor');
    }
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
