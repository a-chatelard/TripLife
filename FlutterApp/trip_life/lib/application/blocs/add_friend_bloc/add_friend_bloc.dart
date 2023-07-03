import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/entity/models/add_friend_result.dart';

part 'add_friend_event.dart';
part 'add_friend_state.dart';

class AddFriendBloc extends Bloc<AddFriendEvent, AddFriendState> {
  AddFriendBloc({required AbstractFriendRepository friendRepository})
      : _friendRepository = friendRepository,
        super(const AddFriendState.initial()) {
    on<FriendSearchRequest>(_onFriendSearch);
    on<AddFriendRequest>(_onAddFriend);
  }

  final AbstractFriendRepository _friendRepository;

  Future<void> _onFriendSearch(
      FriendSearchRequest event, Emitter<AddFriendState> emit) async {
    emit(const AddFriendState.pendingSearch());

    try {
      List<AddFriendResult> addFriendRequestList =
          await _friendRepository.getAddFriendResultList(event.username);

      return emit(AddFriendState.successSearch(addFriendRequestList));
    } catch (error) {
      return emit(AddFriendState.errorSearch(error.toString()));
    }
  }

  Future<void> _onAddFriend(
      AddFriendRequest event, Emitter<AddFriendState> emit) async {
    emit(state.copyWith(status: AddFriendStatus.pendingSendInvitation));

    try {
      if (await _friendRepository.sendFriendRequest(event.recepientId)) {
        return emit(
            state.copyWith(status: AddFriendStatus.successSendInvitation));
      }
    } catch (error) {
      return emit(state.copyWith(
          status: AddFriendStatus.errorSendInvitation,
          errorMessage: (error.toString())));
    }
  }
}
