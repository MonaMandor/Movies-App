// features/movie/presentation/bloc/movie_event.dart
part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class AddToWatchListEvent extends MovieEvent {
  final AddDetetToWatchListParams params;

  const AddToWatchListEvent({required this.params});

  @override
  List<Object> get props => [params];
}
class GetWatchListEvent extends MovieEvent {
  final int page;
  final GetoWatchListParams params;

  const GetWatchListEvent({required this.page, required this.params});

  @override
  List<Object> get props => [page, params];
}


class GetMoviesEvent extends MovieEvent {
  final int page;
  final String moviesType;

  const GetMoviesEvent({required this.page, required this.moviesType});

  @override
  List<Object> get props => [page, moviesType];
}
