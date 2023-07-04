import 'package:equatable/equatable.dart';

class FriendInvitationReceived extends Equatable {
  const FriendInvitationReceived(this.requestId, this.username);

  final String requestId;
  final String username;

  @override
  List<Object?> get props => [requestId, username];

  static fromJson(Map<String, dynamic> json) {
    return FriendInvitationReceived(json['requestId'], json['username']);
  }
}
