// features/auth/domain/repositories/auth_repository.dart
import 'package:movie/core/errors/failurs.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/features/auth/domain/entities/create_session_params.dart';
import 'package:movie/features/auth/domain/entities/session_entitiy.dart';
import 'package:movie/features/auth/domain/entities/validate_token_params.dart';
abstract class AuthRepository{
  Future<Either<Failure, String>> createToken();
  Future<Either<Failure, SessionEntity>> createSession(CreateSessionParams params);
  Future<Either<Failure, Unit>> validateToken (ValidateTokenParams params);
  Future<Either<Failure, int>> getAccountId(SessionEntity params);
  Future<Either<Failure, SessionEntity>> checkLogin();
  Future<Either<Failure, Unit>> logout();
  
}