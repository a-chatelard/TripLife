namespace Application.Users.UserCreated;
public class UserCreatedEvent : INotification
{
    public Guid UserId { get; }
    public string? Username { get; }
}
