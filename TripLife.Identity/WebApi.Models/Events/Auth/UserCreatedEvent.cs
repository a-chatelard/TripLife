namespace WebApi.Models.Events.Auth;

public class UserCreatedEvent
{
    public Guid UserId { get; }
    public string? Username { get; }

    public UserCreatedEvent(Guid userId, string? username)
    {
        UserId = userId;
        Username = username;
    }
}
