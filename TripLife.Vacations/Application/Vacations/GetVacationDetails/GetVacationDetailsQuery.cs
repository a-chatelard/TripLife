using WebApi.Models.Result.Vacations;

namespace Application.Vacations.GetVacationDetails;
public class GetVacationDetailsQuery : IRequest<VacationDetailsResult>
{
    public Guid VacationId { get; }

    public GetVacationDetailsQuery(Guid vacationId)
    {
        VacationId = vacationId;
    }
}
