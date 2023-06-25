import 'package:equatable/equatable.dart';

class ReceivedFriendRequest extends Equatable {
  const ReceivedFriendRequest(this.requestId, this.username);

  final String requestId;
  final String username;

  @override
  List<Object?> get props => [requestId, username];

  static fromJson(Map<String, dynamic> json) {
    return ReceivedFriendRequest(json['requestId'], json['username']);
  }
}
