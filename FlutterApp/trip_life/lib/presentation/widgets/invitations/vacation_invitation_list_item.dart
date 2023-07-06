import 'package:flutter/material.dart';

class VacationInvitationListItem extends StatelessWidget {
  const VacationInvitationListItem(
      {super.key,
      required this.vacationLabel,
      required this.acceptCallback,
      required this.declineCallback});

  final String vacationLabel;
  final VoidCallback acceptCallback;
  final VoidCallback declineCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.airplane_ticket,
        size: 28,
      ),
      title: Text(
        vacationLabel,
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
