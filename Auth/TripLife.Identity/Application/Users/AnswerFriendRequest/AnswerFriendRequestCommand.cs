using WebApi.Models.Request.Users;

namespace Application.Users.AnswerFriendRequest;

public record AnswerFriendRequestCommand(Guid UserId, Guid FriendRequestId, bool Answer) : IRequest
{
    public AnswerFriendRequestCommand(Guid requesterId, Guid friendRequestId, FriendRequestAnswer request)
        : this(requesterId, friendRequestId, request.Answer)
    {
    }
}
