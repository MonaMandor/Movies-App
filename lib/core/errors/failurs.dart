// core/errors/failurs.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OffLineFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class UnauthorizedFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class NotFoundFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class NoInternetFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure{
  @override
  List<Object?> get props => [];
}