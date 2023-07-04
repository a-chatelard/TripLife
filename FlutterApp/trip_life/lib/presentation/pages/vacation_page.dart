import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trip_life/application/abstract_repositories/abstract_authentication_repository.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/application/blocs/vacation_bloc/vacation_bloc.dart';
import 'package:trip_life/entity/models/activity.dart';
import 'package:trip_life/entity/models/vacationer.dart';
import 'package:trip_life/presentation/service_locator.dart';
import 'package:trip_life/presentation/widgets/activity/add_activity_form.dart';
import 'package:trip_life/presentation/widgets/shared/app_bar/main_app_bar.dart';
import 'package:trip_life/presentation/widgets/shared/clickable_text_span.dart';
import 'package:trip_life/presentation/widgets/shared/main_drawer.dart';
import 'package:trip_life/presentation/widgets/vacation/vacation_activities_list.dart';
import 'package:trip_life/presentation/widgets/vacation/vacation_vacationers_partial_list.dart';
import 'package:trip_life/presentation/widgets/vacationer/vacationers_list_item.dart';

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
  final DateFormat dateFormat = DateFormat.yMd("fr_FR");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VacationBloc(
          authenticationRepository:
              serviceLocator.get<AbstractAuthenticationRepository>(),
          vacationRepository: serviceLocator.get<AbstractVacationRepository>())
        ..add(VacationRequest(widget.vacationId)),
      child: BlocConsumer<VacationBloc, VacationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status.isSuccessful) {
            return Scaffold(
                appBar: MainAppBar(title: state.vacation!.label),
                drawer: const MainDrawer(),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "début : ${dateFormat.format(state.vacation!.startDate)}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          "fin :      ${dateFormat.format(state.vacation!.endDate)}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        //Text("lieu :" ${state.vacation})
                        const Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        const Text(
                          "Vacanciers",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 100,
                          child: VacationVacationersPartialList(
                              vacationersList: state.vacation!.vacationersList),
                        ),
                        if (state.vacation!.vacationersList.length > 3 ||
                            state.vacation!.connectedUserIsOwner)
                          Text.rich(ClickableTextSpan(
                              texte: (state.vacation!.connectedUserIsOwner
                                  ? "Voir plus"
                                  : "Ajouter"),
                              callback: () {
                                _showVacationersDialog(
                                    state.vacation!.vacationersList);
                              })),
                        const Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        const Text(
                          "Activités",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 100,
                          child: VacationActicitiesList(
                            activitiesList: state.vacation!.activitiesList,
                            callback: _showActivityDialog,
                          ),
                        )
                      ]),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => _showAddActivityDialog(),
                  child: const Icon(Icons.add),
                ));
          }
          return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.green)));
        },
      ),
    );
  }

  Future<void> _showActivityDialog(Activity activity) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(activity.label),
          content: SingleChildScrollView(
            child: ListBody(
                // children: <Widget>[
                //   Text('This is a demo alert dialog.'),
                //   Text('Would you like to approve of this message?'),
                // ],
                ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddActivityDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter une activité'),
          content: SingleChildScrollView(
              child: AddActivityForm(
            vacationId: widget.vacationId,
          )),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showVacationersDialog(List<Vacationer> vacationersList) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Vacanciers'),
          content: SingleChildScrollView(
              child: vacationersList.isEmpty
                  ? const Text("Aucun vacacier enregistré")
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: vacationersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return VacationersListItem(
                          vacationerId: vacationersList[index].vacationerId,
                          username: vacationersList[index].username ?? "",
                        );
                      })),
          actions: <Widget>[
            TextButton(
              child: const Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
