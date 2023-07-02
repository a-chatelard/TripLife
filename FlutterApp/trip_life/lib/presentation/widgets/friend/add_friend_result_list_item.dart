import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/blocs/add_friend_bloc/add_friend_bloc.dart';

class AddFriendResultListItem extends StatelessWidget {
  const AddFriendResultListItem({
    super.key,
    required this.userId,
    required this.username,
    required this.isFriend,
    required this.isLoading,
    required this.hasPendingInvitation,
  });

  final String userId;
  final String username;
  final bool isFriend;
  final bool isLoading;
  final bool hasPendingInvitation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(username),
      leading: IconButton(
        icon: const Icon(Icons.person_add),
        onPressed: () {
          context.read<AddFriendBloc>().add(AddFriendRequest(userId));
        },
      ),
    );
  }
}
