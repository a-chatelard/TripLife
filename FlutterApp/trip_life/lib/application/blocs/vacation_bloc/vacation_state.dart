part of 'vacation_bloc.dart';

enum VacationStatus { loading, success, error }

extension VacationStatusX on VacationStatus {
  bool get isLoading => this == VacationStatus.loading;
  bool get isSuccessful => this == VacationStatus.success;
  bool get isFailed => this == VacationStatus.error;
}

class VacationState extends Equatable {
  const VacationState._(
      {this.status = VacationStatus.loading,
      this.errorMessage = "",
      this.vacation});

  const VacationState.loading() : this._();

  const VacationState.succes(VacationDetails vacation)
      : this._(status: VacationStatus.success, vacation: vacation);

  const VacationState.error(String errorMessage)
      : this._(status: VacationStatus.error, errorMessage: errorMessage);

  final VacationStatus status;
  final VacationDetails? vacation;
  final String? errorMessage;

  @override
  List<Object> get props => [status, errorMessage ?? ""];
}
