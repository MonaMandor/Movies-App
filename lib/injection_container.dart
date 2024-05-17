// injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:movie/core/network/network_info.dart';
import 'package:movie/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:movie/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:movie/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:movie/features/auth/domain/repositories/auth_repository.dart';
import 'package:movie/features/auth/domain/usecases/check_login_use_case.dart';
import 'package:movie/features/auth/domain/usecases/create_session_use_case.dart';
import 'package:movie/features/auth/domain/usecases/create_token_use_case.dart';
import 'package:movie/features/auth/domain/usecases/get_account_id_use_case.dart';
import 'package:movie/features/auth/domain/usecases/validate_token_use_case.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie/features/home/data/datasources/home_remote_data_source.dart';
import 'package:movie/features/home/data/repositories/home_repository_impl.dart';
import 'package:movie/features/home/domain/repositories/home_repository.dart';
import 'package:movie/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie/features/movie/data/datasources/movie_remote_dara_source.dart';
import 'package:movie/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie/features/movie/domain/usecases/add_to_watchList_use_case.dart';
import 'package:movie/features/movie/domain/usecases/get_movies_use_case.dart';
import 'package:movie/features/movie/domain/usecases/get_witch_list_movies_use_case.dart';
import 'package:movie/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //? Featuers

//! AUthentication

  // Bloc

  sl.registerFactory(() => AuthBloc(
        createSessionUseCase: sl(),
        createTokenUseCase: sl(),
        validateTokenUseCase: sl(),
        checkLoginUseCase: sl(),
        getAccountIdUseCase: sl(),
      ));

  //usecase
  sl.registerLazySingleton(() => CeckLoginUseCase(sl()));
  sl.registerLazySingleton(() => CreateSessionUseCase(sl()));
  sl.registerLazySingleton(() => CreateTokenUseCase(sl()));
  sl.registerLazySingleton(() => ValidateTokenUseCase(sl()));
  sl.registerLazySingleton(() => GetAccountIdUseCase(sl()));
  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  //DataSource

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sl()));

  // home
  // Bloc

  sl.registerFactory(() => HomeBloc(
  
      ));

  //usecase
// Repository
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  //DataSource

  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(client: sl()));

//movie

  // Bloc

  sl.registerFactory(() => MovieBloc(
        addToWatchListUseCase: sl(),
        getWatchListUseCase: sl(),
        getMoviesUseCase: sl(),
      ));
//usecase

  sl.registerLazySingleton(() => AddToWatchListUseCase(sl()));
  sl.registerLazySingleton(() => GetWitchListMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
// Repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  //DataSource

  sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: sl()));

  // *core// *
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  // *External// *

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
