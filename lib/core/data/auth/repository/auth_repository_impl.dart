import 'package:dio/dio.dart';
import 'package:gamespotlight/core/data/auth/model/auth_model.dart';
import 'package:gamespotlight/core/data/auth/model/login_request_model.dart';
import 'package:gamespotlight/core/data/auth/model/register_request_model.dart';
import 'package:gamespotlight/core/data/auth/model/update_user_request_model.dart';
import 'package:gamespotlight/core/data/auth/model/user_model.dart';
import 'package:gamespotlight/core/domain/auth/entity/auth_entity.dart';
import 'package:gamespotlight/core/domain/auth/entity/user_entity.dart';
import 'package:gamespotlight/core/domain/auth/repository/auth_repository.dart';
import 'package:gamespotlight/core/domain/auth/usecases/auth/login_usecase.dart';
import 'package:gamespotlight/core/domain/auth/usecases/auth/register_usecase.dart';
import 'package:gamespotlight/core/domain/auth/usecases/auth/update_user_usecase.dart';
import 'package:gamespotlight/core/errors/exceptions.dart';
import 'package:gamespotlight/core/models/api_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<AuthEntity> login(LoginParams params) async {
    try {
      final request = LoginRequestModel(
        identifier: params.identifier,
        password: params.password,
      );

      final response = await _dio.post('/auth/login', data: request.toJson());
      final apiResponse = ApiResponse<AuthModel>.fromJson(
        response.data as Map<String, dynamic>,
        (data) => AuthModel.fromJson(data),
      );

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw ServerException(
          apiResponse.message ?? 'Error en la autenticación',
        );
      }
    } on DioException catch (_) {
      rethrow;
    } on FormatException {
      throw ServerException('Respuesta inesperada del servidor');
    }
  }

  @override
  Future<AuthEntity> register(RegisterParams params) async {
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
      final apiResponse = ApiResponse<AuthModel>.fromJson(
        response.data as Map<String, dynamic>,
        (data) => AuthModel.fromJson(data),
      );

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw ServerException(
          apiResponse.message ?? 'Error en la autenticación',
        );
      }
    } on DioException catch (_) {
      rethrow;
    } on FormatException {
      throw ServerException('Respuesta inesperada del servidor');
    }
  }

  @override
  Future<String> update(UpdateUserParams params) async {
    try {
      final request = UpdateUserRequestModel(
        username: params.username,
        country: params.country,
        avatarUrl: params.avatarUrl,
      );

      final response = await _dio.put(
        '/auth/update-user',
        data: request.toJson(),
      );
      final apiResponse = ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (apiResponse.success) {
        return apiResponse.message ?? 'Operación realizada correctamente';
      } else {
        throw ServerException(apiResponse.message ?? 'Error en el servidor');
      }
    } on DioException catch (_) {
      rethrow;
    } on FormatException {
      throw ServerException('Respuesta inesperada del servidor');
    }
  }

  @override
  Future<UserEntity> me() async {
    try {
      final response = await _dio.get('/auth/me');
      final apiResponse = ApiResponse<UserModel>.fromJson(
        response.data as Map<String, dynamic>,
        (data) => UserModel.fromJson(data),
      );

      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw ServerException(
          apiResponse.message ?? 'Error en la autenticación',
        );
      }
    } on DioException catch (_) {
      rethrow;
    } on FormatException {
      throw ServerException('Respuesta inesperada del servidor');
    }
  }

  // @override
  // Future<void> delete(String id) {
  //
  // }
}
