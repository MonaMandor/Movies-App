// features/movie/domain/usecases/add_to_watchList_use_case.dart
import 'package:dartz/dartz.dart';import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';
import 'package:movie/features/movie/domain/repositories/movie_repository.dart';

class AddToWatchListUseCase {
  final MovieRepository repository;

  AddToWatchListUseCase(this.repository);

  Future<Either<Failure, List<Unit>>> call(AddDetetToWatchListParams params) async {
    return repository.addToWatchList(params);
  }
}
