using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using WebApi.Models.Result.Users;

namespace Application.Users.GetUserByUsername;
public class GetUserByUsernameQueryHandler : IRequestHandler<GetUserByUsernameQuery, UserResult?>
{
    private readonly ApplicationDbContext _context;

    public GetUserByUsernameQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<UserResult?> Handle(GetUserByUsernameQuery request, CancellationToken cancellationToken)
    {
        var user = await _context.Users
            .AsNoTracking()
            .FirstOrDefaultAsync(u => u.UserName.Equals(request.Username), cancellationToken);

        return user != null ? new UserResult(user.Id, user.UserName) : null;
    }
}
