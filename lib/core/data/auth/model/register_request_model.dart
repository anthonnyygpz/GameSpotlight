import 'package:game_tv/core/domain/auth/usecases/auth/register_usecase.dart';

class RegisterRequestModel extends RegisterParams {
  const RegisterRequestModel({
    required super.email,
    required super.password,
    required super.name,
    required super.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'country': country,
    };
  }
}
