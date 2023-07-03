import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/entity/models/add_vacationer_result.dart';
import 'package:trip_life/entity/models/friend.dart';
import 'package:trip_life/entity/models/vacation_invitation.dart';
import 'package:trip_life/entity/models/vacationer.dart';

part 'add_vacationers_event.dart';
part 'add_vacationers_state.dart';

class AddVacationersBloc
    extends Bloc<AddVacationersEvent, AddVacationersState> {
  AddVacationersBloc(
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

      List<Friend> friendsList = await _friendRepository.getFriendsList();

      List<Vacationer> vacationersList =
          await _vacationRepository.getVacationersList(state.vacationId);

      for (var vacationer in vacationersList) {
        friendsList.removeWhere((element) => element.id == vacationer.userId);
      }

      List<VacationInvitation> vacationInvitation = await _vacationRepository
          .getPendingVacationInvitationsList(event.vacationId);

      for (var friend in friendsList) {
        var invitation = vacationInvitation
            .where((inviation) => inviation.username == friend.username)
            .firstOrNull;

        addVacationerResultsList.add(AddVacationerResult(
            friend.id, friend.username, invitation != null));
      }

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
