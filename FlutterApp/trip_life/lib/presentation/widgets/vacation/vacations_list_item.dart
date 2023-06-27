import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VacationsListItem extends StatelessWidget {
  VacationsListItem(
      {super.key,
      required this.label,
      required this.startDate,
      required this.endDate});

  final String label;
  final DateTime startDate;
  final DateTime endDate;
  final DateFormat dateFormat = DateFormat.yMd("fr_FR");

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        Text(label),
        Text(
            "début: ${dateFormat.format(startDate)}   fin: ${dateFormat.format(endDate)}")
      ]),
    );
  }
}