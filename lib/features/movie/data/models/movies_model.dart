// features/movie/data/models/movies_model.dart
import 'package:movie/features/movie/data/models/movie_model.dart';
import 'package:movie/features/movie/domain/entities/movies_entity.dart';

class MoviesModel extends MoviesEntity {
  MoviesModel({
    required List<MovieModel> movies,
  }) : super(movies: movies);

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    var moviesList = (json['results'] as List)
        .map((movie) => MovieModel.fromJson(movie))
        .toList();

    return MoviesModel(
      movies: moviesList,
    );
  }
}
