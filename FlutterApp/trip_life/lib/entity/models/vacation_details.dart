import 'package:equatable/equatable.dart';
import 'package:trip_life/entity/models/vacationer.dart';

class VacationDetails extends Equatable {
  VacationDetails(
    this.vacationId,
    this.label,
    this.startDate,
    this.endDate,
    //this.estimatedBudget
  );

  final String vacationId;
  final String label;
  final DateTime startDate;
  final DateTime endDate;
  //final double estimatedBudget;
  late List<Vacationer> vacationersList;

  @override
  List<Object?> get props => [vacationId];

  static fromJson(Map<String, dynamic> json) {
    return VacationDetails(
      json['id'],
      json['label'],
      DateTime.parse(json['startDate']),
      DateTime.parse(json['endDate']),
      //double.parse(json['estimatedBudget'])
    );
  }

  void setVacationersList(List<Vacationer> vacationersList) {
    this.vacationersList = vacationersList;
  }
}
