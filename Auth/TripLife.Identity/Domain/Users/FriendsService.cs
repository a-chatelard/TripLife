using Domain.Exceptions;

namespace Domain.Users;

public static class FriendsService
{
    public static void SendFriendRequest(User sender, User recipient)
    {
        var existingFriendship = sender.SentFriendships.FirstOrDefault(u => u.FriendId == recipient.Id);

        if (existingFriendship != null)
        {
            if (existingFriendship.Status is FriendshipStatus.Accepted)
            {
                throw new DomainException("Vous êtes déjà ami avec cet utilisateur.");
            }
            if (existingFriendship.Status is FriendshipStatus.Pending)
            {
                throw new DomainException("Vous avez déjà envoyé une demande d'ami à cet utilisateur.");
            }
        }

        var existingReceivedFriendship = recipient.SentFriendships.FirstOrDefault(u => u.FriendId == sender.Id);

        if (existingReceivedFriendship != null) 
        { 
            if (existingReceivedFriendship.Status is FriendshipStatus.Accepted)
            {
                throw new DomainException("Vous êtes déjà ami avec cet utilisateur.");
            }
            if (existingReceivedFriendship.Status is FriendshipStatus.Pending)
            {
                existingReceivedFriendship.Accept();
                return;
            }
        }

        sender.SendFriendRequest(recipient);
    }
}
