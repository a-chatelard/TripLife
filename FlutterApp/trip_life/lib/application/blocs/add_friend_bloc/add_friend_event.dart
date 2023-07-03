part of 'add_friend_bloc.dart';

abstract class AddFriendEvent {
  const AddFriendEvent();
}

class FriendSearchRequest implements AddFriendEvent {
  final String username;

  FriendSearchRequest(this.username);
}

class AddFriendRequest implements AddFriendEvent {
  final String recepientId;

  AddFriendRequest(this.recepientId);
}
