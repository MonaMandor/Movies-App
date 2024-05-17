// features/auth/data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/exception.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/core/network/network_info.dart';
import 'package:movie/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:movie/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:movie/features/auth/data/models/create_session_model.dart';
import 'package:movie/features/auth/data/models/session_model.dart';
import 'package:movie/features/auth/data/models/validate_token_model.dart';
import 'package:movie/features/auth/domain/entities/create_session_params.dart';
import 'package:movie/features/auth/domain/entities/session_entitiy.dart';
import 'package:movie/features/auth/domain/entities/validate_token_params.dart';
import 'package:movie/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.remoteDataSource,
      required this.networkInfo,
      required this.localDataSource});

  @override
  Future<Either<Failure, String>> createToken() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDataSource.createToken();
        await localDataSource.cacheToken(token);
        return Right(token);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on NotFoundException {
        return Left(NotFoundFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, SessionEntity>> createSession(
      CreateSessionParams params) async {
    final createSessionModel = CreateSessionModel(
      userToken: params.userToken,
    );
    if (await networkInfo.isConnected) {
      try {
        final sessionData =
            await remoteDataSource.createSession(createSessionModel);
        final session = SessionModel.fromJson(sessionData);
        await localDataSource.cacheSessionId(session.sessionId);

        return Right(session);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on NotFoundException {
        return Left(NotFoundFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> validateToken(
      ValidateTokenParams params) async {
    final validateTokenModel = VlidateTokenModel(
      password: params.password,
      token: params.token,
      userName: params.userName,
    );
    if (await networkInfo.isConnected) {
      try {
        remoteDataSource.validateToken(validateTokenModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on NotFoundException {
        return Left(NotFoundFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, SessionEntity>> checkLogin() async {
    try {
      final sessionId = await localDataSource.getSessionId();
      if (sessionId != null) {
        return Right(SessionModel(
          sessionId: sessionId,
        ));
      } else {
        localDataSource.clearAll();
        return Left(CacheFailure());
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getAccountId(SessionEntity params) async {
    final sessionModel = SessionModel(sessionId: params.sessionId);
    if (await networkInfo.isConnected) {
      try {
        final accountId = await remoteDataSource.getAccountId(sessionModel);
        await localDataSource.cachAccountId(accountId);
        return Right(accountId);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on NotFoundException {
        return Left(NotFoundFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    localDataSource.clearAll();
    return Future.value(const Right(unit));
  }
}
