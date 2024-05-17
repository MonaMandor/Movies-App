// features/auth/presentation/bloc/auth_state.dart
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class CreateTokenLoading extends AuthState {}

class CreateTokenSuccess extends AuthState {
  final String token;

  const CreateTokenSuccess({required this.token});

  @override
  List<Object> get props => [token];
}

class CreateTokenFailure extends AuthState {
  final String message;

  const CreateTokenFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateSessionLoading extends AuthState {}

class CreateSessionSuccess extends AuthState {


  const CreateSessionSuccess();

  @override
  List<Object> get props => [];
}

class CreateSessionFailure extends AuthState {
  final String message;

  const CreateSessionFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ValidateTokenLoading extends AuthState {}

class ValidateTokenSuccess extends AuthState {}

class ValidateTokenFailure extends AuthState {
  final String message;

  const ValidateTokenFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthenticateUserLoading extends AuthState {}

class AuthenticateUserSuccess extends AuthState {
  final SessionEntity sessionEntity;

  const AuthenticateUserSuccess({ required this.sessionEntity});

  @override
  List<Object> get props => [sessionEntity];
}

class AuthenticateUserFailure extends AuthState {
  final String message;

  const AuthenticateUserFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class  CheckLoginLoading extends AuthState {}

class  CheckLoginSuccess extends AuthState {
  final SessionEntity sessionEntity;

  const CheckLoginSuccess({ required this.sessionEntity});

  @override
  List<Object> get props => [sessionEntity];
}

class  CheckLoginFailure extends AuthState {
  final String message;

  const CheckLoginFailure({ required this.message});

  @override
  List<Object> get props => [message];
}
