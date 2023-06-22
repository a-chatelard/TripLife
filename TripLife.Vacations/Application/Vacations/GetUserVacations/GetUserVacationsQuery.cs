using WebApi.Models.Result.Vacations;

namespace Application.Vacations.GetUserVacations;
public class GetUserVacationsQuery : IRequest<IEnumerable<VacationResult>>
{
    public Guid RequesterId { get; }

    public GetUserVacationsQuery(Guid requesterId)
    {
        RequesterId = requesterId;
    }
}
