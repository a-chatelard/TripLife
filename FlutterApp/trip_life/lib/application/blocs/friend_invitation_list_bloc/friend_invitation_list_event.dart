part of 'friend_invitation_list_bloc.dart';

abstract class FriendInvitationListEvent {
  const FriendInvitationListEvent();
}

class FriendInvitationListRequest implements FriendInvitationListEvent {}

class AnswerReceivedInvitationRequest implements FriendInvitationListEvent {
  AnswerReceivedInvitationRequest(this.friendRequestId, this.response);

  final String friendRequestId;
  final bool response;
}

class CancelSentInvitationRequest implements FriendInvitationListEvent {
  CancelSentInvitationRequest(this.friendRequestId);

  final String friendRequestId;
}
