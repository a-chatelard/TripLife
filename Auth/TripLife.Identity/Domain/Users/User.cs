using Domain.Exceptions;
using Microsoft.AspNetCore.Identity;
using System.Collections.ObjectModel;

namespace Domain.Users;

public class User : IdentityUser<Guid>
{
    private readonly Collection<Friendship> _sentFriendships = new();
    public IReadOnlyCollection<Friendship> SentFriendships { get => _sentFriendships; }

    private readonly Collection<Friendship> _receivedFriendships = new();
    public IReadOnlyCollection<Friendship> ReceivedFriendships { get => _receivedFriendships; }

    private User() { }
    private User(string username, string email) 
    {
        UserName = username;
        Email = email;
    }

    public static User Create(string username, string email)
    {
        return new User(username, email);
    }

    public void SendFriendRequest(User recipient)
    {
        var friendRequest = Friendship.Create(this, recipient);
        _sentFriendships.Add(friendRequest);
    }

    public void AcceptFriendRequest(Guid friendRequestId)
    {
        var friendRequest = _receivedFriendships.First(fr => fr.Id == friendRequestId);
        if (friendRequest != null)
        {
            _friendsRequest.Remove(friendRequest);
            _friends.Add(friendRequest.Sender);
        }
        else
        {

        }
    }

    /*public void DeclineFriendRequest(Guid friendshipId)
    {
        var friendship = _receivedFriendships.First(f => f.Id == friendshipId) 
            ?? throw new DomainException("Pas d'invitation en attente.");
        friendship.Decline();
    }*/
}
