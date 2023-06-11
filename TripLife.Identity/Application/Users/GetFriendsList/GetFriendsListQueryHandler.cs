using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using WebApi.Models.Result.Users;

namespace Application.Users.GetFriendsList;

public class GetFriendsListQueryHandler : IRequestHandler<GetFriendsListQuery, IEnumerable<UserResult>>
{
    private readonly ApplicationDbContext _context;

    public GetFriendsListQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<UserResult>> Handle(GetFriendsListQuery request, CancellationToken cancellationToken)
    {
        var friends = await _context.Friendships
            .Where(fr => (fr.UserId == request.UserId || fr.FriendId == request.UserId) 
                && fr.IsConfirmed)
            .Include(fr => fr.User)
            .Include(fr => fr.Friend)
            .AsNoTrackingWithIdentityResolution()
            .ToListAsync(cancellationToken);

        var sentFriends = friends.Where(fr => fr.UserId != request.UserId)
            .Select(fr => new UserResult(fr.User.Id, fr.User.UserName))
            .ToList();

        var receivedFriends = friends.Where(fr => fr.FriendId != request.UserId)
            .Select(fr => new UserResult(fr.Friend.Id, fr.Friend.UserName))
            .ToList();

        return sentFriends.Concat(receivedFriends);
    }
}
