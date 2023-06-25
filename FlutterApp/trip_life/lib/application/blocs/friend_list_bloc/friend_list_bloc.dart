import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/entity/models/friend.dart';

part 'friend_list_event.dart';
part 'friend_list_state.dart';

class FriendListBloc extends Bloc<FriendListEvent, FriendListState> {
  FriendListBloc({required AbstractFriendRepository friendRepository})
      : _friendRepository = friendRepository,
        super(const FriendListState.loading()) {
    on<FriendListRequest>(_onFriendListRequest);
    add(FriendListRequest());
  }

  final AbstractFriendRepository _friendRepository;

  Future<void> _onFriendListRequest(
      FriendListEvent event, Emitter<FriendListState> emit) async {
    try {
      List<Friend> friendsList = await _friendRepository.getFriendsList();
      emit(FriendListState.succes(friendsList));
    } catch (error) {
      emit(FriendListState.error(error.toString()));
    }
  }
}
