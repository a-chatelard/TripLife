using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using TripLife.Foundation.Domain.Exceptions;
using WebApi.Models.Result.Users;

namespace Application.Users.GetConnectedUserDetails;
public class GetConnectedUserDetailsQueryHandler : IRequestHandler<GetConnectedUserDetailsQuery, ConnectedUserResult>
{
    private readonly ApplicationDbContext _context;

    public GetConnectedUserDetailsQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<ConnectedUserResult> Handle(GetConnectedUserDetailsQuery request, CancellationToken cancellationToken)
    {
        var user = await _context.Users.SingleOrDefaultAsync(u => u.Id == request.RequesterId, cancellationToken)
            ?? throw new DomainException("L'utilisateur n'a pas été trouvé.");

        return new ConnectedUserResult(user.Id, user.UserName, user.Email);
    }
}
