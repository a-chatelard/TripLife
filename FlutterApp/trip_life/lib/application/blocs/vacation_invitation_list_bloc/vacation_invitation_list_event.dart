part of 'vacation_invitation_list_bloc.dart';

abstract class VacationInvitationListEvent {
  const VacationInvitationListEvent();
}

class VacationInvitationListRequest implements VacationInvitationListEvent {}

class AnswerVacationInvitationRequest implements VacationInvitationListEvent {
  AnswerVacationInvitationRequest(
      this.vacationId, this.vacationerId, this.response);

  final String vacationId;
  final String vacationerId;
  final bool response;
}
