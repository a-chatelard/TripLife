﻿using Domain.Exceptions;
using Microsoft.AspNetCore.Identity;
using System.Collections.ObjectModel;

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

    public Friendship SendFriendRequest(User recipient)
    {
        var friendRequest = Friendship.Create(this, recipient);
        _sentFriendships.Add(friendRequest);
        return friendRequest;
    }

    public void AcceptFriendRequest(Guid friendRequestId)
    {
        var friendRequest = GetFriendshipById(friendRequestId);

        if (friendRequest.Status is not FriendshipStatus.Pending)
        {
            throw new DomainException("Cette demande d'ami n'est pas en attente.");
        }

        friendRequest.Accept();
    }

    public void RejectFriendRequest(Guid friendRequestId)
    {
        var friendRequest = GetFriendshipById(friendRequestId);

        if (friendRequest.Status is not FriendshipStatus.Pending)
        {
            throw new DomainException("Cette demande d'ami n'est pas en attente.");
        }

        _receivedFriendships.Remove(friendRequest);
    }

    public void CancelFriendRequest(Guid friendRequestId)
    {
        var friendRequest = GetFriendshipById(friendRequestId);

        if (friendRequest.Status is not FriendshipStatus.Pending)
        {
            throw new DomainException("Cette demande d'ami n'est pas en attente.");
        }

        _sentFriendships.Remove(friendRequest);
    }

    public void RemoveFriendship(Guid userId)
    {
        var sentFriendship = _sentFriendships.First(fr => fr.FriendId == userId);
        if (sentFriendship != null)
        {
            _sentFriendships.Remove(sentFriendship);
        }

        var received = _receivedFriendships.First(fr => fr.UserId == userId);
        if (received != null)
        {
            _receivedFriendships.Remove(received);
        }
    }

    private Friendship GetFriendshipById(Guid friendRequestId)
    {
        return _sentFriendships.FirstOrDefault(fr => fr.Id == friendRequestId)
            ?? throw new DomainException("Demande d'ami non existante.");
    }
}
