namespace Application.Invitations.CancelInvitation;
public class CancelInvitationCommand : IRequest
{
    public Guid RequesterId { get; }
    public Guid VacationId { get; }
    public Guid VacationerId { get; }

    public CancelInvitationCommand(Guid requesterId, Guid vacationId, Guid vacationerId)
    {
        RequesterId = requesterId;
        VacationId = vacationId;
        VacationerId = vacationerId;
    }
}
