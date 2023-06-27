import 'package:trip_life/entity/models/address.dart';
import 'package:trip_life/entity/models/vacation.dart';
import 'package:trip_life/entity/models/vacation_invitation.dart';
import 'package:trip_life/entity/models/vacationer.dart';

abstract class AbstractVacationRepository {
  Future<bool> acceptVacationInvitation(String vacationId, String vacationerId);
  Future<bool> cancelVacationInvitation(String vacationId, String vacationerId);
  Future<bool> createVacation(String label, DateTime startDate,
      DateTime endDate, Address address, double estimatedBudget);
  Future<bool> declineVacationInvitation(
      String vacationId, String vacationerId);
  Future<bool> deleteVacation(String vacationId);
  Future<bool> deleteVacationer(String vacationId, String vacationerId);
  Future<List<Vacation>> getVacationsList();
  Future<List<VacationInvitation>> getPendingVacationInvitationsList(
      String vacationId);
  Future<List<Vacationer>> getVacationersList(String vacationId);
  Future<bool> createVacationInvitation(String vacationId, String userId);
}