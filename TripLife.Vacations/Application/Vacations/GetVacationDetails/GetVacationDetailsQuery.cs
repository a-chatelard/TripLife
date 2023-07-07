using WebApi.Models.Result.Vacations;

namespace Application.Vacations.GetVacationDetails;
public class GetVacationDetailsQuery : IRequest<VacationDetailsResult>
{
    public Guid VacationId { get; }
    public Guid RequesterId { get; }

    public GetVacationDetailsQuery(Guid requesterId, Guid vacationId)
    {
        RequesterId = requesterId;
        VacationId = vacationId;
    }
}
