// features/movie/data/models/add_to_watch_list_model.dart
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';

class AddDeletToWatchListModel extends AddDetetToWatchListParams {
  const AddDeletToWatchListModel({
    required super.movieId,
    required super.sessionId,
    required super.accountId,
    required super.isAdd,
  });
 

  factory AddDeletToWatchListModel.fromJson(Map<String, dynamic> json) {
    return AddDeletToWatchListModel(
      movieId: json['movie_id'],
      sessionId: json['session_id'],
      accountId: json['account_id'],
      isAdd: json['watchlist'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movie_id': movieId,
      'session_id': sessionId,
      'account_id': accountId,
      'watchlist': isAdd,
    };
  }
}