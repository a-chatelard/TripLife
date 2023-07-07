part of 'activity_participation_bloc.dart';

abstract class ActivityParticipationEvent {
  const ActivityParticipationEvent();
}

class ActivityParticipationRequest implements ActivityParticipationEvent {
  final String vacationId;
  final String activityId;

  ActivityParticipationRequest(this.vacationId, this.activityId);
}

class AddParticipationRequest implements ActivityParticipationEvent {
  final String vacationId;
  final String activityId;
  final bool participate = true;

  AddParticipationRequest(this.vacationId, this.activityId);
}

class RemoveParticipationRequest implements ActivityParticipationEvent {
  final String vacationId;
  final String activityId;
  final bool participate = false;

  RemoveParticipationRequest(this.vacationId, this.activityId);
}
