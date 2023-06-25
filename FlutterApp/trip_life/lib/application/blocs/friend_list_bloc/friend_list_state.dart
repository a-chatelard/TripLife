part of 'friend_list_bloc.dart';

enum FriendListStatus { loading, success, error }

extension FriendListStatusX on FriendListStatus {
  bool get isLoading => this == FriendListStatus.loading;
  bool get isSuccessful => this == FriendListStatus.success;
  bool get isFailed => this == FriendListStatus.error;
}

class FriendListState extends Equatable {
  const FriendListState._(
      {this.status = FriendListStatus.loading,
      this.errorMessage = "",
      this.friendList});

  const FriendListState.loading() : this._();

  const FriendListState.succes(List<Friend> friendList)
      : this._(status: FriendListStatus.success, friendList: friendList);

  const FriendListState.error(String errorMessage)
      : this._(status: FriendListStatus.error, errorMessage: errorMessage);

  final FriendListStatus status;
  final List<Friend>? friendList;
  final String? errorMessage;

  @override
  List<Object> get props => [status, errorMessage ?? ""];
}
