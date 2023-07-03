import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/entity/models/address.dart';

part 'add_activity_event.dart';
part 'add_activity_state.dart';

class AddActivityBloc extends Bloc<AddActivityEvent, AddActivityState> {
  AddActivityBloc({required AbstractVacationRepository vacationRepository})
      : _vacationRepository = vacationRepository,
        super(const AddActivityState.initial()) {
    on<AddActivityRequest>(_onAddActivity);
  }

  final AbstractVacationRepository _vacationRepository;

  Future<void> _onAddActivity(
      AddActivityRequest event, Emitter<AddActivityState> emit) async {
    emit(const AddActivityState.loading());

    try {
      if (await _vacationRepository.createActivity(
          event.vacationId,
          event.label,
          event.description,
          event.startDate,
          event.endDate,
          event.estimatedPrice,
          event.address)) {
        return emit(const AddActivityState.succes());
      }
    } catch (error) {
      return emit(AddActivityState.error(error.toString()));
    }
  }
}
