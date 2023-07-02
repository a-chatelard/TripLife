part of 'add_friend_bloc.dart';

enum AddFriendStatus {
  initial,
  pendingSearch,
  successSearch,
  pendingSendInvitation,
  successSendInvitation,
  errorSearch,
  errorSendInvitation
}

extension AddFriendStatusX on AddFriendStatus {
  bool get isInitialized => this == AddFriendStatus.initial;
  bool get isSearchPending => this == AddFriendStatus.pendingSearch;
  bool get isSearchSuccessful => this == AddFriendStatus.successSearch;
  bool get isSendInvitationPending =>
      this == AddFriendStatus.pendingSendInvitation;
  bool get isSendInvitationSuccessful =>
      this == AddFriendStatus.successSendInvitation;
  bool get isSearchFailed => this == AddFriendStatus.errorSearch;
  bool get isSendInvitationFailed =>
      this == AddFriendStatus.errorSendInvitation;
}

class AddFriendState extends Equatable {
  const AddFriendState._(
      {this.status = AddFriendStatus.initial,
      this.errorMessage = "",
      this.addFriendResultsList});

  const AddFriendState.initial() : this._();

  const AddFriendState.successSearch(List<AddFriendResult> addFriendResultsList)
      : this._(
            status: AddFriendStatus.successSearch,
            addFriendResultsList: addFriendResultsList);

  const AddFriendState.pendingSearch()
      : this._(status: AddFriendStatus.pendingSearch);

  const AddFriendState.errorSearch(String errorMessage)
      : this._(status: AddFriendStatus.errorSearch, errorMessage: errorMessage);

  const AddFriendState.pendingSendInvitation()
      : this._(status: AddFriendStatus.pendingSendInvitation);

  const AddFriendState.succesSendInvitation()
      : this._(status: AddFriendStatus.successSendInvitation);

  const AddFriendState.errorSendInvitation(String errorMessage)
      : this._(
            status: AddFriendStatus.errorSendInvitation,
            errorMessage: errorMessage);

  final AddFriendStatus status;
  final String? errorMessage;
  final List<AddFriendResult>? addFriendResultsList;

  @override
  List<Object> get props => [status, errorMessage ?? ""];

  AddFriendState copyWith(
      {List<AddFriendResult>? addFriendResultsList,
      AddFriendStatus? status,
      String? errorMessage}) {
    return AddFriendState._(
        addFriendResultsList: addFriendResultsList ?? this.addFriendResultsList,
        status: status ?? this.status,
        errorMessage: this.errorMessage ?? errorMessage);
  }
}
