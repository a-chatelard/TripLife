import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/application/blocs/add_friend_bloc/add_friend_bloc.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/friend/add_friend_result_list_item.dart';
import 'package:trip_life/presentation/widgets/shared/deboucer.dart';
import 'package:trip_life/presentation/widgets/shared/previous_screen_app_bar.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AddFriendPage());
  }

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final Debouncer _debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreviousScreenAppBar(),
        body: BlocProvider(
            create: (_) => AddFriendBloc(
                friendRepository:
                    serviceLocator.get<AbstractFriendRepository>()),
            child: BlocConsumer<AddFriendBloc, AddFriendState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Column(children: [
                    TextField(
                        decoration: const InputDecoration(
                            hintText: 'Rechercher un ami'),
                        onChanged: (username) {
                          _debouncer
                              .run(() => _searchFriend(context, username));
                        }),
                    Expanded(child: _addFriendResultList(state))
                  ]);
                })));
  }

  void _searchFriend(BuildContext context, String username) {
    context.read<AddFriendBloc>().add(FriendSearchRequest(username));
  }

  Widget _addFriendResultList(AddFriendState state) {
    if (state.status.isSearchPending) {
      return const Scaffold(
          body: Center(
              child: CircularProgressIndicator(backgroundColor: Colors.green)));
    } else if (state.status.isSearchSuccessful ||
        state.status.isSendInvitationPending ||
        state.status.isSendInvitationSuccessful ||
        state.status.isSendInvitationFailed) {
      return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: state.addFriendResultsList?.length,
          itemBuilder: (BuildContext context, int index) {
            return AddFriendResultListItem(
              userId: state.addFriendResultsList?[index].id ?? "",
              username: state.addFriendResultsList?[index].username ?? "",
              isFriend: false,
              isLoading: false,
              hasPendingInvitation: false,
            );
          });
    } else {
      return const Scaffold();
    }
  }
}
