import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/entity/models/vacation_invitation.dart';

part 'vacation_invitation_list_event.dart';
part 'vacation_invitation_list_state.dart';

class VacationInvitationListBloc
    extends Bloc<VacationInvitationListEvent, VacationInvitationListState> {
  VacationInvitationListBloc(
      {required AbstractVacationRepository vacationRepository})
      : _vacationRepository = vacationRepository,
        super(const VacationInvitationListState.loading()) {
    on<VacationInvitationListRequest>(_onFriendListRequest);
    on<AnswerVacationInvitationRequest>(_onAnswerInvitationRequest);
  }

  final AbstractVacationRepository _vacationRepository;

  Future<void> _onFriendListRequest(VacationInvitationListEvent event,
      Emitter<VacationInvitationListState> emit) async {
    emit(const VacationInvitationListState.loading());
    try {
      // List<VacationInvitation> vacationInvitationList =
      //     await _vacationRepository.getPendingVacationInvitationsList(event.);
      //emit(VacationInvitationListState.succes(vacationInvitationList));
    } catch (error) {
      emit(const VacationInvitationListState.error(
          "Une erreur est survenue lors de la récupération des données."));
    }
  }

  Future<void> _onAnswerInvitationRequest(AnswerVacationInvitationRequest event,
      Emitter<VacationInvitationListState> emit) async {
    try {
      if (event.response) {
        if (await _vacationRepository.acceptVacationInvitation(
            event.vacationId, event.vacationerId)) {
          //remove element from list
          emit(state);
        }
      } else {
        if (await _vacationRepository.declineVacationInvitation(
            event.vacationId, event.vacationerId)) {
          //remove element from list
          emit(state);
        }
      }
    } catch (error) {
      return emit(VacationInvitationListState.error(error.toString()));
    }
  }
}
