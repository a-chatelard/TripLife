using Domain.Exceptions;
using Domain.Users;
using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using WebApi.Models.Result.Users;

namespace Application.Users.GetUserDetails;

public class GetUserDetailsQueryHandler : IRequestHandler<GetUserDetailsQuery, UserDetailsResult>
{
    private readonly ApplicationDbContext _context;

    public GetUserDetailsQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<UserDetailsResult> Handle(GetUserDetailsQuery request, CancellationToken cancellationToken)
    {
        var currentUser = await _context.Users
            .Include(u => u.SentFriendships)
            .Include(u => u.ReceivedFriendships)
            .AsNoTracking()
            .FirstOrDefaultAsync(u => u.Id == request.CurrentUserId, cancellationToken)
            ?? throw new DomainException("Utilisateur non existant.");

        var requestedUser = await _context.Users
            .AsNoTracking()
            .FirstOrDefaultAsync(u => u.Id == request.RequestedUserId, cancellationToken)
            ?? throw new DomainException("Utilisateur non existant.");

        var isFriend = currentUser.SentFriendships.Any(fr => fr.FriendId == requestedUser.Id && fr.Status == FriendshipStatus.Accepted) 
            || currentUser.ReceivedFriendships.Any(fr => fr.UserId == requestedUser.Id && fr.Status == FriendshipStatus.Accepted);

        return new UserDetailsResult(requestedUser.Id, requestedUser.UserName, isFriend);
    }
}
