import 'package:equatable/equatable.dart';

class AddFriendResult extends Equatable {
  const AddFriendResult(
      this.id, this.username, this.isFriend, this.hasReceivedFriendRequest);

  final String id;
  final String username;
  final bool isFriend;
  final bool hasReceivedFriendRequest;

  @override
  List<Object?> get props => [id, username, isFriend, hasReceivedFriendRequest];
}
