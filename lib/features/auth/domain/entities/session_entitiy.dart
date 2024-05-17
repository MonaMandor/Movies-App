// features/auth/domain/entities/session_entitiy.dart
import 'package:equatable/equatable.dart';
class SessionEntity extends Equatable {
  final String sessionId;


  const SessionEntity({
    required this.sessionId,
    
  });

  @override
  List<Object?> get props => [sessionId, ];
}
