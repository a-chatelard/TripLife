import 'package:flutter/material.dart';
import 'package:trip_life/entity/models/vacationer.dart';
import 'package:trip_life/presentation/widgets/vacation/vacation_vacationers_partial_list_item.dart';

class VacationVacationersPartialList extends StatefulWidget {
  const VacationVacationersPartialList(
      {super.key, required this.vacationersList});

  final List<Vacationer> vacationersList;

  @override
  State<VacationVacationersPartialList> createState() =>
      _VacationVacationersPartialListState();
}

class _VacationVacationersPartialListState
    extends State<VacationVacationersPartialList> {
  @override
  Widget build(BuildContext context) {
    if (widget.vacationersList.isEmpty) {
      return const Text("Aucun vacacier enregistré");
    } else {
      return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return VacationVacationersPartialListItem(
              vacationerId: widget.vacationersList[index].vacationerId,
              username: widget.vacationersList[index].username ?? "",
            );
          });
    }
  }
}
