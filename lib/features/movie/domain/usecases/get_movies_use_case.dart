// features/movie/domain/usecases/get_movies_use_case.dart
import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/movie/domain/entities/movies_entity.dart';
import 'package:movie/features/movie/domain/repositories/movie_repository.dart';

class GetMoviesUseCase {
  final MovieRepository _repository;

  GetMoviesUseCase(this._repository);

    Future<Either<Failure, MoviesEntity>> call(int page,String moviesType) async {
    return await _repository.getMovies( page, moviesType);
  }
}