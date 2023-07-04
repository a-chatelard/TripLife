import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/blocs/friend_list_bloc/friend_list_bloc.dart';
import 'package:trip_life/presentation/widgets/friend/friend_list_item.dart';
import 'package:trip_life/presentation/widgets/shared/retry_scaffold.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendListBloc, FriendListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status.isSuccessful) {
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.friendList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return FriendListItem(
                      username: state.friendList?[index].username ?? "");
                });
          } else if (state.status.isFailed) {
            return RetryScaffold(
                errorMessage: state.errorMessage,
                callback: () {
                  context
                      .read<FriendListBloc>()
                      .emit(const FriendListState.loading());
                  context.read<FriendListBloc>().add(FriendListRequest());
                });
          } else {
            return const Scaffold(
                body: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.green)));
          }
        });
  }
}
