part of 'vacation_list_bloc.dart';

enum VacationListStatus { loading, success, error }

extension VacationListStatusX on VacationListStatus {
  bool get isLoading => this == VacationListStatus.loading;
  bool get isSuccessful => this == VacationListStatus.success;
  bool get isFailed => this == VacationListStatus.error;
}

class VacationListState extends Equatable {
  const VacationListState._(
      {this.status = VacationListStatus.loading,
      this.errorMessage = "",
      this.vacationList});

  const VacationListState.loading() : this._();

  const VacationListState.succes(List<Vacation> vacationList)
      : this._(status: VacationListStatus.success, vacationList: vacationList);

  const VacationListState.error(String errorMessage)
      : this._(status: VacationListStatus.error, errorMessage: errorMessage);

  final VacationListStatus status;
  final List<Vacation>? vacationList;
  final String? errorMessage;

  @override
  List<Object> get props => [status, errorMessage ?? ""];
}
