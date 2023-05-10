using WebApi.Models.Request.Users;

namespace Application.Users.SendFriendRequest
{
    public record SendFriendRequestCommand(Guid UserId, Guid RecipientId) : IRequest<Guid?>
    {
        public SendFriendRequestCommand(Guid userId, FriendRequest request): this(userId, request.RecipientId)
        {
        }
    }
}
