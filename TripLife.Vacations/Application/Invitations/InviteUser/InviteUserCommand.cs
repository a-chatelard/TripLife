using WebApi.Models.Request.Vacationers;

namespace Application.Invitations.InviteUser;
public class InviteUserCommand : IRequest<Guid>
{
    public Guid RequesterId { get; }
    public Guid VacationId { get; }
    public Guid UserId { get; }

    public InviteUserCommand(Guid requestId, Guid vacationId, VacationerRequest request)
    {
        RequesterId = requestId;
        VacationId = vacationId;
        UserId = request.UserId;
    }
}
