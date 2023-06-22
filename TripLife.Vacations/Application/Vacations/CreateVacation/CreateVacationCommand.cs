using WebApi.Models.Request.Vacations;

namespace Application.Vacations.CreateVacation;

public class CreateVacationCommand : IRequest<Guid>
{
    public Guid RequesterId { get; }
    public VacationRequest Vacation { get; } 

    public CreateVacationCommand(Guid requesterId, VacationRequest vacation)
    {
        RequesterId = requesterId;
        Vacation = vacation;
    }
}
