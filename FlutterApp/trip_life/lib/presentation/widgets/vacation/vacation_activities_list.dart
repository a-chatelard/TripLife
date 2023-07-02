import 'package:flutter/material.dart';
import 'package:trip_life/entity/models/activity.dart';
import 'package:trip_life/presentation/widgets/vacation/vacation_activities_list_item.dart';

class VacationActicitiesList extends StatefulWidget {
  const VacationActicitiesList({super.key, required this.activitiesList});

  final List<Activity> activitiesList;

  @override
  State<VacationActicitiesList> createState() => _VacationActivitiesListState();
}

class _VacationActivitiesListState extends State<VacationActicitiesList> {
  @override
  Widget build(BuildContext context) {
    if (widget.activitiesList.isEmpty) {
      return const Text("Aucune activité enregistrée");
    } else {
      return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widget.activitiesList.length,
          itemBuilder: (BuildContext context, int index) {
            return VacationActivitiesListItem(
              activityId: widget.activitiesList[index].activityId,
              label: widget.activitiesList[index].label,
              startDate: widget.activitiesList[index].startDate,
              endDate: widget.activitiesList[index].endDate,
            );
          });
    }
  }
}
