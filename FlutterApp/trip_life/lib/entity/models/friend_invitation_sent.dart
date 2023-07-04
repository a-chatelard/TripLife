import 'package:equatable/equatable.dart';

class FriendInvitationSent extends Equatable {
  const FriendInvitationSent(this.requestId, this.username);

  final String requestId;
  final String username;

  @override
  List<Object?> get props => [requestId, username];

  static fromJson(Map<String, dynamic> json) {
    return FriendInvitationSent(json['requestId'], json['username']);
  }
}
