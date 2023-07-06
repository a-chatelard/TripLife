import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/application/blocs/friend_invitation_list_bloc/friend_invitation_list_bloc.dart';
import 'package:trip_life/entity/models/friend_invitation_received.dart';
import 'package:trip_life/entity/models/friend_invitation_sent.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/invitations/friend_invitation_received_list_item.dart';
import 'package:trip_life/presentation/widgets/invitations/friend_invitation_sent_list_item.dart';
import 'package:trip_life/presentation/widgets/shared/confirmation_dialog.dart';
import 'package:trip_life/presentation/widgets/shared/retry_scaffold.dart';

class FriendInvitationList extends StatefulWidget {
  const FriendInvitationList({super.key});

  @override
  State<FriendInvitationList> createState() => _FriendInvitationListState();
}

class _FriendInvitationListState extends State<FriendInvitationList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => FriendInvitationListBloc(
            friendRepository: serviceLocator.get<AbstractFriendRepository>())
          ..add(FriendInvitationListRequest()),
        child: BlocConsumer<FriendInvitationListBloc,
                FriendInvitationListState>(
            listener: (context, state) {},
            builder: (consumerContext, state) {
              if (state.status.isLoadingListSuccessful ||
                  state.status.isCancelInvitationSentLoading ||
                  state.status.isCancelInvitationSentSuccess ||
                  state.status.isAnswerInvitationReceivedSuccess ||
                  state.status.isAnswerInvitationReceivedLoading) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          child: const Text(
                            "Invitations reçus",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: state.friendInvitationReceivedList!.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount:
                                    state.friendInvitationReceivedList?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  FriendInvitationReceived invitation = state
                                      .friendInvitationReceivedList![index];
                                  return FriendInvitationReceivedListItem(
                                    username: invitation.username,
                                    acceptCallback: () {
                                      showAcceptFriendInvitationDialog(
                                          consumerContext,
                                          invitation.username,
                                          invitation.requestId);
                                    },
                                    declineCallback: () {
                                      showDeclineFriendInvitationDialog(
                                          consumerContext,
                                          invitation.username,
                                          invitation.requestId);
                                    },
                                  );
                                })
                            : const Center(
                                child: Text(
                                  "Aucune invitation en attente.",
                                ),
                              ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          child: const Text(
                            "Invitations envoyées",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: state.friendInvitationSentList!.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount:
                                    state.friendInvitationSentList?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  FriendInvitationSent invitation =
                                      state.friendInvitationSentList![index];
                                  return FriendInvitationSentListItem(
                                    username: invitation.username,
                                    callback: () {
                                      showCancelFriendInvitationDialog(
                                          consumerContext,
                                          invitation.requestId);
                                    },
                                  );
                                })
                            : const Center(
                                child: Text("Aucune invitation envoyée.",
                                    textAlign: TextAlign.center),
                              ),
                      ),
                    ],
                  ),
                );
              } else if (state.status.isLoadingListFailed) {
                return RetryScaffold(
                    errorMessage: state.errorMessage,
                    callback: () {
                      context
                          .read<FriendInvitationListBloc>()
                          .add(FriendInvitationListRequest());
                    });
              } else {
                return const Scaffold(
                    body: Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.green)));
              }
            }));
  }

  Future<void> showCancelFriendInvitationDialog(
      BuildContext dialogContext, String friendRequestId) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Supprimer l\'invitation ?',
          confirmationCallback: () {
            dialogContext
                .read<FriendInvitationListBloc>()
                .add(CancelSentInvitationRequest(friendRequestId));
          },
        );
      },
    );
  }

  Future<void> showAcceptFriendInvitationDialog(
      BuildContext dialogContext, String username, String friendRequestId) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Voulez-vous ajouter $username en ami ?',
          confirmationCallback: () {
            dialogContext
                .read<FriendInvitationListBloc>()
                .add(AnswerReceivedInvitationRequest(friendRequestId, true));
          },
        );
      },
    );
  }

  Future<void> showDeclineFriendInvitationDialog(
      BuildContext dialogContext, String username, String friendRequestId) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Décliner l\'invitation de $username ?',
          confirmationCallback: () {
            dialogContext
                .read<FriendInvitationListBloc>()
                .add(AnswerReceivedInvitationRequest(friendRequestId, false));
          },
        );
      },
    );
  }
}
