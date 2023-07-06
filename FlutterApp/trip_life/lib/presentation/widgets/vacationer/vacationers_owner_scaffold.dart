import 'package:flutter/material.dart';
import 'package:trip_life/entity/models/vacationer.dart';
import 'package:trip_life/presentation/widgets/vacationer/add_vacationers_list.dart';
import 'package:trip_life/presentation/widgets/vacationer/vacationers_list.dart';

class VacationersOwnerScaffold extends StatefulWidget {
  const VacationersOwnerScaffold(
      {super.key, required this.vacationId, required this.vacationersList});

  final List<Vacationer> vacationersList;
  final String vacationId;

  @override
  State<VacationersOwnerScaffold> createState() =>
      _VacationersOwnerScaffoldState();
}

class _VacationersOwnerScaffoldState extends State<VacationersOwnerScaffold> {
  int _selectedIndex = 0;

  late final List<Widget> _widgetOptions = <Widget>[
    VacationVacationersList(vacationersList: widget.vacationersList),
    AddVacationersList(vacationId: widget.vacationId)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Confirmé(s)',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_add),
            label: 'Ajouter',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
