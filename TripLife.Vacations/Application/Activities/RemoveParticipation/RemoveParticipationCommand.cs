namespace Application.Activities.RemoveParticipation;
public class RemoveParticipationCommand : IRequest
{
    public Guid RequesterId { get; }
    public Guid VacationId { get; }
    public Guid ActivityId { get; }

    public RemoveParticipationCommand(Guid requesterId, Guid vacationId, Guid activityId)
    {
        RequesterId = requesterId;
        VacationId = vacationId;
        ActivityId = activityId;
    }
}
