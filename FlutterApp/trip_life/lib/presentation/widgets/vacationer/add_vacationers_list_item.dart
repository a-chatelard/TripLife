import 'package:flutter/material.dart';

class AddVacationersListItem extends StatelessWidget {
  const AddVacationersListItem(
      {super.key,
      required this.vacationerId,
      required this.username,
      required this.callback});

  final String vacationerId;
  final String username;
  final void Function() callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(username),
      leading: IconButton(
        icon: const Icon(Icons.person_add),
        onPressed: () {
          callback();
        },
      ),
    );
  }
}
