// features/movie/presentation/bloc/movie_bloc.dart

// features/movie/presentation/bloc/movie_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/core/constansts/strings/messages.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';
import 'package:movie/features/movie/domain/entities/get_wish_paramater.dart';
import 'package:movie/features/movie/domain/entities/movies_entity.dart';
import 'package:movie/features/movie/domain/usecases/add_to_watchList_use_case.dart';
import 'package:movie/features/movie/domain/usecases/get_movies_use_case.dart';
import 'package:movie/features/movie/domain/usecases/get_witch_list_movies_use_case.dart';
import 'package:movie/features/movie/presentation/controllers/now_playing_pagination.dart';
import 'package:movie/features/movie/presentation/controllers/popular_pagination.dart';
import 'package:movie/features/movie/presentation/controllers/top_rating_pagination.dart';
import 'package:movie/features/movie/presentation/controllers/upComing_pagination.dart';
import 'package:movie/features/movie/presentation/controllers/watching_list_pagination.dart';


part 'movie_event.dart';
part 'movie_state.dart';
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final AddToWatchListUseCase addToWatchListUseCase;
  final GetWitchListMoviesUseCase getWatchListUseCase;
  final GetMoviesUseCase getMoviesUseCase;
  late NowPlayingPagination nowPlayingPagination;
  late PopularPagination popularPagination;
  late WatchingListPagination watchingListPagination;
  late TopRatedPagination topRatedPagination;
  late UpComingPagination upComingPagination;

  MoviesEntity? movies;
  MoviesEntity? watchListMovies;
  int currentPage = 1;
  bool isFetching = false;

  MovieBloc({
    required this.addToWatchListUseCase,
    required this.getWatchListUseCase,
    required this.getMoviesUseCase,
  }) : super(MovieInitial()) {
    nowPlayingPagination = NowPlayingPagination(getMoviesUseCase);
    popularPagination = PopularPagination(getMoviesUseCase);
    watchingListPagination = WatchingListPagination(getWatchListUseCase, addToWatchListUseCase);
    topRatedPagination = TopRatedPagination(getMoviesUseCase);
    upComingPagination = UpComingPagination(getMoviesUseCase);
on<MovieEvent>((event, emit) async {
 
      if (event is AddToWatchListEvent) {
        emit(AddToWatchListLoading());
        final failureOrMovies = await addToWatchListUseCase(event.params);
        failureOrMovies.fold(
          (failure) =>
              emit(AddToWatchListError(message: _mapFailureToMessage(failure))),
          (moviesEntity) {
         
            emit(AddToWatchListSuccess());
          },
        );
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

class UpdateWatchListEvent extends MovieEvent {}

