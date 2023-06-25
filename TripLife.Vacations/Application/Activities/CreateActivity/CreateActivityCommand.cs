using WebApi.Models.Request.Activities;

namespace Application.Activities.CreateActivity;
public class CreateActivityCommand : IRequest<Guid>
{
    public Guid RequesterId { get; }
    public Guid VacationId { get; }

    public ActivityRequest Activity { get; }

    public CreateActivityCommand(Guid requesterId, Guid vacationId, ActivityRequest activity)
    {
        RequesterId = requesterId;
        VacationId = vacationId;
        Activity = activity;
    }
}
