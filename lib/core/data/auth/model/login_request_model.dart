import 'package:game_tv/core/domain/auth/usecases/auth/login_usecase.dart';

class LoginRequestModel extends LoginParams {
  const LoginRequestModel({required super.identifier, required super.password});

  Map<String, dynamic> toJson() {
    return {'identifier': identifier, 'password': password};
  }
}
