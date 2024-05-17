// features/auth/presentation/bloc/auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class AuthenticateUserEvent extends AuthEvent {
  final String username;
  final String password;

  const AuthenticateUserEvent({
    required this.username,
    required this.password,
  
  });

  @override
  List<Object> get props => [username, password];
}

class CheckLoginEvent extends AuthEvent {}
class LogoutEvent extends AuthEvent {}
