import 'package:flutter/material.dart';

class FriendListItem extends StatelessWidget {
  const FriendListItem({super.key, required this.username});

  final String username;

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
        ));
  }
}
