// features/home/data/repositories/home_repository_impl.dart
import 'package:movie/core/network/network_info.dart';
import 'package:movie/features/home/data/datasources/home_remote_data_source.dart';
import 'package:movie/features/home/domain/repositories/home_repository.dart';
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({required this.remoteDataSource, required this.networkInfo});


}
