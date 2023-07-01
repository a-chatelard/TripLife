import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_life/presentation/pages/vacation_page.dart';

class VacationsListItem extends StatelessWidget {
  VacationsListItem(
      {super.key,
      required this.vacationId,
      required this.label,
      required this.startDate,
      required this.endDate});

  final String vacationId;
  final String label;
  final DateTime startDate;
  final DateTime endDate;
  final DateFormat dateFormat = DateFormat.yMd("fr_FR");

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () {
        Navigator.of(context).push(VacationPage.route(vacationId));
      },
      child: Column(children: <Widget>[
        Text(label),
        Text(
            "début: ${dateFormat.format(startDate)}   fin: ${dateFormat.format(endDate)}")
      ]),
    ));
  }
}
