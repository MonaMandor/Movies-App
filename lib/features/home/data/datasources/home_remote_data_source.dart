// features/home/data/datasources/home_remote_data_source.dart

import 'package:http/http.dart' as http;


abstract class HomeRemoteDataSource {
 
}class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;
  final String apiKey = '31521ab741626851b73c684539c33b5a';

  HomeRemoteDataSourceImpl({required this.client});


}
