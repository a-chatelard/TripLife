part of 'add_vacationers_bloc.dart';

enum AddVacationersStatus {
  initial,
  loadingList,
  pendingSendInvitation,
  successSendInvitation,
  successLoadingList,
  errorLoadingList,
  errorSendInvitation
}

extension AddVacationersStatusX on AddVacationersStatus {
  bool get isLoadingList => this == AddVacationersStatus.loadingList;
  bool get isLoadingListSuccessful =>
      this == AddVacationersStatus.successLoadingList;
  bool get isSendInvitationPending =>
      this == AddVacationersStatus.pendingSendInvitation;
  bool get isSendInvitationSuccessful =>
      this == AddVacationersStatus.successSendInvitation;
  bool get isLoadingListFailed => this == AddVacationersStatus.errorLoadingList;
  bool get isSendInvitationFailed =>
      this == AddVacationersStatus.errorSendInvitation;
}

class AddVacationersState extends Equatable {
  AddVacationersState._(
      {this.status = AddVacationersStatus.initial,
      this.errorMessage = "",
      this.vacationId = "",
      this.addVacationerResultsList});

  AddVacationersState.initial() : this._();

  AddVacationersState.loadingList(String vacationId)
      : this._(
            status: AddVacationersStatus.loadingList, vacationId: vacationId);

  AddVacationersState.pendingSendInvitation()
      : this._(status: AddVacationersStatus.pendingSendInvitation);

  AddVacationersState.succesSendInvitation()
      : this._(status: AddVacationersStatus.successSendInvitation);

  AddVacationersState.successLoadingList(
      List<AddVacationerResult> addVacationerResultsList)
      : this._(
            status: AddVacationersStatus.successLoadingList,
            addVacationerResultsList: addVacationerResultsList);

  AddVacationersState.errorSendInvitation(String errorMessage)
      : this._(
            status: AddVacationersStatus.errorSendInvitation,
            errorMessage: errorMessage);

  AddVacationersState.errorLoadingList(String errorMessage)
      : this._(
            status: AddVacationersStatus.errorLoadingList,
            errorMessage: errorMessage);

  late String vacationId;
  final AddVacationersStatus status;
  final String? errorMessage;
  final List<AddVacationerResult>? addVacationerResultsList;

  @override
  List<Object> get props => [status, errorMessage ?? ""];

  AddVacationersState copyWith(
      {List<AddVacationerResult>? addVacationerResultsList,
      AddVacationersStatus? status,
      String? errorMessage}) {
    return AddVacationersState._(
        addVacationerResultsList:
            addVacationerResultsList ?? this.addVacationerResultsList,
        status: status ?? this.status,
        errorMessage: this.errorMessage ?? errorMessage);
  }
}
