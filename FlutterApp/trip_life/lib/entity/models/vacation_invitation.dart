import 'package:equatable/equatable.dart';
import 'package:trip_life/entity/models/vacation.dart';

class VacationInvitation extends Equatable {
  const VacationInvitation(this.vacationerId, this.vacation, this.username);

  final String vacationerId;
  final String username;
  final Vacation vacation;

  @override
  List<Object?> get props => [vacationerId, vacation, username];

  static fromJson(Map<String, dynamic> json) {
    return VacationInvitation(json['vacationerId'],
        Vacation.fromJson(json['vacation']), json['user']['username']);
  }
}
