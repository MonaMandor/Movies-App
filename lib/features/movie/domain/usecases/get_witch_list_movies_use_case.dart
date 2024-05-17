// features/movie/domain/usecases/get_witch_list_movies_use_case.dart
import '../entities/get_wish_paramater.dart';import '../entities/get_wish_paramater.dart';
// features/movie/domain/usecases/get_witch_list_movies_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/movie/domain/entities/movies_entity.dart';
import 'package:movie/features/movie/domain/repositories/movie_repository.dart';

class GetWitchListMoviesUseCase {
  final MovieRepository _movieRepository;

  GetWitchListMoviesUseCase(this._movieRepository);

  Future<Either<Failure, MoviesEntity>> call(int page,GetoWatchListParams params) async {
    return await _movieRepository.getWitchListMovies(page,params);
  }
}