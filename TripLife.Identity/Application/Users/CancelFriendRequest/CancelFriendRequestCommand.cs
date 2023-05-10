namespace Application.Users.CancelFriendRequest;

public record CancelFriendRequestCommand(Guid UserId, Guid FriendRequestId): IRequest;
