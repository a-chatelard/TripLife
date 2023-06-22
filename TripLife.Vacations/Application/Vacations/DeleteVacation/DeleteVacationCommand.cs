namespace Application.Vacations.DeleteVacation;
public class DeleteVacationCommand : IRequest
{
    public Guid RequesterId { get; }
    public Guid VacationId { get; }

    public DeleteVacationCommand(Guid requestId, Guid vacationId)
    {
        RequesterId = requestId;
        VacationId = vacationId;
    }
}
