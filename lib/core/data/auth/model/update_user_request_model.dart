import 'package:gamespotlight/core/domain/auth/usecases/auth/update_user_usecase.dart';

class UpdateUserRequestModel extends UpdateUserParams {
  const UpdateUserRequestModel({
    required super.username,
    required super.avatarUrl,
    required super.country,
  });

  Map<String, dynamic> toJson() {
    return {'name': username, 'avatar_url': avatarUrl, 'country': country};
  }
}
