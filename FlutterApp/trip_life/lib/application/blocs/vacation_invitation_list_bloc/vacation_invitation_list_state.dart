part of 'vacation_invitation_list_bloc.dart';

enum VacationInvitationListStatus {
  listLoading,
  loadingListSuccess,
  loadingListerror,
  answerInvitationLoading,
  answerInvitationSuccess,
  answerInvitationError
}

extension VacationInvitationListStatusX on VacationInvitationListStatus {
  bool get isListLoading => this == VacationInvitationListStatus.listLoading;
  bool get isLoadingListSuccessful =>
      this == VacationInvitationListStatus.loadingListSuccess;
  bool get isLoadingListFailed =>
      this == VacationInvitationListStatus.loadingListerror;
  bool get isAnswerInvitationLoading =>
      this == VacationInvitationListStatus.answerInvitationLoading;
  bool get isAnswerInvitationSuccessful =>
      this == VacationInvitationListStatus.answerInvitationSuccess;
  bool get isAnswerInvitationFailed =>
      this == VacationInvitationListStatus.answerInvitationError;
}

class VacationInvitationListState extends Equatable {
  const VacationInvitationListState._(
      {this.status = VacationInvitationListStatus.listLoading,
      this.errorMessage = "",
      this.vacationInvitationList});

  const VacationInvitationListState.listLoading() : this._();

  const VacationInvitationListState.loadingListSuccess(
      List<VacationInvitation> vacationInvitationList)
      : this._(
            status: VacationInvitationListStatus.loadingListSuccess,
            vacationInvitationList: vacationInvitationList);

  const VacationInvitationListState.loadingListerror(String errorMessage)
      : this._(
            status: VacationInvitationListStatus.loadingListerror,
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
