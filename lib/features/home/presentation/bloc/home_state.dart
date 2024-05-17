// features/home/presentation/bloc/home_state.dart
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();  

  @override
  List<Object> get props => [];
}
class HomeInitial extends HomeState {}
