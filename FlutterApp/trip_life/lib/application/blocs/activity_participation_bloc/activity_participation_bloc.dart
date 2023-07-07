import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';

part 'activity_participation_event.dart';
part 'activity_participation_state.dart';

class ActivityParticipationBloc
    extends Bloc<ActivityParticipationEvent, ActivityParticipationState> {
  ActivityParticipationBloc(
      {required AbstractVacationRepository vacationRepository})
      : _vacationRepository = vacationRepository,
        super(const ActivityParticipationState.initial()) {
    on<ActivityParticipationRequest>(_onActivityParticipationRequest);
    on<AddParticipationRequest>(_onAddParticipationRequest);
    on<RemoveParticipationRequest>(_onRemoveParticipationRequest);
  }

  final AbstractVacationRepository _vacationRepository;

  Future<void> _onActivityParticipationRequest(
      ActivityParticipationRequest event,
      Emitter<ActivityParticipationState> emit) async {
    emit(const ActivityParticipationState.loadingState());

    try {
      // Add Endpoint to get current user participation
    } catch (error) {
      return emit(
          ActivityParticipationState.loadingStateError(error.toString()));
    }
  }

  Future<void> _onAddParticipationRequest(AddParticipationRequest event,
      Emitter<ActivityParticipationState> emit) async {
    emit(const ActivityParticipationState.changeState());

    try {
      if (await _vacationRepository.addActivityParticipation(
          event.vacationId, event.activityId)) {
        emit(const ActivityParticipationState.changeStateSuccess(true));
      }
    } catch (error) {
      return emit(
          ActivityParticipationState.changeStateError(error.toString()));
    }
  }

  Future<void> _onRemoveParticipationRequest(RemoveParticipationRequest event,
      Emitter<ActivityParticipationState> emit) async {
    emit(const ActivityParticipationState.changeState());

    try {
      if (await _vacationRepository.removeActivityParticipation(
          event.vacationId, event.activityId)) {
        emit(const ActivityParticipationState.changeStateSuccess(false));
      }
    } catch (error) {
      return emit(
          ActivityParticipationState.changeStateError(error.toString()));
    }
  }
}
