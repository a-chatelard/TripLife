part of 'add_activity_bloc.dart';

enum AddActivityStatus { initial, loading, success, error }

extension AddFriendStatusX on AddActivityStatus {
  bool get isInitialized => this == AddActivityStatus.initial;
  bool get isLoading => this == AddActivityStatus.loading;
  bool get isSuccessful => this == AddActivityStatus.success;
  bool get isFailed => this == AddActivityStatus.error;
}

class AddActivityState extends Equatable {
  const AddActivityState._(
      {this.status = AddActivityStatus.initial, this.errorMessage = ""});

  const AddActivityState.initial() : this._();

  const AddActivityState.succes() : this._(status: AddActivityStatus.success);

  const AddActivityState.loading() : this._(status: AddActivityStatus.loading);

  const AddActivityState.error(String errorMessage)
      : this._(status: AddActivityStatus.error, errorMessage: errorMessage);

  final AddActivityStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage ?? ""];
}
