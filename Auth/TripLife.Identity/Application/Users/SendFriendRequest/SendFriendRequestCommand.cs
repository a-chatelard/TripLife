using WebApi.Models.Request.Users;

namespace Application.Users.SendFriendRequest
{
    public class SendFriendRequestCommand : IRequest
    {
        public Guid SenderUserId { get; }

        public Guid RecipientUserId { get; }

        public SendFriendRequestCommand(Guid senderUserId, FriendRequest request)
        {
            SenderUserId = senderUserId;
            RecipientUserId = request.RecipientUserId;
        }
    }
}
