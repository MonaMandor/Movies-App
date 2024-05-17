// features/auth/data/datasources/auth_remote_data_source.dart
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:movie/core/apis/apis_url.dart';
import 'package:movie/core/errors/exception.dart';
import 'package:movie/features/auth/data/models/create_session_model.dart';
import 'package:movie/features/auth/data/models/session_model.dart';
import 'package:movie/features/auth/data/models/validate_token_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> createToken();
  Future<Map<String, dynamic>> createSession(
      CreateSessionModel createSessionModel);
  Future<Unit> validateToken(VlidateTokenModel validateTokenModel);
  Future<int> getAccountId(SessionModel sessionModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String apiKey = '31521ab741626851b73c684539c33b5a';
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
      };
  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<String> createToken() async {
    final response = await client.get(
      Uri.parse('${ApiUrl.createToken}?api_key=$apiKey'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['request_token'];
    }
    if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> createSession(
      CreateSessionModel createSessionModel) async {
    final body = createSessionModel.toJson();

    final response = await client.post(
      Uri.parse('${ApiUrl.createSession}?api_key=$apiKey'),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
  
      return jsonResponse;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> validateToken(VlidateTokenModel validateTokenModel) async {
    final body = validateTokenModel.toJson();

    final response = await client.post(
      Uri.parse('${ApiUrl.validateToken}?api_key=$apiKey'),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return unit;
    }
    if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<int> getAccountId(SessionModel sessionModel) async {
    final response = await client.get(
      Uri.parse(
          '${ApiUrl.getAccountId}?api_key=$apiKey&session_id=${sessionModel.sessionId}'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['id'];
    }
    if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}
