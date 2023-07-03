import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/entity/models/vacation.dart';

part 'vacation_list_event.dart';
part 'vacation_list_state.dart';

class VacationListBloc extends Bloc<VacationListEvent, VacationListState> {
  VacationListBloc({required AbstractVacationRepository vacationRepository})
      : _vacationRepository = vacationRepository,
        super(const VacationListState.loading()) {
    on<VacationListRequest>(_onVacationListRequest);
  }

  final AbstractVacationRepository _vacationRepository;

  Future<void> _onVacationListRequest(
      VacationListEvent event, Emitter<VacationListState> emit) async {
    emit(const VacationListState.loading());
    try {
      List<Vacation> vacationsList =
          await _vacationRepository.getVacationsList();
      return emit(VacationListState.succes(vacationsList));
    } catch (error) {
      return emit(const VacationListState.error(
          "Une erreur est survenue lors de la récupération des données."));
    }
  }
}
