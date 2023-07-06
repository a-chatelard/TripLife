import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/application/blocs/vacation_invitation_list_bloc/vacation_invitation_list_bloc.dart';
import 'package:trip_life/entity/models/vacation_invitation.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/invitations/vacation_invitation_list_item.dart';
import 'package:trip_life/presentation/widgets/shared/confirmation_dialog.dart';
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
                serviceLocator.get<AbstractVacationRepository>())
          ..add(VacationInvitationListRequest()),
        child: BlocConsumer<VacationInvitationListBloc,
                VacationInvitationListState>(
            listener: (context, state) {},
            builder: (consumerContext, state) {
              if (state.status.isLoadingListSuccessful ||
                  state.status.isAnswerInvitationLoading ||
                  state.status.isAnswerInvitationSuccessful) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          child: const Text(
                            "Invitations à un voyage",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                      ),
                      if (state.vacationInvitationList!.isNotEmpty)
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: state.vacationInvitationList?.length,
                            itemBuilder: (BuildContext context, int index) {
                              VacationInvitation invitation =
                                  state.vacationInvitationList![index];
                              return VacationInvitationListItem(
                                vacationLabel: invitation.vacation.label,
                                acceptCallback: () {
                                  showAcceptVacationInvitationDialog(
                                      consumerContext,
                                      invitation.vacation.vacationId,
                                      invitation.vacationerId);
                                },
                                declineCallback: () {
                                  showDeclineVacationInvitationDialog(
                                      consumerContext,
                                      invitation.vacation.vacationId,
                                      invitation.vacationerId);
                                },
                              );
                            }),
                      if (state.vacationInvitationList!.isEmpty)
                        const Text("Aucune invitation en attente."),
                    ],
                  ),
                );
              } else if (state.status.isLoadingListFailed) {
                return RetryScaffold(
                    errorMessage: state.errorMessage,
                    callback: () {
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

  Future<void> showAcceptVacationInvitationDialog(
      BuildContext dialogContext, String vacationId, String vacationerId) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Accepter l\invitation ?',
          confirmationCallback: () {
            dialogContext.read<VacationInvitationListBloc>().add(
                AnswerVacationInvitationRequest(
                    vacationId, vacationerId, true));
          },
        );
      },
    );
  }

  Future<void> showDeclineVacationInvitationDialog(
      BuildContext dialogContext, String vacationId, String vacationerId) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Décliner l\'invitation ?',
          confirmationCallback: () {
            dialogContext.read<VacationInvitationListBloc>().add(
                AnswerVacationInvitationRequest(
                    vacationId, vacationerId, false));
          },
        );
      },
    );
  }
}
