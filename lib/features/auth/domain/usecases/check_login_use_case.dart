// features/auth/domain/usecases/check_login_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/auth/domain/entities/session_entitiy.dart';
import 'package:movie/features/auth/domain/repositories/auth_repository.dart';

class CeckLoginUseCase {
  final AuthRepository _authRepository;

  CeckLoginUseCase(this._authRepository);

   Future<Either<Failure, SessionEntity>> call() async {
    return  _authRepository.checkLogin();
  }
}