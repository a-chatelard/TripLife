import 'package:trip_life/entity/models/friend_invitation_sent.dart';
import 'package:trip_life/entity/models/friend_invitation_received.dart';
import 'package:trip_life/entity/models/friend.dart';
import 'package:trip_life/entity/models/add_friend_result.dart';
import 'package:trip_life/infrastructure/repositories/friend_repository.dart';

class MockFriendRepository implements FriendRepository {
  @override
  Future<bool> acceptFriendRequest(String friendRequestId) {
    // TODO: implement acceptFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<bool> cancelFriendRequest(String friendRequestId) {
    // TODO: implement cancelFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<bool> declineFriendRequest(String friendRequestId) {
    // TODO: implement declineFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<List<AddFriendResult>> getAddFriendResultList(String username) {
    // TODO: implement getAddFriendResultList
    throw UnimplementedError();
  }

  @override
  Future<List<Friend>> getFriendsList() {
    // TODO: implement getFriendsList
    throw UnimplementedError();
  }

  @override
  Future<List<ReceivedFriendRequest>> getReceivedFriendRequests() {
    // TODO: implement getReceivedFriendRequests
    throw UnimplementedError();
  }

  @override
  Future<List<SentFriendRequest>> getSentFriendRequests() {
    // TODO: implement getSentFriendRequests
    throw UnimplementedError();
  }

  @override
  Future<bool> removeFriend(String friendId) {
    // TODO: implement removeFriend
    throw UnimplementedError();
  }

  @override
  Future<bool> sendFriendRequest(String recepientId) {
    // TODO: implement sendFriendRequest
    throw UnimplementedError();
  }
}
