using Domain.Users;
using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using WebApi.Models.Result.Users;

namespace Application.Users.GetSentFriendRequests;

public class GetSentFriendRequestsQueryHandler: IRequestHandler<GetSentFriendRequestsQuery, IEnumerable<FriendRequestResult>>
{
    private readonly ApplicationDbContext _context;

    public GetSentFriendRequestsQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<FriendRequestResult>> Handle(GetSentFriendRequestsQuery request, CancellationToken cancellationToken)
    {
        return await _context.Friendships
            .Where(fr => fr.UserId == request.UserId && fr.Status == FriendshipStatus.Pending)
            .Include(fr => fr.Friend)
            .AsNoTracking()
            .Select(fr => new FriendRequestResult(fr.Id, fr.Friend.UserName))
            .ToListAsync(cancellationToken);
    }
}
