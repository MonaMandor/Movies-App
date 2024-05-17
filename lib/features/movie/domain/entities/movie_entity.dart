// features/home/domain/entities/movie_entity.dart
// ignore_for_file: prefer_const_constructors_in_immutables// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MovieEntity extends Equatable {
  final String title;
  final String overview;
  final String posterPath;
  final String backdroPath;
  final double voteAverage;
  int id;

  MovieEntity({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdroPath,
    required this.voteAverage,
    required this.id,
  });

  @override
  List<Object?> get props =>
      [title, overview, posterPath, backdroPath, voteAverage, id];
}
