import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/application/blocs/friend_invitation_list_bloc/friend_invitation_list_bloc.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/invitations/friend_invitation_received_list_item.dart';
import 'package:trip_life/presentation/widgets/invitations/friend_invitation_sent_list_item.dart';
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
        child:
            BlocConsumer<FriendInvitationListBloc, FriendInvitationListState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status.isSuccessful) {
                    return Column(
                      children: [
                        const Text("Invitations reçus"),
                        if (state.friendInvitationReceivedList!.isNotEmpty)
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount:
                                  state.friendInvitationReceivedList?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FriendInvitationReceivedListItem(
                                    username: state
                                        .friendInvitationReceivedList![index]
                                        .username);
                              }),
                        if (state.friendInvitationReceivedList!.isEmpty)
                          const Text("Aucune invitation en attente."),
                        const Text("Invitations envoyées"),
                        if (state.friendInvitationSentList!.isNotEmpty)
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: state.friendInvitationSentList?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FriendInvitationSentListItem(
                                    username: state
                                        .friendInvitationSentList![index]
                                        .username);
                              }),
                        if (state.friendInvitationSentList!.isEmpty)
                          const Text("Aucune invitation envoyée."),
                      ],
                    );
                  } else if (state.status.isFailed) {
                    return RetryScaffold(
                        errorMessage: state.errorMessage,
                        callback: () {
                          context
                              .read<FriendInvitationListBloc>()
                              .emit(const FriendInvitationListState.loading());
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
}
