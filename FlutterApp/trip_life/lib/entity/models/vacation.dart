import 'package:equatable/equatable.dart';

class Vacation extends Equatable {
  const Vacation(this.vacationId, this.label, this.startDate, this.endDate);

  final String vacationId;
  final String label;
  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object?> get props => [vacationId, label, startDate, endDate];

  static fromJson(Map<String, dynamic> json) {
    return Vacation(json['id'], json['label'],
        DateTime.parse(json['startDate']), DateTime.parse(json['endDate']));
  }
}
