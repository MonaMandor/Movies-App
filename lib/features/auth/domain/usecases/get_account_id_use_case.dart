// features/auth/domain/usecases/get_account_id_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/auth/domain/entities/session_entitiy.dart';
import 'package:movie/features/auth/domain/repositories/auth_repository.dart';

class GetAccountIdUseCase {
  final AuthRepository _authRepository;

  GetAccountIdUseCase(this._authRepository);

  Future<Either<Failure, int>> call(SessionEntity params) async {
    return _authRepository.getAccountId(params);
  }
}