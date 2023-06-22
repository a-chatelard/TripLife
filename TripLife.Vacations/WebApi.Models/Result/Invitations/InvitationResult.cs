using WebApi.Models.Result.Users;
using WebApi.Models.Result.Vacations;

namespace WebApi.Models.Result.Invitations;
public class InvitationResult
{
    public Guid VacationerId { get; }
    public UserResult User { get; }
    public VacationResult Vacation { get; }

    public InvitationResult(Guid vacationerId, UserResult user, VacationResult vacation)
    {
        VacationerId = vacationerId;
        User = user;
        Vacation = vacation;
    }
}
