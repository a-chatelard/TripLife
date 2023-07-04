import 'package:flutter/material.dart';

class FriendInvitationReceivedListItem extends StatelessWidget {
  const FriendInvitationReceivedListItem({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[Text(username)]),
    );
  }
}
