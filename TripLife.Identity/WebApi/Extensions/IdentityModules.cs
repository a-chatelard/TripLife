using Domain.Users;
using Infrastructure.Context;

namespace WebApi.Extensions;

public static class IdentityModules
{
    public static IServiceCollection AddIdentityModules(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddIdentityCore<User>(options => {
                options.SignIn.RequireConfirmedAccount = false;
                options.User.RequireUniqueEmail = true;
                options.Password.RequireDigit = true;
                options.Password.RequiredLength = 6;
                options.Password.RequireNonAlphanumeric = true;
                options.Password.RequireUppercase = true;
                options.Password.RequireLowercase = true; 
            })
            .AddEntityFrameworkStores<ApplicationDbContext>();

        return services;
    }
}
