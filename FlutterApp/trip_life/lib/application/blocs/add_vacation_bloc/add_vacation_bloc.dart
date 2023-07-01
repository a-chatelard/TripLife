import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/entity/models/address.dart';

part 'add_vacation_event.dart';
part 'add_vacation_state.dart';

class AddVacationBloc extends Bloc<AddVacationEvent, AddVacationState> {
  AddVacationBloc({required AbstractVacationRepository vacationRepository})
      : _vacationRepository = vacationRepository,
        super(const AddVacationState.initial()) {
    on<AddVacationRequest>(_onAddVacation);
  }

  final AbstractVacationRepository _vacationRepository;

  Future<void> _onAddVacation(
      AddVacationRequest event, Emitter<AddVacationState> emit) async {
    emit(const AddVacationState.loading());

    try {
      if (await _vacationRepository.createVacation(event.label, event.startDate,
          event.endDate, event.address, event.estimatedBudget)) {
        return emit(const AddVacationState.succes());
      }
    } catch (error) {
      return emit(AddVacationState.error(error.toString()));
    }
  }
}
