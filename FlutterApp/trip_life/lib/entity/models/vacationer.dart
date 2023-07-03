import 'package:equatable/equatable.dart';

class Vacationer extends Equatable {
  const Vacationer(this.vacationerId, this.vacationId, this.userId,
      this.username, this.isOwner);

  final String vacationerId;
  final String vacationId;
  final String userId;
  final String? username;
  final bool isOwner;

  @override
  List<Object?> get props =>
      [vacationerId, vacationId, userId, username, isOwner];

  static fromJson(Map<String, dynamic> json) {
    return Vacationer(json['id'], json['vacationId'], json['userId'],
        json['username'], json['isOwner']);
  }
}
