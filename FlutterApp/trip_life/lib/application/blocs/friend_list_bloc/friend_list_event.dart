part of 'friend_list_bloc.dart';

abstract class FriendListEvent {
  const FriendListEvent();
}

class FriendListRequest implements FriendListEvent {}
