part of 'add_vacation_bloc.dart';

enum AddVacationStatus { initial, loading, success, error }

extension AddFriendStatusX on AddVacationStatus {
  bool get isInitialized => this == AddVacationStatus.initial;
  bool get isLoading => this == AddVacationStatus.loading;
  bool get isSuccessful => this == AddVacationStatus.success;
  bool get isFailed => this == AddVacationStatus.error;
}

class AddVacationState extends Equatable {
  const AddVacationState._(
      {this.status = AddVacationStatus.initial, this.errorMessage = ""});

  const AddVacationState.initial() : this._();

  const AddVacationState.succes() : this._(status: AddVacationStatus.success);

  const AddVacationState.loading() : this._(status: AddVacationStatus.loading);

  const AddVacationState.error(String errorMessage)
      : this._(status: AddVacationStatus.error, errorMessage: errorMessage);

  final AddVacationStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage ?? ""];
}
