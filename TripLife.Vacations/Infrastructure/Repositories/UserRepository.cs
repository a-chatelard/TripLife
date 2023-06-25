using Domain.Users;
using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Repositories;
public class UserRepository : IUserRepository
{
    private readonly ApplicationDbContext _context;

    public UserRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Guid> CreateUser(User user, CancellationToken cancellationToken)
    {
        _context.Add(user);
        await _context.SaveChangesAsync(cancellationToken);
        return user.Id;
    }

    public async Task DeleteUser(User user, CancellationToken cancellationToken)
    {
        _context.Remove(user);
        await _context.SaveChangesAsync(cancellationToken);
    }

    public Task<User?> GetUserById(Guid id, CancellationToken cancellationToken)
    {
        return _context.Users
            .FirstOrDefaultAsync(u => u.Id == id, cancellationToken);
    }
}
