import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_life/entity/models/activity.dart';

class ActivityScaffold extends StatefulWidget {
  const ActivityScaffold(
      {super.key, required this.vacationId, required this.activity});

  final String vacationId;
  final Activity activity;

  @override
  State<ActivityScaffold> createState() => _ActivityScaffoldState();
}

class _ActivityScaffoldState extends State<ActivityScaffold> {
  final DateFormat dateFormat = DateFormat.yMd("fr_FR");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.activity.label),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Column(children: [
        Text(
          "Début : ${dateFormat.format(widget.activity.startDate)}",
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          "Fin :      ${dateFormat.format(widget.activity.endDate)}",
          style: const TextStyle(fontSize: 18),
        ),
        if (widget.activity.description != null &&
            widget.activity.description!.isNotEmpty) ...[
          Text("Description : ${widget.activity.description}"),
          Text(widget.activity.description!),
        ],
        if (widget.activity.estimatedPrice != null &&
            widget.activity.estimatedPrice! > 0)
          Text(
            "Prix : ${widget.activity.estimatedPrice}",
            style: const TextStyle(fontSize: 18),
          ),
      ]),
    );
  }
}
