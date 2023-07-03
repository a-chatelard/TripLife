part of 'add_vacationers_bloc.dart';

abstract class AddVacationersEvent {
  const AddVacationersEvent();
}

class LoadingListRequest implements AddVacationersEvent {
  final String vacationId;

  LoadingListRequest(this.vacationId);
}

class AddVacationerRequest implements AddVacationersEvent {
  final String vacationId;
  final String userId;

  AddVacationerRequest(this.vacationId, this.userId);
}
