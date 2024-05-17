// features/auth/data/datasources/auth_local_data_source.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getToken();
  Future<void> cacheSessionId(String sessionId);
  Future<String?> getSessionId();
  Future<void> cacheExpired(String expired);
  Future<String?> getExpired();
  Future<void> clearKey(String key);
  Future<void> clearAll();
  Future<void> cachAccountId(int accountId);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String sessionKey = 'sessionId';
  static const String tokenKey = 'token';
  static const String expieredKey = 'expired';
  static const String accountIdKey = 'accountId';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheToken(String token) {
    return sharedPreferences.setString(tokenKey, token);
  }

  @override
  Future<String?> getToken() {
    return Future.value(sharedPreferences.getString(tokenKey));
  }

  @override
  Future<void> cacheSessionId(String sessionId) {
    return sharedPreferences.setString(sessionKey, sessionId);
  }

  @override
  Future<String?> getSessionId() {
    return Future.value(sharedPreferences.getString(sessionKey));
  }

  @override
  Future<void> cacheExpired(String expired) {
    return sharedPreferences.setString(expieredKey, expired);
  }

  @override
  Future<void> clearAll() {
    return sharedPreferences.clear();
  }

  @override
  Future<void> clearKey(String key) {
    return sharedPreferences.remove(key);
  }

  @override
  Future<String?> getExpired() {
    return Future.value(sharedPreferences.getString(expieredKey));
  }

  @override
  Future<void> cachAccountId(int accountId) {
    return sharedPreferences.setInt(accountIdKey, accountId);
  }
}
