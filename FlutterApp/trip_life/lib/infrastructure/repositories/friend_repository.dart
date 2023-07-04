import 'dart:convert';

import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
import 'package:trip_life/entity/models/add_friend_result.dart';
import 'package:trip_life/entity/models/connected_user.dart';
import 'package:trip_life/entity/models/friend_invitation_sent.dart';
import 'package:trip_life/entity/models/friend_invitation_received.dart';
import 'package:trip_life/entity/models/friend.dart';
import 'package:trip_life/infrastructure/abstracts/asbtract_http_client.dart';

class FriendRepository implements AbstractFriendRepository {
  FriendRepository({required AbstractHttpClient httpClient})
      : _httpClient = httpClient;

  final AbstractHttpClient _httpClient;

  @override
  Future<bool> acceptFriendRequest(String friendRequestId) async {
    var answer = {'answer': true};

    var response = await _httpClient.patch(
        "/User/FriendRequest/$friendRequestId", jsonEncode(answer));

    return response.statusCode == 200;
  }

  @override
  Future<bool> cancelFriendRequest(String friendRequestId) async {
    var response =
        await _httpClient.delete("/User/FriendRequest/$friendRequestId");

    return response.statusCode == 200;
  }

  @override
  Future<bool> declineFriendRequest(String friendRequestId) async {
    var answer = {'answer': false};

    var response = await _httpClient.patch(
        "/User/FriendRequest/$friendRequestId", jsonEncode(answer));

    return response.statusCode == 200;
  }

  @override
  Future<List<AddFriendResult>> getAddFriendResultList(String username) async {
    var response = await _httpClient
        .get("/User/Search", queryParameters: {"username": username});

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      if (result != null) {
        AddFriendResult addFriendResult =
            AddFriendResult(result["id"], result["username"], false, false);

        return [addFriendResult];

        // var sentFriendRequests = await getSentFriendRequests();

        // bool hasReceivedFriendRequest = false;

        // if (sentFriendRequests.isNotEmpty) {
        //   hasReceivedFriendRequest =
        //       sentFriendRequests.any((request) => request.username == username);
        // }

        // AddFriendResult addFriendResult = AddFriendResult(result["id"],
        //     result["username"], result["friend"], hasReceivedFriendRequest);

        // return [addFriendResult];
      }

      return List<AddFriendResult>.empty();
    }

    return Future.error("Une erreur est survenue.");
  }

  @override
  Future<ConnectedUser> getConnectedUser() async {
    var response = await _httpClient.get("/User");

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      return ConnectedUser(json['id'], json['username'], json['email']);
    }

    return Future.error("Une erreur est survenue.");
  }

  @override
  Future<List<Friend>> getFriendsList() async {
    var response = await _httpClient.get("/User/Friend");

    if (response.statusCode == 200) {
      Iterable i = jsonDecode(response.body);

      if (i.isNotEmpty) {
        return List<Friend>.from(i.map((item) => Friend.fromJson(item)));
      }
      return List<Friend>.empty();
    }

    return Future.error("Une erreur est survenue.");
  }

  @override
  Future<List<FriendInvitationReceived>> getReceivedFriendRequests() async {
    var response = await _httpClient.get("/User/FriendRequest/Received");

    if (response.statusCode == 200) {
      Iterable i = jsonDecode(response.body);

      if (i.isNotEmpty) {
        return List<FriendInvitationReceived>.from(
            i.map((item) => FriendInvitationReceived.fromJson(item)));
      }
      return List<FriendInvitationReceived>.empty();
    }

    return Future.error("Une erreur est survenue.");
  }

  @override
  Future<List<FriendInvitationSent>> getSentFriendRequests() async {
    var response = await _httpClient.get("/User/FriendRequest/Sent");

    if (response.statusCode == 200) {
      Iterable i = jsonDecode(response.body);

      if (i.isNotEmpty) {
        return List<FriendInvitationSent>.from(
            i.map((item) => FriendInvitationSent.fromJson(item)));
      }
      return List<FriendInvitationSent>.empty();
    }

    return Future.error("Une erreur est survenue.");
  }

  @override
  Future<bool> removeFriend(String friendId) async {
    var response = await _httpClient.delete("/User/Friend/$friendId");

    return response.statusCode == 200;
  }

  @override
  Future<bool> sendFriendRequest(String recepientId) async {
    var response = await _httpClient.post("/User/FriendRequest",
        jsonEncode(<String, String>{'recipientId': recepientId}));

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
