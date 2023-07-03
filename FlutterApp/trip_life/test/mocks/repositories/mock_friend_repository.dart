import 'package:trip_life/entity/models/connected_user.dart';
import 'package:trip_life/entity/models/friend_invitation_sent.dart';
import 'package:trip_life/entity/models/friend_invitation_received.dart';
import 'package:trip_life/entity/models/friend.dart';
import 'package:trip_life/entity/models/add_friend_result.dart';
import 'package:trip_life/infrastructure/repositories/friend_repository.dart';

class MockFriendRepository implements FriendRepository {
  @override
  Future<bool> acceptFriendRequest(String friendRequestId) async {
    return true;
  }

  @override
  Future<bool> cancelFriendRequest(String friendRequestId) async {
    return true;
  }

  @override
  Future<bool> declineFriendRequest(String friendRequestId) async {
    return true;
  }

  @override
  Future<List<AddFriendResult>> getAddFriendResultList(String username) async {
    return List<AddFriendResult>.empty();
  }

  @override
  Future<List<Friend>> getFriendsList() async {
    return List<Friend>.empty();
  }

  @override
  Future<List<ReceivedFriendRequest>> getReceivedFriendRequests() async {
    return List<ReceivedFriendRequest>.empty();
  }

  @override
  Future<List<SentFriendRequest>> getSentFriendRequests() async {
    return List<SentFriendRequest>.empty();
  }

  @override
  Future<bool> removeFriend(String friendId) async {
    return false;
  }

  @override
  Future<bool> sendFriendRequest(String recepientId) async {
    return false;
  }

  @override
  Future<ConnectedUser> getConnectedUser() {
    // TODO: implement getConnectedUser
    throw UnimplementedError();
  }
}
