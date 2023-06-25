import 'package:equatable/equatable.dart';

class SentFriendRequest extends Equatable {
  const SentFriendRequest(this.requestId, this.username);

  final String requestId;
  final String username;

  @override
  List<Object?> get props => [requestId, username];

  static fromJson(Map<String, dynamic> json) {
    return SentFriendRequest(json['requestId'], json['username']);
  }
}
