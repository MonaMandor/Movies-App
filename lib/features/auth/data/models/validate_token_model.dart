// features/auth/data/models/validate_token_model.dart
import 'package:movie/features/auth/domain/entities/validate_token_params.dart';

class VlidateTokenModel extends ValidateTokenParams {
  const VlidateTokenModel({
    required super.token,
    required super.userName,
    required super.password,
  });

  factory VlidateTokenModel.fromJson(Map<String, dynamic> json) {
    return VlidateTokenModel(
      userName: json['username'],
      password: json['password'],
      token: json['request_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_token': token,
      'username': userName,
      'password': password,
    };
  }
}
