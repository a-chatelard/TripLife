namespace Application.Users.Events.UserCreated;
public class UserCreatedEvent : INotification
{
    public Guid UserId { get; set; }
    public string? Username { get; set; }
}
