// features/movie/presentation/bloc/movie_bloc.dart
import 'package:bloc/bloc.dart';import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/core/constansts/strings/messages.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';
import 'package:movie/features/movie/domain/entities/movies_entity.dart';
import 'package:movie/features/movie/domain/usecases/add_to_watchList_use_case.dart';
import 'package:movie/features/movie/domain/usecases/get_movies_use_case.dart';
import 'package:movie/features/movie/domain/usecases/get_witch_list_movies_use_case.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final AddToWatchListUseCase addToWatchListUseCase;
  final GetWitchListMoviesUseCase getWatchListUseCase;
  final GetMoviesUseCase getMoviesUseCase;

  MoviesEntity? movies;
  MoviesEntity? watchListMovies;
  int currentPage = 1;
  bool isFetching = false;

  MovieBloc({
    required this.addToWatchListUseCase,
    required this.getWatchListUseCase,
    required this.getMoviesUseCase,
  }) : super(MovieInitial()) {
    on<MovieEvent>((event, emit) async {
     if (event is GetWatchListEvent) {
        if (isFetching) return;
        isFetching = true;
        emit(GetWatchListMoviesLoading());
        final failureOrMovies = await getWatchListUseCase(event.page, event.params);
        failureOrMovies.fold(
          (failure) => emit(GetWatchListMoviesError(message: _mapFailureToMessage(failure))),
          (watchListMovies) {
            final reachedMax = watchListMovies.movies.isEmpty;
            watchListMovies = watchListMovies == null
                ? watchListMovies
                : MoviesEntity(movies: [...watchListMovies!.movies, ...watchListMovies.movies]);
            currentPage = event.page;
            emit(GetWatchListMoviesSuccess(movies: watchListMovies!, hasReachedMax: reachedMax));
          },
        );
        isFetching = false;
      } else if (event is GetMoviesEvent) {
        if (isFetching) return;
        isFetching = true;
        emit(GetMoviesLoading());
        final failureOrMovies = await getMoviesUseCase(event.page, event.moviesType);
        failureOrMovies.fold(
          (failure) => emit(GetMoviesError(message: _mapFailureToMessage(failure))),
          (moviesEntity) {
            final reachedMax = moviesEntity.movies.isEmpty;
            movies = movies == null
                ? moviesEntity
                : MoviesEntity(movies: [...movies!.movies, ...moviesEntity.movies]);
            currentPage = event.page;
            emit(GetMoviesLoaded(movies: movies!, hasReachedMax: reachedMax));
          },
        );
        isFetching = false;
      }

      
    });
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