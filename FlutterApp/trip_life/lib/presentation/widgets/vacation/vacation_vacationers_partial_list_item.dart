import 'package:flutter/material.dart';

class VacationVacationersPartialListItem extends StatelessWidget {
  const VacationVacationersPartialListItem(
      {super.key, required this.vacationerId, required this.username});

  final String vacationerId;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        Text(username),
      ]),
    );
  }
}
