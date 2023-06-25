using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using WebApi.Models.Result;
using WebApi.Models.Result.Activities;

namespace Application.Activities.GetActivities;
public class GetActivitiesQueryHandler : IRequestHandler<GetActivitiesQuery, IEnumerable<ActivityResult>>
{
    private readonly ApplicationDbContext _context;

    public GetActivitiesQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<ActivityResult>> Handle(GetActivitiesQuery request, CancellationToken cancellationToken)
    {
        var activities = await _context.Activities.Where(a => a.VacationId == request.VacationId).AsNoTracking().ToListAsync(cancellationToken);

        return activities.Select(a => new ActivityResult(
            a.Id,
            a.Label,
            a.Description,
            a.Period.StartDate,
            a.Period.EndDate,
            a.EstimatedPrice?.Amount,
            a.Address != null ? new AddressResult(a.Address.Street, a.Address.City, a.Address.State, a.Address.Country, a.Address.City) : null));
    }
}
