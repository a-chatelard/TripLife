using WebApi.Models.Request.Invitations;

namespace Application.Invitations.AnswerInvitation;
public class AnswerInvitationCommand : IRequest
{
    public Guid RequesterId { get; }
    public Guid VacationId { get; }
    public Guid VacationerId { get; }
    public bool Answer { get; }

    public AnswerInvitationCommand(Guid requesterId, Guid vacationId, Guid vacationerId, InvitationAnswerRequest request)
    {
        VacationId = vacationId;
        VacationerId = vacationerId;
        Answer = request.Answer;
    }
}
