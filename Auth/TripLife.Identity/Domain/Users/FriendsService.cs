using Domain.Exceptions;

namespace Domain.Users;

public class FriendsService
{
    private readonly IUserRepository _userRepository;
    
    public FriendsService(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task SendFriendRequest(Guid senderId, Guid recipientId)
    {
        var sender = await _userRepository.GetUserById(senderId, default) 
            ?? throw new DomainException("Utilisateur non existant.");

        var recipient = await _userRepository.GetUserById(recipientId, default) 
            ?? throw new DomainException("L'utilisateur que vous souhaitez ajouter en ami n'existe pas ou plus.");

        var existingFriendship = sender.SentFriendships.First(u => u.FriendId == recipient.Id);

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

        var existingReceivedFriendship = recipient.SentFriendships.First(u => u.FriendId == sender.Id);

        if (existingReceivedFriendship != null) 
        { 
            if (existingReceivedFriendship.Status is FriendshipStatus.Accepted)
            {
                throw new DomainException("Vous êtes déjà ami avec cet utilisateur.");
            }
            if (existingReceivedFriendship.Status is FriendshipStatus.Pending)
            {
                existingReceivedFriendship.Accept();
            }
        }

        sender.SendFriendRequest(recipient);
    }

    public async Task AcceptFriendRequest(Guid senderId, Guid recipientId)
    {
        var sender = await _userRepository.GetUserById(senderId, default) 
            ?? throw new DomainException("Utilisateur non existant.");

        var recipient = await _userRepository.GetUserById(recipientId, default) 
            ?? throw new DomainException("L'utilisateur que vous souhaitez ajouter en ami n'existe pas ou plus.");

        var 
    }
}
