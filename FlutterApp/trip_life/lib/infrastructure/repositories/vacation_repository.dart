import 'dart:convert';

import 'package:trip_life/application/abstract_repositories/abstract_vacation_repository.dart';
import 'package:trip_life/entity/models/vacation_details.dart';
import 'package:trip_life/entity/models/vacation_invitation.dart';
import 'package:trip_life/entity/models/vacation.dart';
import 'package:trip_life/entity/models/address.dart';
import 'package:trip_life/infrastructure/abstracts/asbtract_http_client.dart';

class VacationRepository implements AbstractVacationRepository {
  VacationRepository({required AbstractHttpClient httpClient})
      : _httpClient = httpClient;

  final AbstractHttpClient _httpClient;

  @override
  Future<bool> acceptVacationInvitation(
      String vacationId, String vacationerId) async {
    var answer = {'answer': true};

    var response = await _httpClient.patch(
        "/Vacation/$vacationId/Vacationer/$vacationerId", jsonEncode(answer));

    return response.statusCode == 200;
  }

  @override
  Future<bool> cancelVacationInvitation(
      String vacationId, String vacationerId) async {
    var response = await _httpClient
        .delete("/Vacation/$vacationId/Vacationer/$vacationerId");

    return response.statusCode == 204;
  }

  @override
  Future<bool> createVacation(String label, DateTime startDate,
      DateTime endDate, Address address, double estimatedBudget) async {
    var vacation = {
      'label': label,
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String(),
      'address': address.toJson(),
      'estimatedBudget': estimatedBudget
    };

    var response = await _httpClient.post("/Vacation", jsonEncode(vacation));

    return response.statusCode == 201;
  }

  @override
  Future<bool> createVacationInvitation(
      String vacationId, String userId) async {
    var invitation = {'userId': userId};

    var response = await _httpClient.post(
        "/Vacation/$vacationId/Vacationer", jsonEncode(invitation));

    return response.statusCode == 201;
  }

  @override
  Future<bool> declineVacationInvitation(
      String vacationId, String vacationerId) async {
    var answer = {'answer': false};

    var response = await _httpClient.patch(
        "/Vacation/$vacationId/Vacationer/$vacationerId", jsonEncode(answer));

    return response.statusCode == 200;
  }

  @override
  Future<bool> deleteVacation(String vacationId) async {
    var response = await _httpClient.delete("/Vacation/$vacationId");

    return response.statusCode == 204;
  }

  @override
  Future<bool> deleteVacationer(String vacationId, String vacationerId) async {
    var response = await _httpClient
        .delete("/Vacation/$vacationId/Vacationer/$vacationerId");

    return response.statusCode == 204;
  }

  @override
  Future<List<VacationInvitation>> getPendingVacationInvitationsList(
      String vacationId) async {
    var response = await _httpClient.get("/Vacation/$vacationId/Invitation");

    if (response.statusCode == 200) {
      Iterable i = jsonDecode(response.body);

      if (i.isNotEmpty) {
        return List<VacationInvitation>.from(
            i.map((item) => VacationInvitation.fromJson(item)));
      }
      return List<VacationInvitation>.empty();
    }

    return Future.error("Une erreur est survenue.");
  }

  @override
  Future<VacationDetails> getVacation(String vacationId) async {
    var responseVacation = await _httpClient.get("/Vacation/$vacationId");

    if (responseVacation.statusCode == 200) {
      VacationDetails vacationDetails =
          VacationDetails.fromJson(jsonDecode(responseVacation.body));

      // if (i.isNotEmpty) {
      //   //return VacationDetails.from(i.map((item) => Vacationer.fromJson(item)));
      // }
      //return List<VacationDetails>.empty();

      return vacationDetails;
    }

    return Future.error("Une erreur est survenue.");
  }

  @override
  Future<List<Vacation>> getVacationsList() async {
    var response = await _httpClient.get("/Vacation");

    if (response.statusCode == 200) {
      Iterable i = jsonDecode(response.body);

      if (i.isNotEmpty) {
        return List<Vacation>.from(i.map((item) => Vacation.fromJson(item)));
      }
      return List<Vacation>.empty();
    }

    return Future.error("Une erreur est survenue.");
  }
}
