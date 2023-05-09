using Domain.Users;
using Microsoft.AspNetCore.Identity;

namespace Domain.Auth;

public interface IAuthRepository
{
    Task<bool> CheckPassword(User user, string password);
    Task<IdentityResult?> CreateUser(User user, string password);
    Task<User?> GetUserByEmail(string email);
}
