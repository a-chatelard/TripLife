import 'package:flutter/material.dart';

import 'package:trip_life/entity/models/vacationer.dart';
import 'package:trip_life/presentation/widgets/vacationer/vacationers_list_item.dart';

class VacationVacationersList extends StatelessWidget {
  const VacationVacationersList({super.key, required this.vacationersList});

  final List<Vacationer> vacationersList;

  @override
  Widget build(BuildContext context) {
    return vacationersList.isEmpty
        ? const Text("Aucun vacacier enregistré")
        : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: vacationersList.length,
            itemBuilder: (BuildContext context, int index) {
              return VacationersListItem(
                username: vacationersList[index].username ?? "",
              );
            });
  }
}
