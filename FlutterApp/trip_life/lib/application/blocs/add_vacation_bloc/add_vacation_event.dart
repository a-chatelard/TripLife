part of 'add_vacation_bloc.dart';

abstract class AddVacationEvent {
  const AddVacationEvent();
}

class AddVacationRequest implements AddVacationEvent {
  final String label;
  final DateTime startDate;
  final DateTime endDate;
  final Address address;
  final double? estimatedBudget;

  AddVacationRequest(this.label, this.startDate, this.endDate, this.address,
      this.estimatedBudget);
}
