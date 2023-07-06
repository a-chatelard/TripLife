import 'package:flutter/material.dart';
import 'package:trip_life/entity/models/vacationer.dart';
import 'package:trip_life/presentation/widgets/vacationer/vacationers_list.dart';

class VacationersGuestScaffold extends StatelessWidget {
  const VacationersGuestScaffold({super.key, required this.vacationersList});

  final List<Vacationer> vacationersList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Vacanciers'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: VacationVacationersList(vacationersList: vacationersList),
    );
  }
}
