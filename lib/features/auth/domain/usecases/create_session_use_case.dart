// features/auth/domain/usecases/create_session_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/auth/domain/entities/create_session_params.dart';
import 'package:movie/features/auth/domain/entities/session_entitiy.dart';
import 'package:movie/features/auth/domain/repositories/auth_repository.dart';

class CreateSessionUseCase {
  final AuthRepository _authRepository;

  CreateSessionUseCase(this._authRepository);

  Future<Either<Failure, SessionEntity>> call(CreateSessionParams params) async {
    return _authRepository.createSession(params);
  }
}