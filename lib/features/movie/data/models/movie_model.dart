// features/movie/data/models/movie_model.dart
import 'package:movie/features/movie/domain/entities/movie_entity.dart';import 'package:movie/features/movie/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.title,
    required super.overview,
    required this.posterPath,
    required super.backdroPath,
    required super.voteAverage,
    required super.id,

  }) : super( posterPath: posterPath) ;

  @override
  final String posterPath;

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'],
      posterPath: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500${json['poster_path']}"
          : "",
          backdroPath: json['backdrop_path'] != null? "https://image.tmdb.org/t/p/w500${json['backdrop_path']}"
          : "",
         
      overview: json['overview'],
      voteAverage: json['vote_average'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
      'vote_average': voteAverage,
      'backdrop_path': backdroPath,
      'id': id,


    };
  }
}
