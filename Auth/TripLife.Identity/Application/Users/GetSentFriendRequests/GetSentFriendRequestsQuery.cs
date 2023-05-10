using WebApi.Models.Result.Users;

namespace Application.Users.GetSentFriendRequests;

public record GetSentFriendRequestsQuery(Guid UserId) : IRequest<IEnumerable<FriendRequestResult>>;
