// features/movie/data/repositories/movie_repository_impl.dart
import '../../domain/entities/get_wish_paramater.dart';import '../../domain/entities/get_wish_paramater.dart';
// features/movie/data/repositories/movie_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:movie/core/errors/exception.dart';
import 'package:movie/core/errors/failurs.dart';
import 'package:movie/core/network/network_info.dart';
import 'package:movie/features/movie/data/models/movies_model.dart';
import 'package:movie/features/movie/domain/entities/movies_entity.dart';
import 'package:movie/features/movie/data/datasources/movie_remote_dara_source.dart';
import 'package:movie/features/movie/data/models/add_to_watch_list_model.dart';
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';
import 'package:movie/features/movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  
  
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
   
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Unit>>> addOrDeletToWatchList(AddDetetToWatchListParams params)async {
    final AddDeletToWatchListModel addToWatchListModel = AddDeletToWatchListModel(
      movieId: params.movieId,
      sessionId: params.sessionId,
      accountId: params.accountId,
      isAdd: params.isAdd,
    );
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addOrDeletToWatchList(addToWatchListModel);
        return const Right([unit]);
      } on ServerException {
        return Left(ServerFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on NotFoundException {
        return Left(NotFoundFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MoviesEntity>> getWitchListMovies(int page, GetoWatchListParams params)async {
   
    if (await networkInfo.isConnected) {
      try {
        final moviesData = await remoteDataSource.getWitchListMovies(page, params);
       final movies = MoviesModel.fromJson(moviesData);
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure());
      } on NotFoundException {
        return Left(NotFoundFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  
  }



  @override
  Future<Either<Failure, MoviesEntity>> getMovies(int page,String moviesType) async {
    if (await networkInfo.isConnected) {
      try {
        final moviesData = await remoteDataSource.getNowMovies(page, moviesType);
        final movies = MoviesModel.fromJson(moviesData);
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure());
      } on NotFoundException {
        return Left(NotFoundFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
  


  
}