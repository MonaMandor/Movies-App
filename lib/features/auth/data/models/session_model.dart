// features/auth/data/models/session_model.dart
import 'package:movie/features/auth/domain/entities/session_entitiy.dart';import 'package:movie/features/auth/domain/entities/session_entitiy.dart';

class SessionModel extends SessionEntity{
   SessionModel({
    required super.sessionId,
  
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
     sessionId: json['session_id'] ?? '',  // Provide a default value
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
  
    };
  }
}