namespace Domain.Users;

public class Friendship
{
    public Guid Id { get; set; }

    public Guid UserId { get; }
    public User User { get; }
    
    public Guid FriendId { get; }
    public User Friend { get; }

    public FriendshipStatus Status { get; private set; }

    internal Friendship()
    {
        
    }

    private Friendship(User user, User friend)
    {
        User = user;
        Friend = friend;
        Status = FriendshipStatus.Pending;
    }

    public static Friendship Create(User user, User friend)
    {
        return new Friendship(user, friend);
    }

    public void Accept()
    {
        Status = FriendshipStatus.Accepted;
    }

    public void Decline()
    {
        Status = FriendshipStatus.Declined;
    }
}
