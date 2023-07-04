part of 'vacation_invitation_list_bloc.dart';

enum VacationInvitationListStatus { loading, success, error }

extension VacationInvitationListStatusX on VacationInvitationListStatus {
  bool get isLoading => this == VacationInvitationListStatus.loading;
  bool get isSuccessful => this == VacationInvitationListStatus.success;
  bool get isFailed => this == VacationInvitationListStatus.error;
}

class VacationInvitationListState extends Equatable {
  const VacationInvitationListState._(
      {this.status = VacationInvitationListStatus.loading,
      this.errorMessage = "",
      this.vacationInvitationList});

  const VacationInvitationListState.loading() : this._();

  const VacationInvitationListState.succes(
      List<VacationInvitation> vacationInvitationList)
      : this._(
            status: VacationInvitationListStatus.success,
            vacationInvitationList: vacationInvitationList);

  const VacationInvitationListState.error(String errorMessage)
      : this._(
            status: VacationInvitationListStatus.error,
            errorMessage: errorMessage);

  final VacationInvitationListStatus status;
  final List<VacationInvitation>? vacationInvitationList;
  final String? errorMessage;

  @override
  List<Object> get props => [status, errorMessage ?? ""];

  VacationInvitationListState copyWith(
      {List<VacationInvitation>? vacationInvitationList,
      VacationInvitationListStatus? status,
      String? errorMessage}) {
    return VacationInvitationListState._(
        vacationInvitationList:
            vacationInvitationList ?? this.vacationInvitationList,
        status: status ?? this.status,
        errorMessage: this.errorMessage ?? errorMessage);
  }
}
