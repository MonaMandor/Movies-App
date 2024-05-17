import 'package:equatable/equatable.dart';

class GetoWatchListParams extends Equatable {
  final String sessionId;
  final int accountId;

  const GetoWatchListParams(
      {required this.sessionId, required this.accountId, d});

  @override
  List<Object?> get props => [sessionId, accountId];
}
