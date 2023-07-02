import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/blocs/vacation_list_bloc/vacation_list_bloc.dart';
import 'package:trip_life/entity/models/vacation.dart';
import 'package:trip_life/presentation/widgets/shared/retry_scaffold.dart';
import 'package:trip_life/presentation/widgets/vacation/vacations_list_item.dart';

class VacationsList extends StatefulWidget {
  const VacationsList({super.key});

  @override
  State<VacationsList> createState() => _VacationsListState();
}

class _VacationsListState extends State<VacationsList> {
  List<Vacation> vacations = List.empty();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VacationListBloc, VacationListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status.isSuccessful) {
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.vacationList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return VacationsListItem(
                    vacationId: state.vacationList![index].vacationId,
                    label: state.vacationList![index].label,
                    startDate: state.vacationList![index].startDate,
                    endDate: state.vacationList![index].endDate,
                  );
                });
          } else if (state.status.isFailed) {
            return RetryScaffold(
                errorMessage: state.errorMessage,
                callback: () {
                  context.read<VacationListBloc>().add(VacationListRequest());
                });
          } else {
            return const Scaffold(
                body: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.green)));
          }
        });
  }
}
