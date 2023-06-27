import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/application/blocs/vacation_list_bloc/vacation_list_bloc.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/shared/main_app_bar.dart';
import 'package:trip_life/presentation/widgets/shared/main_drawer.dart';
import 'package:trip_life/presentation/widgets/vacation/vacations_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const HomePage(title: "Welcome"));
  }

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      drawer: const MainDrawer(),
      body: BlocProvider(
        create: (_) => VacationListBloc(
            vacationRepository:
                serviceLocator.get<AbstractVacationRepository>()),
        child: BlocConsumer<VacationListBloc, VacationListState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.status.isSuccessful) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: state.vacationList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return VacationsListItem(
                        label: state.vacationList?[index].label ?? "",
                        startDate: state.vacationList?[index].startDate ??
                            DateTime(2023),
                        endDate: state.vacationList?[index].endDate ??
                            DateTime(2023),
                      );
                    });
              } else if (state.status.isFailed) {
                return Container(
                  height: 50,
                  color: Colors.tealAccent[100],
                  child: Center(child: Text(state.errorMessage ?? "")),
                );
              } else {
                return const Scaffold(
                    body: Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.green)));
              }
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
