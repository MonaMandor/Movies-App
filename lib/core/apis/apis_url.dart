// core/apis/apis_url.dart
class ApiUrl {
  static const String BASE_URL = "https://api.themoviedb.org/3";
  static const String createToken = "$BASE_URL/authentication/token/new";
  static const String createSession = "$BASE_URL/authentication/session/new";
  static const String validateToken = "$BASE_URL/authentication/token/validate_with_login";
  static const String nowPlayingMovies="/movie/now_playing";
  static const String popularMovies="/movie/popular";
  static const String topRatedMovies="/movie/top_rated";
  static const String upcomingMovies="/movie/upcoming";
  static const String getAccountId="$BASE_URL/account";
}
