import 'package:flutter/material.dart';

class VacationInvitationListItem extends StatelessWidget {
  const VacationInvitationListItem({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[Text(username)]),
    );
  }
}
