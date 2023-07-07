part of 'user_profil_bloc.dart';

enum UserProfilStatus { initial, loading, success, error }

extension UserProfilStatusX on UserProfilStatus {
  bool get isInitialized => this == UserProfilStatus.initial;
  bool get isLoading => this == UserProfilStatus.loading;
  bool get isSuccessful => this == UserProfilStatus.success;
  bool get isFailed => this == UserProfilStatus.error;
}

class UserProfilState extends Equatable {
  const UserProfilState._(
      {this.status = UserProfilStatus.initial,
      this.errorMessage = "",
      this.connectedUser});

  const UserProfilState.loading() : this._();

  const UserProfilState.succes(ConnectedUser connectedUser)
      : this._(status: UserProfilStatus.success, connectedUser: connectedUser);

  const UserProfilState.error(String errorMessage)
      : this._(status: UserProfilStatus.error, errorMessage: errorMessage);

  final UserProfilStatus status;
  final ConnectedUser? connectedUser;
  final String? errorMessage;

  @override
  List<Object> get props => [status, errorMessage ?? ""];
}
