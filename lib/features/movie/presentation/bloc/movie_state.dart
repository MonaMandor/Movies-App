// features/movie/presentation/bloc/movie_state.dart
part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class AddToWatchListLoading extends MovieState {}

class AddToWatchListSuccess extends MovieState {}

class AddToWatchListError extends MovieState {
  final String message;

  const AddToWatchListError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetWatchListMoviesLoading extends MovieState {}

class GetWatchListMoviesSuccess extends MovieState {
  final MoviesEntity movies;
  final bool hasReachedMax;

  const GetWatchListMoviesSuccess({required this.movies, required this.hasReachedMax});

  @override
  List<Object> get props => [movies, hasReachedMax];
}

class GetWatchListMoviesError extends MovieState {
  final String message;

  const GetWatchListMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetMoviesLoading extends MovieState {}

class GetMoviesLoaded extends MovieState {
  final MoviesEntity movies;
  final bool hasReachedMax;

  const GetMoviesLoaded({required this.movies, required this.hasReachedMax});

  @override
  List<Object> get props => [movies, hasReachedMax];
}

class GetMoviesError extends MovieState {
  final String message;

  const GetMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}
