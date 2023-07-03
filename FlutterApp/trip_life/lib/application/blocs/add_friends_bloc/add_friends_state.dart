part of 'add_friends_bloc.dart';

enum AddFriendsStatus {
  initial,
  pendingSearch,
  successSearch,
  pendingSendInvitation,
  successSendInvitation,
  errorSearch,
  errorSendInvitation
}

extension AddFriendsStatusX on AddFriendsStatus {
  bool get isInitialized => this == AddFriendsStatus.initial;
  bool get isSearchPending => this == AddFriendsStatus.pendingSearch;
  bool get isSearchSuccessful => this == AddFriendsStatus.successSearch;
  bool get isSendInvitationPending =>
      this == AddFriendsStatus.pendingSendInvitation;
  bool get isSendInvitationSuccessful =>
      this == AddFriendsStatus.successSendInvitation;
  bool get isSearchFailed => this == AddFriendsStatus.errorSearch;
  bool get isSendInvitationFailed =>
      this == AddFriendsStatus.errorSendInvitation;
}

class AddFriendsState extends Equatable {
  const AddFriendsState._(
      {this.status = AddFriendsStatus.initial,
      this.errorMessage = "",
      this.addFriendResultsList});

  const AddFriendsState.initial() : this._();

  const AddFriendsState.successSearch(
      List<AddFriendResult> addFriendResultsList)
      : this._(
            status: AddFriendsStatus.successSearch,
            addFriendResultsList: addFriendResultsList);

  const AddFriendsState.pendingSearch()
      : this._(status: AddFriendsStatus.pendingSearch);

  const AddFriendsState.errorSearch(String errorMessage)
      : this._(
            status: AddFriendsStatus.errorSearch, errorMessage: errorMessage);

  const AddFriendsState.pendingSendInvitation()
      : this._(status: AddFriendsStatus.pendingSendInvitation);

  const AddFriendsState.succesSendInvitation()
      : this._(status: AddFriendsStatus.successSendInvitation);

  const AddFriendsState.errorSendInvitation(String errorMessage)
      : this._(
            status: AddFriendsStatus.errorSendInvitation,
            errorMessage: errorMessage);

  final AddFriendsStatus status;
  final String? errorMessage;
  final List<AddFriendResult>? addFriendResultsList;

  @override
  List<Object> get props => [status, errorMessage ?? ""];

  AddFriendsState copyWith(
      {List<AddFriendResult>? addFriendResultsList,
      AddFriendsStatus? status,
      String? errorMessage}) {
    return AddFriendsState._(
        addFriendResultsList: addFriendResultsList ?? this.addFriendResultsList,
        status: status ?? this.status,
        errorMessage: this.errorMessage ?? errorMessage);
  }
}
