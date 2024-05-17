// features/home/presentation/bloc/home_state.dart
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();  

  @override
  List<Object> get props => [];
}
class HomeInitial extends HomeState {}

class GetNowPlayingMoviesLoading extends HomeState {}

class GetNowPlayingMoviesLoaded extends HomeState {
  final MoviesEntity movies;

  GetNowPlayingMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class GetNowPlayingMoviesError extends HomeState {
  final String message;

  GetNowPlayingMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
