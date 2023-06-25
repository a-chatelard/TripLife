import 'dart:convert';

import 'package:trip_life/application/abstract_repositories/abstract_friend_repository.dart';
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
  Future<List<ReceivedFriendRequest>> getReceivedFriendRequests() async {
    var response = await _httpClient.get("/User/FriendRequest/Received");

    if (response.statusCode == 200) {
      Iterable i = jsonDecode(response.body);

      if (i.isNotEmpty) {
        return List<ReceivedFriendRequest>.from(
            i.map((item) => ReceivedFriendRequest.fromJson(item)));
      }
      return List<ReceivedFriendRequest>.empty();
    }

    return Future.error("Une erreur est survenue.");
  }

  @override
  Future<List<SentFriendRequest>> getSentFriendRequests() async {
    var response = await _httpClient.get("/User/FriendRequest/Sent");

    if (response.statusCode == 200) {
      Iterable i = jsonDecode(response.body);

      if (i.isNotEmpty) {
        return List<SentFriendRequest>.from(
            i.map((item) => SentFriendRequest.fromJson(item)));
      }
      return List<SentFriendRequest>.empty();
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
        jsonEncode(<String, String>{'recepientId': recepientId}));

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
