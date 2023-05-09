using WebApi.Models.Request.Users;

namespace Application.Users.SendFriendRequest
{
    public record SendFriendRequestCommand(Guid SenderId, Guid RecipientId) : IRequest
    {
        public SendFriendRequestCommand(Guid senderId, FriendRequest request): this(senderId, request.RecipientId)
        {
            SenderId = senderId;
            RecipientId = request.RecipientId;
        }
    }
}
