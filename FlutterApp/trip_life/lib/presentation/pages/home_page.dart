import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/application/blocs/vacation_list_bloc/vacation_list_bloc.dart';
import 'package:trip_life/presentation/pages/add_vacation_page.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/shared/app_bar/main_app_bar.dart';
import 'package:trip_life/presentation/widgets/shared/main_drawer.dart';
import 'package:trip_life/presentation/widgets/vacation/vacations_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const HomePage(title: "Mes voyages"));
  }

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String title = "Mes Voyages";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(title: title),
        drawer: const MainDrawer(),
        body: BlocProvider(
            create: (_) => VacationListBloc(
                vacationRepository:
                    serviceLocator.get<AbstractVacationRepository>())
              ..add(VacationListRequest()),
            child: const VacationsList()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddVacationPage(context),
          child: const Icon(Icons.add),
        ));
  }

  void _showAddVacationPage(BuildContext context) {
    Navigator.push(context, AddVacationPage.route());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
