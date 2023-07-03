using WebApi.Models.Result.Users;

namespace Application.Users.GetConnectedUserDetails;
public class GetConnectedUserDetailsQuery : IRequest<ConnectedUserResult>
{
    public Guid RequesterId { get; }

    public GetConnectedUserDetailsQuery(Guid requesterId)
    {
        RequesterId = requesterId;
    }
}
