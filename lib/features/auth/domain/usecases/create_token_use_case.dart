// features/auth/domain/usecases/create_token_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/auth/domain/repositories/auth_repository.dart';

class CreateTokenUseCase {
  final AuthRepository _authRepository;

  CreateTokenUseCase(this._authRepository);

  Future<Either<Failure, String>> call() async {
    return _authRepository.createToken();
  }
}