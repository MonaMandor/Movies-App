// features/auth/domain/usecases/validate_token_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/auth/domain/entities/validate_token_params.dart';
import 'package:movie/features/auth/domain/repositories/auth_repository.dart';

class ValidateTokenUseCase {
  final AuthRepository repository;

  ValidateTokenUseCase(this.repository);

  Future<Either<Failure, Unit>> call(ValidateTokenParams params) async {
    return await repository.validateToken(params);
  }
}
