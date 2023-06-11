namespace Domain.Users;

public class Friendship
{
    public Guid Id { get; }

    public Guid UserId { get; }
    public User User { get; } = default!;
    
    public Guid FriendId { get; }
    public User Friend { get; } = default!;

    public bool IsConfirmed { get; private set; }

    internal Friendship()
    {
        
    }

    private Friendship(User user, User friend)
    {
        User = user;
        Friend = friend;
        IsConfirmed = false;
    }

    public static Friendship Create(User user, User friend)
    {
        return new Friendship(user, friend);
    }

    public void Accept()
    {
        IsConfirmed = true;
    }
}
