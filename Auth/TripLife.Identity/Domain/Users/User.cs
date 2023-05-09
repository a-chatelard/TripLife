using Domain.Exceptions;
using Microsoft.AspNetCore.Identity;
using System.Collections.Immutable;
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

    public void SendFriendRequest(User recipient)
    {
        var friendRequest = Friendship.Create(this, recipient);
        _sentFriendships.Add(friendRequest);
    }

    public void AcceptFriendRequest(Friendship friendship)
    {
        friendship.Accept();
    }

    public void RejectFriendRequest(Friendship friendship)
    {
        _receivedFriendships.Remove(friendship);
    }
}
