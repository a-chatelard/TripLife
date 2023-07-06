import 'package:flutter/material.dart';

class FriendInvitationReceivedListItem extends StatelessWidget {
  const FriendInvitationReceivedListItem(
      {super.key,
      required this.username,
      required this.acceptCallback,
      required this.declineCallback});

  final String username;
  final VoidCallback acceptCallback;
  final VoidCallback declineCallback;

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
      trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        IconButton(
            icon: const Icon(
              Icons.check,
              size: 28,
            ),
            onPressed: () {
              acceptCallback();
            }),
        IconButton(
            icon: const Icon(
              Icons.clear,
              size: 28,
            ),
            onPressed: () {
              declineCallback();
            })
      ]),
    );
  }
}
