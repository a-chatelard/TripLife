import 'package:trip_life/entity/models/address.dart';
import 'package:trip_life/entity/models/vacation.dart';
import 'package:trip_life/entity/models/vacation_details.dart';
import 'package:trip_life/entity/models/vacation_invitation.dart';

abstract class AbstractVacationRepository {
  Future<bool> acceptVacationInvitation(String vacationId, String vacationerId);
  Future<bool> addActivityParticipation(String vacationId, String activityId);
  Future<bool> cancelVacationInvitation(String vacationId, String vacationerId);
  Future<bool> createActivity(
      String vacationId,
      String label,
      String description,
      DateTime startDate,
      DateTime endDate,
      double estimatedPrice,
      Address address);
  Future<bool> createVacation(String label, DateTime startDate,
      DateTime endDate, Address address, double estimatedBudget);
  Future<bool> createVacationInvitation(String vacationId, String userId);
  Future<bool> declineVacationInvitation(
      String vacationId, String vacationerId);
  Future<bool> deleteActivity(String vacationId, String activityId);
  Future<bool> deleteVacation(String vacationId);
  Future<bool> deleteVacationer(String vacationId, String vacationerId);
  Future<List<Vacation>> getVacationsList();
  Future<List<VacationInvitation>> getPendingVacationInvitationsList(
      String vacationId);
  Future<VacationDetails> getVacation(String vacationId);
  Future<bool> removeActivityParticipation(
      String vacationId, String activityId);
}
