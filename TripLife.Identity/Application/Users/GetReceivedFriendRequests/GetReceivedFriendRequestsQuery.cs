using WebApi.Models.Result.Users;

namespace Application.Users.GetFriendRequests;

public record GetReceivedFriendRequestsQuery(Guid UserId) : IRequest<IEnumerable<FriendRequestResult>>;
