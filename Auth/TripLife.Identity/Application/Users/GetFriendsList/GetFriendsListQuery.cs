using WebApi.Models.Result.Users;

namespace Application.Users.GetFriendsList;

public record GetFriendsListQuery(Guid UserId) : IRequest<IEnumerable<UserResult>>;
