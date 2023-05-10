using WebApi.Models.Result.Users;

namespace Application.Users.GetUserDetails;

public record GetUserDetailsQuery(Guid CurrentUserId, Guid RequestedUserId): IRequest<UserDetailsResult>;
