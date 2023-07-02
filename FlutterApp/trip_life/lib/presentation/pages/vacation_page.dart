import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/application/blocs/vacation_bloc/vacation_bloc.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/shared/app_bar/main_app_bar.dart';
import 'package:trip_life/presentation/widgets/shared/main_drawer.dart';

class VacationPage extends StatefulWidget {
  const VacationPage({super.key, required this.vacationId});

  final String vacationId;

  @override
  State<VacationPage> createState() => _VacationPageState();

  static Route<void> route(String vacationId) {
    return MaterialPageRoute<void>(
        builder: (_) => VacationPage(vacationId: vacationId));
  }
}

class _VacationPageState extends State<VacationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VacationBloc(
          vacationRepository: serviceLocator.get<AbstractVacationRepository>())
        ..add(VacationRequest(widget.vacationId)),
      child: BlocConsumer<VacationBloc, VacationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status.isSuccessful) {
            return Scaffold(
              appBar: MainAppBar(title: state.vacation!.label),
              drawer: const MainDrawer(),
              body: Column(children: [Text(state.vacation!.vacationId)]),
            );
          }
          return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.green)));
        },
      ),
    );
  }
}
