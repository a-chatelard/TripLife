using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using WebApi.Models.Result.Vacationers;

namespace Application.Vacationers.GetVacationers;
public class GetVacationersQueryHandler : IRequestHandler<GetVacationersQuery, IEnumerable<VacationerResult>>
{
    private readonly ApplicationDbContext _context;

    public GetVacationersQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<VacationerResult>> Handle(GetVacationersQuery request, CancellationToken cancellationToken)
    {
        return await _context.Vacationers
            .Where(v => v.VacationId == request.VacationId && v.IsConfirmed)
            .Include(v => v.User)
            .AsNoTracking()
            .Select(v => new VacationerResult(v.Id, v.VacationId, v.User.Id, v.User.Username, v.IsOwner))
            .ToListAsync(cancellationToken);
    }
}
