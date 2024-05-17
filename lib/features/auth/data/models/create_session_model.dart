// features/auth/data/models/create_session_model.dart
import 'package:movie/features/auth/domain/entities/create_session_params.dart';

class CreateSessionModel extends CreateSessionParams{
  const CreateSessionModel({
    required super.userToken,
  });

  factory CreateSessionModel.fromJson(Map<String, dynamic> json) {
    return CreateSessionModel(
      userToken: json['request_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_token': userToken,
    };
  }}