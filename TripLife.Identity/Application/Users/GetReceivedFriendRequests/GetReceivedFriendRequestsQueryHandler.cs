using Domain.Users;
using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using WebApi.Models.Result.Users;

namespace Application.Users.GetFriendRequests;

public class GetReceivedFriendRequestsQueryHandler : IRequestHandler<GetReceivedFriendRequestsQuery, IEnumerable<FriendRequestResult>>
{
    private readonly ApplicationDbContext _context;

    public GetReceivedFriendRequestsQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<FriendRequestResult>> Handle(GetReceivedFriendRequestsQuery request, CancellationToken cancellationToken)
    {
        return await _context.Friendships
            .Where(fr => fr.FriendId == request.UserId && !fr.IsConfirmed)
            .Include(fr => fr.User)
            .AsNoTracking()
            .Select(fr => new FriendRequestResult(fr.Id, fr.User.UserName))
            .ToListAsync(cancellationToken);
    }
}
