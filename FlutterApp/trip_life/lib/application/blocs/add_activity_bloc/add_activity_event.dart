part of 'add_activity_bloc.dart';

abstract class AddActivityEvent {
  const AddActivityEvent();
}

class AddActivityRequest implements AddActivityEvent {
  final String vacationId;
  final String label;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final double? estimatedPrice;
  final Address address;

  AddActivityRequest(this.vacationId, this.label, this.startDate, this.endDate,
      this.address, this.description, this.estimatedPrice);
}
