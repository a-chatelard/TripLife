using Domain.Users;
using Domain.Vacations;
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

        services.AddScoped<IVacationRepository, VacationRepository>();
        services.AddScoped<IUserRepository, UserRepository>();

        return services;
    }
}
