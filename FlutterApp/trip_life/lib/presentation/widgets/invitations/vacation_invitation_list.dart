import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/application/blocs/vacation_invitation_list_bloc/vacation_invitation_list_bloc.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/invitations/vacation_invitation_list_item.dart';
import 'package:trip_life/presentation/widgets/shared/retry_scaffold.dart';

class VacationInvitationList extends StatefulWidget {
  const VacationInvitationList({super.key});

  @override
  State<VacationInvitationList> createState() => _VacationInvitationListState();
}

class _VacationInvitationListState extends State<VacationInvitationList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => VacationInvitationListBloc(
            vacationRepository:
                serviceLocator.get<AbstractVacationRepository>()),
        child: BlocConsumer<VacationInvitationListBloc,
                VacationInvitationListState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.status.isSuccessful) {
                return Column(
                  children: [
                    const Text("Invitations reçus"),
                    if (state.vacationInvitationList!.isNotEmpty)
                      ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: state.vacationInvitationList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return VacationInvitationListItem(
                                username: state
                                    .vacationInvitationList![index].username);
                          }),
                    if (state.vacationInvitationList!.isEmpty)
                      const Text("Aucune invitation en attente."),
                  ],
                );
              } else if (state.status.isFailed) {
                return RetryScaffold(
                    errorMessage: state.errorMessage,
                    callback: () {
                      context
                          .read<VacationInvitationListBloc>()
                          .emit(const VacationInvitationListState.loading());
                      context
                          .read<VacationInvitationListBloc>()
                          .add(VacationInvitationListRequest());
                    });
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.green),
                  ),
                );
              }
            }));
  }
}
