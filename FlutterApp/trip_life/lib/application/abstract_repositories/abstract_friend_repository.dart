import 'package:trip_life/entity/models/add_friend_result.dart';
import 'package:trip_life/entity/models/friend.dart';
import 'package:trip_life/entity/models/friend_invitation_received.dart';
import 'package:trip_life/entity/models/friend_invitation_sent.dart';

abstract class AbstractFriendRepository {
  Future<List<AddFriendResult>> getAddFriendResultList(String username);
  Future<List<Friend>> getFriendsList();
  Future<List<ReceivedFriendRequest>> getReceivedFriendRequests();
  Future<List<SentFriendRequest>> getSentFriendRequests();
  Future<bool> removeFriend(String friendId);
  Future<bool> sendFriendRequest(String recepientId);
  Future<bool> acceptFriendRequest(String friendRequestId);
  Future<bool> cancelFriendRequest(String friendRequestId);
  Future<bool> declineFriendRequest(String friendRequestId);
}
