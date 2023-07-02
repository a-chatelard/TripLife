part of 'vacation_bloc.dart';

abstract class VacationEvent {
  const VacationEvent();
}

class VacationRequest implements VacationEvent {
  VacationRequest(this.vacationId);

  final String vacationId;
}
