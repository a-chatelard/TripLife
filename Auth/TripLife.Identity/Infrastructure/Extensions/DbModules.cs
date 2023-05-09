using Domain.Auth;
using Domain.Users;
using Infrastructure.Context;
using Infrastructure.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure.Extensions;

public static class DbModules
{
    public static IServiceCollection AddDatabaseModules(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddDbContext<ApplicationDbContext>(options =>
        {
            options.UseNpgsql(configuration.GetConnectionString("PostgreSQL"));
        });

        services.AddScoped<IAuthRepository, AuthRepository>();

        services.AddScoped<IUserRepository, UserRepository>();

        return services;
    }
}
