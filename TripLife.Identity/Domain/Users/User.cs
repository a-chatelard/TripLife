using Microsoft.AspNetCore.Identity;
using System.Collections.ObjectModel;
using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Users;

public class User : IdentityUser<Guid>
{
    private readonly Collection<Friendship> _sentFriendships = new();
    public IReadOnlyCollection<Friendship> SentFriendships { get => _sentFriendships; }

    private readonly Collection<Friendship> _receivedFriendships = new();
    public IReadOnlyCollection<Friendship> ReceivedFriendships { get => _receivedFriendships; }

    internal User() { }

    private User(string username, string email) 
    {
        UserName = username;
        Email = email;
    }

    public static User Create(string username, string email)
    {
        return new User(username, email);
    }

    public Friendship? SendFriendRequest(User recipient)
    {
        var existingFriendship = SentFriendships.FirstOrDefault(u => u.FriendId == recipient.Id);

        if (existingFriendship != null)
        {
            if (existingFriendship.IsConfirmed)
            {
                throw new DomainException("Vous êtes déjà ami avec cet utilisateur.");
            }
            else
            {
                throw new DomainException("Vous avez déjà envoyé une demande d'ami à cet utilisateur.");
            }
        }

        var existingReceivedFriendship = ReceivedFriendships.FirstOrDefault(u => u.FriendId == Id);

        if (existingReceivedFriendship != null)
        {
            if (existingReceivedFriendship.IsConfirmed)
            {
                throw new DomainException("Vous êtes déjà ami avec cet utilisateur.");
            }
            else
            {
                existingReceivedFriendship.Accept();
                return null;
            }
        }

        var friendRequest = Friendship.Create(this, recipient);
        _sentFriendships.Add(friendRequest);
        return friendRequest;
    }

    public void AcceptFriendRequest(Guid friendRequestId)
    {
        var friendRequest = GetReceivedFriendShipById(friendRequestId);

        if (friendRequest.IsConfirmed)
        {
            throw new DomainException("Cette demande d'ami a déjà été acceptée.");
        }

        friendRequest.Accept();
    }

    public void RejectFriendRequest(Guid friendRequestId)
    {
        var friendRequest = GetReceivedFriendShipById(friendRequestId);

        if (friendRequest.IsConfirmed)
        {
            throw new DomainException("Cette demande d'ami n'est pas en attente.");
        }

        _receivedFriendships.Remove(friendRequest);
    }

    public void CancelFriendRequest(Guid friendRequestId)
    {
        var friendRequest = GetSentFriendshipById(friendRequestId);

        if (friendRequest.IsConfirmed)
        {
            throw new DomainException("Cette demande d'ami n'est pas en attente.");
        }

        _sentFriendships.Remove(friendRequest);
    }

    public void RemoveFriendship(Guid userId)
    {
        var sentFriendship = _sentFriendships.FirstOrDefault(fr => fr.FriendId == userId);
        if (sentFriendship != null)
        {
            _sentFriendships.Remove(sentFriendship);
        }

        var received = _receivedFriendships.FirstOrDefault(fr => fr.UserId == userId);
        if (received != null)
        {
            _receivedFriendships.Remove(received);
        }
    }

    private Friendship GetSentFriendshipById(Guid friendRequestId)
    {
        return _sentFriendships.FirstOrDefault(fr => fr.Id == friendRequestId)
            ?? throw new DomainException("Demande d'ami non existante.");
    }

    private Friendship GetReceivedFriendShipById(Guid friendRequestId)
    {
        return _receivedFriendships.FirstOrDefault(fr => fr.Id == friendRequestId)
            ?? throw new DomainException("Demande d'ami non existante.");
    }
}
