part of 'friend_invitation_list_bloc.dart';

enum FriendInvitationListStatus {
  listLoading,
  loadingListSuccess,
  loadingListError,
  answerInvitationReceivedLoading,
  answerInvitationReceivedSuccess,
  answerInvitationReceivedError,
  cancelInvitationSentLoading,
  cancelInvitationSentSuccess,
  cancelInvitationSentError,
}

extension FriendInvitationListStatusX on FriendInvitationListStatus {
  bool get isListLoading => this == FriendInvitationListStatus.listLoading;
  bool get isLoadingListSuccessful =>
      this == FriendInvitationListStatus.loadingListSuccess;
  bool get isLoadingListFailed =>
      this == FriendInvitationListStatus.loadingListError;
  bool get isCancelInvitationSentLoading =>
      this == FriendInvitationListStatus.cancelInvitationSentLoading;
  bool get isCancelInvitationSentSuccess =>
      this == FriendInvitationListStatus.cancelInvitationSentSuccess;
  bool get isCancelInvitationSentError =>
      this == FriendInvitationListStatus.cancelInvitationSentError;
  bool get isAnswerInvitationReceivedLoading =>
      this == FriendInvitationListStatus.answerInvitationReceivedLoading;
  bool get isAnswerInvitationReceivedSuccess =>
      this == FriendInvitationListStatus.answerInvitationReceivedSuccess;
  bool get isAnwserInvitationReceivedError =>
      this == FriendInvitationListStatus.answerInvitationReceivedError;
}

class FriendInvitationListState extends Equatable {
  const FriendInvitationListState._(
      {this.status = FriendInvitationListStatus.listLoading,
      this.errorMessage = "",
      this.friendInvitationReceivedList,
      this.friendInvitationSentList});

  const FriendInvitationListState.loading() : this._();

  const FriendInvitationListState.succes(
      List<FriendInvitationReceived> friendInvitationReceivedList,
      List<FriendInvitationSent> friendInvitationSentList)
      : this._(
            status: FriendInvitationListStatus.loadingListSuccess,
            friendInvitationReceivedList: friendInvitationReceivedList,
            friendInvitationSentList: friendInvitationSentList);

  const FriendInvitationListState.error(String errorMessage)
      : this._(
            status: FriendInvitationListStatus.loadingListError,
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
