using WebApi.Models.Result.Invitations;

namespace Application.Invitations.GetPendingVacationInvitation;
public class GetPendingVacationInvitationQuery : IRequest<IEnumerable<InvitationResult>>
{
    public Guid RequesterId { get; }
    public Guid VacationId { get; }
    
    public GetPendingVacationInvitationQuery(Guid requesterId, Guid vacationId)
    {
        RequesterId = requesterId;
        VacationId = vacationId;
    }
}
