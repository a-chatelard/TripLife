using WebApi.Models.Result.Vacationers;

namespace Application.Vacationers.GetVacationers;
public class GetVacationersQuery : IRequest<IEnumerable<VacationerResult>>
{
    public Guid VacationId { get; }

    public GetVacationersQuery(Guid vacationId)
    {
        VacationId = vacationId;
    }
}
