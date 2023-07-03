import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/entity/models/add_vacationer_result.dart';
import 'package:trip_life/entity/models/friend.dart';
import 'package:trip_life/entity/models/vacationer.dart';

part 'add_vacationers_event.dart';
part 'add_vacationers_state.dart';

class AddVacationerBloc extends Bloc<AddVacationersEvent, AddVacationersState> {
  AddVacationerBloc(
      {required AbstractFriendRepository friendRepository,
      required AbstractVacationRepository vacationRepository})
      : _friendRepository = friendRepository,
        _vacationRepository = vacationRepository,
        super(AddVacationersState.initial()) {
    on<LoadingListRequest>(_onLoadingList);
    on<AddVacationerRequest>(_onAddVacationer);
  }

  final AbstractFriendRepository _friendRepository;
  final AbstractVacationRepository _vacationRepository;

  Future<void> _onLoadingList(
      LoadingListRequest event, Emitter<AddVacationersState> emit) async {
    emit(AddVacationersState.loadingList(event.vacationId));

    try {
      List<AddVacationerResult> addVacationerResultsList =
          List<AddVacationerResult>.empty();

      List<Friend> addFriendRequestList =
          await _friendRepository.getFriendsList();

      List<Vacationer> vacationersList =
          await _vacationRepository.getVacationersList(state.vacationId);

      return emit(
          AddVacationersState.successLoadingList(addVacationerResultsList));
    } catch (error) {
      return emit(AddVacationersState.errorLoadingList(error.toString()));
    }
  }

  Future<void> _onAddVacationer(
      AddVacationerRequest event, Emitter<AddVacationersState> emit) async {
    emit(state.copyWith(status: AddVacationersStatus.pendingSendInvitation));

    try {
      if (await _vacationRepository.createVacationInvitation(
          event.vacationId, event.userId)) {
        return emit(
            state.copyWith(status: AddVacationersStatus.successSendInvitation));
      }
    } catch (error) {
      return emit(state.copyWith(
          status: AddVacationersStatus.errorSendInvitation,
          errorMessage: (error.toString())));
    }
  }
}
