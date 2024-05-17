// features/movie/domain/repositories/movie_repository.dart
import '../entities/get_wish_paramater.dart';
// features/movie/domain/repositories/movie_repository.dart
import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/movie/domain/entities/movies_entity.dart';
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Unit>>> addOrDeletToWatchList(AddDetetToWatchListParams params);
  Future<Either<Failure, MoviesEntity>> getWitchListMovies(int page,GetoWatchListParams params);
  Future<Either<Failure, MoviesEntity>> getMovies(int page,String moviesType);
}
