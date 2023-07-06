import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/entity/models/friend_invitation_received.dart';
import 'package:trip_life/entity/models/friend_invitation_sent.dart';

part 'friend_invitation_list_event.dart';
part 'friend_invitation_list_state.dart';

class FriendInvitationListBloc
    extends Bloc<FriendInvitationListEvent, FriendInvitationListState> {
  FriendInvitationListBloc({required AbstractFriendRepository friendRepository})
      : _friendRepository = friendRepository,
        super(const FriendInvitationListState.loading()) {
    on<FriendInvitationListRequest>(_onFriendListRequest);
    on<AnswerReceivedInvitationRequest>(_onAnswerReceivedInvitationRequest);
    on<CancelSentInvitationRequest>(_onCancelSentInvitationRequest);
  }

  final AbstractFriendRepository _friendRepository;

  Future<void> _onFriendListRequest(FriendInvitationListEvent event,
      Emitter<FriendInvitationListState> emit) async {
    emit(const FriendInvitationListState.loading());
    try {
      List<FriendInvitationReceived> friendInvitationListReceived =
          await _friendRepository.getReceivedFriendRequests();
      List<FriendInvitationSent> friendInvitationListSent =
          await _friendRepository.getSentFriendRequests();
      emit(FriendInvitationListState.succes(
          friendInvitationListReceived, friendInvitationListSent));
    } catch (error) {
      emit(const FriendInvitationListState.error(
          "Une erreur est survenue lors de la récupération des données."));
    }
  }

  Future<void> _onAnswerReceivedInvitationRequest(
      AnswerReceivedInvitationRequest event,
      Emitter<FriendInvitationListState> emit) async {
    emit(state.copyWith(
        friendInvitationReceivedList: state.friendInvitationReceivedList,
        friendInvitationSentList: state.friendInvitationSentList,
        status: FriendInvitationListStatus.answerInvitationReceivedLoading));
    try {
      if (event.response) {
        if (await _friendRepository
            .acceptFriendRequest(event.friendRequestId)) {
          state.friendInvitationReceivedList!.removeWhere(
            (invitation) => invitation.requestId == event.friendRequestId,
          );
          emit(state.copyWith(
              friendInvitationReceivedList: state.friendInvitationReceivedList,
              friendInvitationSentList: state.friendInvitationSentList,
              status:
                  FriendInvitationListStatus.answerInvitationReceivedSuccess));
        }
      } else {
        if (await _friendRepository
            .declineFriendRequest(event.friendRequestId)) {
          state.friendInvitationReceivedList!.removeWhere(
            (invitation) => invitation.requestId == event.friendRequestId,
          );
          emit(state.copyWith(
              friendInvitationReceivedList: state.friendInvitationReceivedList,
              friendInvitationSentList: state.friendInvitationSentList,
              status:
                  FriendInvitationListStatus.answerInvitationReceivedSuccess));
        }
      }
    } catch (error) {
      // Changer pour une erreur answer
      return emit(FriendInvitationListState.error(error.toString()));
    }
  }

  Future<void> _onCancelSentInvitationRequest(CancelSentInvitationRequest event,
      Emitter<FriendInvitationListState> emit) async {
    emit(state.copyWith(
        friendInvitationReceivedList: state.friendInvitationReceivedList,
        friendInvitationSentList: state.friendInvitationSentList,
        status: FriendInvitationListStatus.cancelInvitationSentLoading));
    try {
      if (await _friendRepository.cancelFriendRequest(event.friendRequestId)) {
        state.friendInvitationSentList!.removeWhere(
          (invitation) => invitation.requestId == event.friendRequestId,
        );
        emit(state.copyWith(
            friendInvitationReceivedList: state.friendInvitationReceivedList,
            friendInvitationSentList: state.friendInvitationSentList,
            status: FriendInvitationListStatus.cancelInvitationSentSuccess));
      }
    } catch (error) {
      // Changer pour une erreur cancel
      return emit(FriendInvitationListState.error(error.toString()));
    }
  }
}
