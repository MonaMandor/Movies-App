// features/movie/data/datasources/movie_remote_dara_source.dart
import '../../domain/entities/get_wish_paramater.dart';import '../../domain/entities/get_wish_paramater.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
// features/movie/data/datasources/movie_remote_dara_source.dart
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:movie/core/apis/apis_url.dart';
import 'package:movie/core/errors/exception.dart';
import 'package:movie/features/movie/data/models/add_to_watch_list_model.dart';

abstract class MovieRemoteDataSource {
  Future<Unit> addOrDeletToWatchList(AddDeletToWatchListModel addOrDeletToWatchListModel);
  Future<Map<String, dynamic>> getWitchListMovies(
      int page, GetoWatchListParams params);
  Future<Map<String, dynamic>> getNowMovies(int page, String moviesType);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  final String apiKey = '31521ab741626851b73c684539c33b5a';
 
  MovieRemoteDataSourceImpl({
    required this.client,
    
  });
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
      };

  @override
  Future<Unit> addOrDeletToWatchList(
      AddDeletToWatchListModel addOrDeletToWatchListModel) async {
    final body = {
      "media_type": "movie",
      "media_id": addOrDeletToWatchListModel.movieId,
      "watchlist": addOrDeletToWatchListModel.isAdd,
    };

    final response = await client.post(
      Uri.parse(
          '${ApiUrl.BASE_URL}/account/${addOrDeletToWatchListModel.accountId}/watchlist?api_key=$apiKey&session_id=${addOrDeletToWatchListModel.sessionId}'),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getWitchListMovies(
      int page, GetoWatchListParams params) async {
    final response = await client.get(
      Uri.parse(
        '${ApiUrl.BASE_URL}/account/${params.accountId}/watchlist/movies?api_key=$apiKey&session_id=${params.sessionId}&page=$page',
      ),
    );
    print(response.request?.url.path);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> getNowMovies(int page, String movieType) async {
    final String url =
        '${ApiUrl.BASE_URL}$movieType?api_key=$apiKey&language=en-US&page=$page';
    print('Fetching movies from URL: $url'); // Add this line for debugging
    final response = await client.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      // prin
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}
