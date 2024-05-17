// features/movie/domain/entities/add_delet_to_watch_list_params.dart
import 'package:equatable/equatable.dart';


class AddDetetToWatchListParams extends Equatable {
  final int movieId;
  final String sessionId;
  final int accountId;
  final bool isAdd;

  const AddDetetToWatchListParams(
      {required this.movieId,
      required this.sessionId,
      required this.accountId,
      required this.isAdd});

  @override
  List<Object?> get props => [movieId, sessionId, accountId];
}
