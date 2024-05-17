// features/home/presentation/bloc/home_bloc.dart
import 'package:bloc/bloc.dart';import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/core/constansts/strings/messages.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/movie/domain/entities/movies_entity.dart';

part 'home_event.dart';
part 'home_state.dart';
class HomeBloc extends Bloc<HomeEvent, HomeState> {

  MoviesEntity? movies;
  int currentPage = 1;
  bool isFetching = false;

  HomeBloc() : super(HomeInitial()) {
   
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case UnauthorizedFailure:
        return UNAUTHORIZED_MESSAGE;
      case NotFoundFailure:
        return NOT_FOUND_MESSAGE;
      case NoInternetFailure:
        return NO_INTERNET_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
