namespace Application.Users.Events.UserCreated;

public class UserCreatedEventHandler : INotificationHandler<UserCreatedEvent>
{
    public Task Handle(UserCreatedEvent notification, CancellationToken cancellationToken)
    {
        Console.WriteLine(notification);
        return Task.CompletedTask;
    }
}
