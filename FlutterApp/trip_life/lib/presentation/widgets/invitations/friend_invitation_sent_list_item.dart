import 'package:flutter/material.dart';

class FriendInvitationSentListItem extends StatelessWidget {
  const FriendInvitationSentListItem(
      {super.key, required this.username, required this.callback});

  final String username;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.person,
        size: 28,
      ),
      title: Text(
        username,
        style: const TextStyle(fontSize: 28),
      ),
      trailing: IconButton(
          icon: const Icon(
            Icons.clear,
            size: 28,
          ),
          onPressed: () {
            callback();
          }),
    );
  }
}
