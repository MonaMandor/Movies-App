// features/movie/domain/entities/movies_entity.dart
// ignore_for_file: prefer_const_constructors_in_immutables// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:movie/features/movie/domain/entities/movie_entity.dart';

class MoviesEntity extends Equatable {
  final List<MovieEntity> movies;

  MoviesEntity({
    required this.movies,
  });

  @override
  List<Object?> get props => [movies];
}
