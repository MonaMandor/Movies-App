// features/auth/domain/entities/create_session_params.dart
import 'package:equatable/equatable.dart';

class CreateSessionParams extends Equatable {
  final String userToken;

  const CreateSessionParams({
    required this.userToken,
  });

  @override
  List<Object?> get props => [userToken];
}
