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
/*
    private IReadOnlyCollection<User> Friends { get 
        {
            return _sentFriendships
                .Select(sf => sf.Friend).ToList()
                .Concat(_receivedFriendships.Select(rf => rf.User))
                .ToImmutableList();
        } 
    }
*/
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

    public Friendship SendFriendRequest(User recipient)
    {
        var friendRequest = Friendship.Create(this, recipient);
        _sentFriendships.Add(friendRequest);
        return friendRequest;
    }

    public void AcceptFriendRequest(Guid friendRequestId)
    {
        var friendRequest = _receivedFriendships.FirstOrDefault(fr => fr.Id == friendRequestId)
            ?? throw new DomainException("Demande d'ami non existante.");
        
        if (friendRequest.Status is not FriendshipStatus.Pending)
        {
            throw new DomainException("Cette demande d'ami n'est pas en attente.");
        }

        friendRequest.Accept();
    }

    public void RejectFriendRequest(Guid friendRequestId)
    {
        var friendRequest = _receivedFriendships.FirstOrDefault(fr => fr.Id == friendRequestId)
            ?? throw new DomainException("Demande d'ami non existante.");

        if (friendRequest.Status is not FriendshipStatus.Pending)
        {
            throw new DomainException("Cette demande d'ami n'est pas en attente.");
        }

        _receivedFriendships.Remove(friendRequest);
    }

    public void CancelFriendRequest(Guid friendRequestId)
    {
        var friendRequest = _sentFriendships.FirstOrDefault(fr => fr.Id == friendRequestId)
            ?? throw new DomainException("Demande d'ami non existante.");

        if (friendRequest.Status is not FriendshipStatus.Pending)
        {
            throw new DomainException("Cette demande d'ami n'est pas en attente.");
        }

        _sentFriendships.Remove(friendRequest);
    }
}
