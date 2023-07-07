import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/application/blocs/activity_participation_bloc/activity_participation_bloc.dart';
import 'package:trip_life/presentation/service_locator.dart';

class ActivityParticipation extends StatefulWidget {
  const ActivityParticipation(
      {super.key, required this.vacationId, required this.activityId});

  final String vacationId;
  final String activityId;

  @override
  State<ActivityParticipation> createState() => _ActivityParticipationState();
}

class _ActivityParticipationState extends State<ActivityParticipation> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivityParticipationBloc(
          vacationRepository: serviceLocator.get<AbstractVacationRepository>())
        ..add(
            ActivityParticipationRequest(widget.vacationId, widget.activityId)),
      child:
          BlocConsumer<ActivityParticipationBloc, ActivityParticipationState>(
        listener: (context, state) {},
        builder: (context, state) {
          // WIP
          return TextButton(onPressed: () {}, child: const Text("Participer"));
        },
      ),
    );
  }
}
