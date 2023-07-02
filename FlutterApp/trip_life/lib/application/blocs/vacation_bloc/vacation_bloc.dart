import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/entity/models/vacation_details.dart';

part 'vacation_event.dart';
part 'vacation_state.dart';

class VacationBloc extends Bloc<VacationEvent, VacationState> {
  VacationBloc({required AbstractVacationRepository vacationRepository})
      : _vacationRepository = vacationRepository,
        super(const VacationState.loading()) {
    on<VacationRequest>(_onVacationRequest);
  }

  final AbstractVacationRepository _vacationRepository;

  Future<void> _onVacationRequest(
      VacationRequest event, Emitter<VacationState> emit) async {
    emit(const VacationState.loading());
    try {
      VacationDetails vacation =
          await _vacationRepository.getVacation(event.vacationId);
      return emit(VacationState.succes(vacation));
    } catch (error) {
      return emit(const VacationState.error(
          "Une erreur est survenue lors de la récupération des données."));
    }
  }
}
