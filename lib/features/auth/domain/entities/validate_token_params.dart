// features/auth/domain/entities/validate_token_params.dart
import 'package:equatable/equatable.dart';

class ValidateTokenParams extends Equatable {
  final String token;
  final String userName;
  final String password;

  const ValidateTokenParams(
      {required this.token, required this.userName, required this.password});

  @override
  List<Object?> get props => [token, userName, password];
}
