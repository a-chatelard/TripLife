using WebApi.Models.Events.Auth;

namespace Application.Auth.Events;
public interface IUserCreatedEmitter
{
    Task EmitAsync(UserCreatedEvent message);
}
