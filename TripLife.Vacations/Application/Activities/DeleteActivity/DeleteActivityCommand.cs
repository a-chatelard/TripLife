namespace Application.Activities.DeleteActivity;
public class DeleteActivityCommand : IRequest
{
    public Guid RequesterId { get; }
    public Guid VacationId { get; }
    public Guid ActivityId { get; }

    public DeleteActivityCommand(Guid requesterId, Guid vacationId, Guid activityId)
    {
        RequesterId = requesterId;
        VacationId = vacationId;
        ActivityId = activityId;
    }
}
