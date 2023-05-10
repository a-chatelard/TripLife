namespace Application.Users.RemoveFriend;

public record RemoveFriendCommand(Guid userId, Guid friendId) : IRequest;