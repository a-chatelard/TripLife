import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/application/blocs/add_vacationers_bloc/add_vacationers_bloc.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/vacationer/add_vacationers_list_item.dart';

class AddVacationersList extends StatefulWidget {
  const AddVacationersList({super.key, required this.vacationId});

  final String vacationId;

  @override
  State<AddVacationersList> createState() => _AddVacationersListState();
}

class _AddVacationersListState extends State<AddVacationersList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddVacationersBloc(
        friendRepository: serviceLocator.get<AbstractFriendRepository>(),
        vacationRepository: serviceLocator.get<AbstractVacationRepository>(),
      )..add(LoadingListRequest(widget.vacationId)),
      child: BlocConsumer<AddVacationersBloc, AddVacationersState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status.isLoadingListSuccessful ||
                state.status.isSendInvitationSuccessful) {
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.addVacationerResultsList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AddVacationersListItem(
                      vacationerId: state.addVacationerResultsList![index].id,
                      username: state.addVacationerResultsList![index].username,
                      callback: () {
                        context.read<AddVacationersBloc>().add(
                              AddVacationerRequest(widget.vacationId,
                                  state.addVacationerResultsList![index].id),
                            );
                      },
                    );
                  });
            }
            return const CircularProgressIndicator(
                backgroundColor: Colors.green);
          }),
    );
  }
}
