// features/home/presentation/bloc/home_event.dart
// ignore_for_file: prefer_const_constructors_in_immutables// ignore_for_file: prefer_const_constructors_in_immutables

part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMoviesEvent extends HomeEvent {
  final int page;

  GetNowPlayingMoviesEvent({required this.page});

  @override
  List<Object> get props => [page];
}
