// features/auth/presentation/bloc/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/core/constansts/strings/messages.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/auth/domain/entities/create_session_params.dart';
import 'package:movie/features/auth/domain/entities/session_entitiy.dart';
import 'package:movie/features/auth/domain/entities/validate_token_params.dart';
import 'package:movie/features/auth/domain/usecases/check_login_use_case.dart';
import 'package:movie/features/auth/domain/usecases/create_session_use_case.dart';
import 'package:movie/features/auth/domain/usecases/create_token_use_case.dart';
import 'package:movie/features/auth/domain/usecases/get_account_id_use_case.dart';
import 'package:movie/features/auth/domain/usecases/validate_token_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateTokenUseCase createTokenUseCase;
  final CreateSessionUseCase createSessionUseCase;
  final ValidateTokenUseCase validateTokenUseCase;
  final CeckLoginUseCase checkLoginUseCase;
  final GetAccountIdUseCase getAccountIdUseCase;

  String? token;
  SessionEntity? sessionEntity;
  int? accountId;

  AuthBloc({
    required this.createTokenUseCase,
    required this.createSessionUseCase,
    required this.validateTokenUseCase,
    required this.checkLoginUseCase,
    required this.getAccountIdUseCase,
  }) : super(AuthInitial()) {
    on<AuthenticateUserEvent>(_onAuthenticateUserEvent);
    on<CheckLoginEvent>(_onCheckLoginEvent);
  }

  Future<void> _onAuthenticateUserEvent(
      AuthenticateUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthenticateUserLoading());

    final failureOrToken = await createTokenUseCase();
    await failureOrToken.fold(
      (failure) async {
        emit(AuthenticateUserFailure(message: _mapFailureToMessage(failure)));
      },
      (token) async {
        final failureOrValidate = await validateTokenUseCase(
          ValidateTokenParams(
            userName: event.username,
            password: event.password,
            token: token,
          ),
        );
        await failureOrValidate.fold(
          (failure) async {
            emit(AuthenticateUserFailure(
                message: _mapFailureToMessage(failure)));
          },
          (unit) async {
            final failureOrSession = await createSessionUseCase(
                CreateSessionParams(userToken: token));
            await failureOrSession.fold(
              (failure) async {
                emit(AuthenticateUserFailure(
                    message: _mapFailureToMessage(failure)));
              },
              (session) async {
                sessionEntity = session;
                final failureOrAccountId = await getAccountIdUseCase(session);
                await failureOrAccountId.fold(
                  (failure) async {
                    emit(AuthenticateUserFailure(
                        message: _mapFailureToMessage(failure)));
                  },
                  (Id) async {
                    accountId = Id;
                    if (!emit.isDone) {
                      emit(AuthenticateUserSuccess(sessionEntity: session));
                    }
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _onCheckLoginEvent(
      CheckLoginEvent event, Emitter<AuthState> emit) async {
    emit(CheckLoginLoading());

    final failureOrSession = await checkLoginUseCase();
    await failureOrSession.fold(
      (failure) async {
        emit(CheckLoginFailure(message: _mapFailureToMessage(failure)));
      },
      (session) async {
        sessionEntity = session;
        final failureOrAccountId = await getAccountIdUseCase(session);
        await failureOrAccountId.fold(
          (failure) async {
            emit(CheckLoginFailure(message: _mapFailureToMessage(failure)));
          },
          (accountId) async {
            this.accountId = accountId;
            if (!emit.isDone) {
              emit(CheckLoginSuccess(sessionEntity: session));
            }
          },
        );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case UnauthorizedFailure:
        return UNAUTHORIZED_MESSAGE;
      case NotFoundFailure:
        return NOT_FOUND_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case NoInternetFailure:
        return NO_INTERNET_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
