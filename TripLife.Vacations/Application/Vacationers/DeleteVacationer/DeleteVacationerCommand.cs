namespace Application.Vacationers.DeleteVacationer;
public class DeleteVacationerCommand : IRequest
{
    public Guid VacationId { get; }
    public Guid VacationerId { get; }

    public DeleteVacationerCommand(Guid vacationId, Guid vacationerId)
    {
        VacationId = vacationId;
        VacationerId = vacationerId;
    }
}
