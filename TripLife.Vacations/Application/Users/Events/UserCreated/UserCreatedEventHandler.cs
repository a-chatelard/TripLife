using Domain.Users;

namespace Application.Users.Events.UserCreated;

public class UserCreatedEventHandler : INotificationHandler<UserCreatedEvent>
{
    private readonly IUserRepository _repository;

    public UserCreatedEventHandler(IUserRepository repository)
    {
        _repository = repository;
    }

    public async Task Handle(UserCreatedEvent notification, CancellationToken cancellationToken)
    {
        var user = User.Create(notification.UserId, notification.Username);

        await _repository.CreateUser(user, cancellationToken);
    }
}
