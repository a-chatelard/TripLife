import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/entity/models/add_friend_result.dart';

part 'add_friends_event.dart';
part 'add_friends_state.dart';

class AddFriendsBloc extends Bloc<AddFriendEvent, AddFriendsState> {
  AddFriendsBloc({required AbstractFriendRepository friendRepository})
      : _friendRepository = friendRepository,
        super(const AddFriendsState.initial()) {
    on<FriendSearchRequest>(_onFriendSearch);
    on<AddFriendRequest>(_onAddFriend);
  }

  final AbstractFriendRepository _friendRepository;

  Future<void> _onFriendSearch(
      FriendSearchRequest event, Emitter<AddFriendsState> emit) async {
    emit(const AddFriendsState.pendingSearch());

    try {
      List<AddFriendResult> addFriendRequestList =
          await _friendRepository.getAddFriendResultList(event.username);

      return emit(AddFriendsState.successSearch(addFriendRequestList));
    } catch (error) {
      return emit(AddFriendsState.errorSearch(error.toString()));
    }
  }

  Future<void> _onAddFriend(
      AddFriendRequest event, Emitter<AddFriendsState> emit) async {
    emit(state.copyWith(status: AddFriendsStatus.pendingSendInvitation));

    try {
      if (await _friendRepository.sendFriendRequest(event.recepientId)) {
        return emit(
            state.copyWith(status: AddFriendsStatus.successSendInvitation));
      }
    } catch (error) {
      return emit(state.copyWith(
          status: AddFriendsStatus.errorSendInvitation,
          errorMessage: (error.toString())));
    }
  }
}
