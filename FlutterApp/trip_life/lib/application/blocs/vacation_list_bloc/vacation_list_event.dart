part of 'vacation_list_bloc.dart';

abstract class VacationListEvent {
  const VacationListEvent();
}

class VacationListRequest implements VacationListEvent {}
