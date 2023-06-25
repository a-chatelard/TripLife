using WebApi.Models.Result.Activities;

namespace Application.Activities.GetActivities;
public class GetActivitiesQuery : IRequest<IEnumerable<ActivityResult>>
{
    public Guid VacationId { get; }

    public GetActivitiesQuery(Guid vacationId)
    {
        VacationId = vacationId;
    }
}
