namespace Domain.Users;

public interface IUserRepository
{
    Task<Guid> CreateUser(User user, CancellationToken cancellationToken);

    Task DeleteUser(User user, CancellationToken cancellationToken);

    Task<User?> GetUserById(Guid id, CancellationToken cancellationToken);

    Task UpdateUser(User user, CancellationToken cancellationToken);
}
