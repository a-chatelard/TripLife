part of 'friend_invitation_list_bloc.dart';

enum FriendInvitationListStatus { loading, success, error }

extension FriendInvitationListStatusX on FriendInvitationListStatus {
  bool get isLoading => this == FriendInvitationListStatus.loading;
  bool get isSuccessful => this == FriendInvitationListStatus.success;
  bool get isFailed => this == FriendInvitationListStatus.error;
}

class FriendInvitationListState extends Equatable {
  const FriendInvitationListState._(
      {this.status = FriendInvitationListStatus.loading,
      this.errorMessage = "",
      this.friendInvitationReceivedList,
      this.friendInvitationSentList});

  const FriendInvitationListState.loading() : this._();

  const FriendInvitationListState.succes(
      List<FriendInvitationReceived> friendInvitationReceivedList,
      List<FriendInvitationSent> friendInvitationSentList)
      : this._(
            status: FriendInvitationListStatus.success,
            friendInvitationReceivedList: friendInvitationReceivedList,
            friendInvitationSentList: friendInvitationSentList);

  const FriendInvitationListState.error(String errorMessage)
      : this._(
            status: FriendInvitationListStatus.error,
            errorMessage: errorMessage);

  final FriendInvitationListStatus status;
  final List<FriendInvitationReceived>? friendInvitationReceivedList;
  final List<FriendInvitationSent>? friendInvitationSentList;
  final String? errorMessage;

  @override
  List<Object> get props => [status, errorMessage ?? ""];

  FriendInvitationListState copyWith(
      {List<FriendInvitationReceived>? friendInvitationReceivedList,
      List<FriendInvitationSent>? friendInvitationSentList,
      FriendInvitationListStatus? status,
      String? errorMessage}) {
    return FriendInvitationListState._(
        friendInvitationReceivedList:
            friendInvitationReceivedList ?? this.friendInvitationReceivedList,
        friendInvitationSentList:
            friendInvitationSentList ?? this.friendInvitationSentList,
        status: status ?? this.status,
        errorMessage: this.errorMessage ?? errorMessage);
  }
}
