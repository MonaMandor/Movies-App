// features/movie/domain/usecases/get_witch_list_movies_use_case.dart
import 'package:dartz/dartz.dart';import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/movie/domain/entities/movies_entity.dart';
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';
import 'package:movie/features/movie/domain/repositories/movie_repository.dart';

class GetWitchListMoviesUseCase {
  final MovieRepository _movieRepository;

  GetWitchListMoviesUseCase(this._movieRepository);

  Future<Either<Failure, MoviesEntity>> call(int page,AddDetetToWatchListParams params) async {
    return await _movieRepository.getWitchListMovies(page,params);
  }
}