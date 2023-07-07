using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using WebApi.Models.Result.Vacations;

namespace Application.Vacations.GetUserVacations;
public class GetUserVacationsQueryHandler : IRequestHandler<GetUserVacationsQuery, IEnumerable<VacationResult>>
{
    private readonly ApplicationDbContext _context;

    public GetUserVacationsQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }
    public async Task<IEnumerable<VacationResult>> Handle(GetUserVacationsQuery request, CancellationToken cancellationToken)
    {
        return await _context.Vacations
            .Include(v => v.Vacationers)
            .Where(v => v.Vacationers.Any(v => v.UserId == request.RequesterId && v.IsConfirmed))
            .AsNoTracking()
            .Select(v => new VacationResult(v.Id, v.Label, v.Period.StartDate, v.Period.EndDate, v.Vacationers.First(v => v.UserId == request.RequesterId).IsOwner))
            .ToListAsync(cancellationToken);
    }
}