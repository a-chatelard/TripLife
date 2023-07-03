import 'package:flutter/material.dart';

import 'package:trip_life/entity/models/vacationer.dart';
import 'package:trip_life/presentation/widgets/vacationer/vacationers_list_item.dart';

class VacationVacationersList extends StatefulWidget {
  const VacationVacationersList({super.key, required this.vacationersList});

  final List<Vacationer> vacationersList;

  @override
  State<VacationVacationersList> createState() =>
      _VacationVacationersListState();
}

class _VacationVacationersListState extends State<VacationVacationersList> {
  @override
  Widget build(BuildContext context) {
    if (widget.vacationersList.isEmpty) {
      return const Text("Aucun vacancier enregistré");
    } else {
      return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widget.vacationersList.length > 3
              ? 3
              : widget.vacationersList.length,
          itemBuilder: (BuildContext context, int index) {
            return VacationersListItem(
              vacationerId: widget.vacationersList[index].vacationerId,
              username: widget.vacationersList[index].username ?? "",
            );
          });
    }
  }
}
