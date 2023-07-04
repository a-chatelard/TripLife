using WebApi.Models.Result.Invitations;

namespace Application.Invitations.GetUserVacationInvitations;
public class GetUserVacationInvitationsQuery : IRequest<IEnumerable<InvitationResult>>
{
    public Guid RequesterId { get; }

    public GetUserVacationInvitationsQuery(Guid requesterId)
    {
        RequesterId = requesterId;
    }
}
