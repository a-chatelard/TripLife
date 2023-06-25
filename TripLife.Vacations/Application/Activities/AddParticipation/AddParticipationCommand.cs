namespace Application.Activities.AddParticipation;
public class AddParticipationCommand : IRequest
{
    public Guid RequesterId { get; }
    public Guid VacationId { get; }
    public Guid ActivityId { get; }

    public AddParticipationCommand(Guid requesterId, Guid vacationId, Guid activityId)
    {
        RequesterId = requesterId;
        VacationId = vacationId;
        ActivityId = activityId;
    }
}
